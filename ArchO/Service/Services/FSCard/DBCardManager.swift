//
//  FirestoreDB.swift
//  ArchO
//
//  Created by Tixon Markin on 30.06.2023.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseStorage

protocol DBCardManagerProtocol {
    func loadCardToDB(_ data: CardData, completion: @escaping (Bool) -> ())
}

class DBCardManager: ServiceProtocol {
    var description: String = "FirestoreDB"
    
    private var dbCardQueue = DispatchQueue(label: "com.dbCard.queue", qos: .userInitiated, attributes: .concurrent)
    
    private let db: Firestore = Firestore.firestore()
    private let storage: Storage = Storage.storage()
    private lazy var cardsRef = db.collection("cards")
    private lazy var cardsDataStoreRef = storage.reference().child("cardsData")
    private var cardEncoder: Firestore.Encoder {
        let encoder = Firestore.Encoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return encoder
    }
    
    private var cardDecoder: Firestore.Decoder {
        let decoder = Firestore.Decoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
    
    private func imagesRefFor(_ cardID: String) -> StorageReference {
        cardsDataStoreRef.child(cardID).child("images")
    }
    private func filesRefFor(_ cardID: String) -> StorageReference {
        cardsDataStoreRef.child(cardID).child("files")
    }
    
}

extension DBCardManager: DBCardManagerProtocol {
    func loadCardToDB(_ data: CardData, 
                      completion: @escaping (Bool) -> ()) {
        Task(priority: .high) {
            let cardRef = cardsRef.document()
            
            let attachements = await uploadCardAttachements(cardData: data, cardRef: cardRef)
            let result = await uploadCard(data, toRef: cardRef, attachements: attachements)
            completion(result)
        }
    }
    
    private func uploadCardAttachements(cardData data: CardData, 
                                        cardRef ref: DocumentReference) async -> [ItemID: [String]] {
        let imagesRef = imagesRefFor(ref.documentID)
        let filesRef = filesRefFor(ref.documentID)
        
        async let firstBatch = Task(priority: .userInitiated) { () -> [ItemID: [String]] in
            var urls: [ItemID: [String]] = [:]
            for (key, images) in data.loadViewImages {
                let paths = await uploadImages(images, toDirectory: imagesRef)
                urls[key] = paths
            }
            return urls
        }
        
        async let secondBatch = Task(priority: .userInitiated) { () -> [ItemID: [String]] in
            var urls: [ItemID: [String]] = [:]
            for (key, items) in data.descLoadViewItems {
                let images = items.map { item in
                    return item.image
                }
                let paths = await uploadImages(images, toDirectory: imagesRef)
                urls[key] = paths
            }
            return urls
        }
        
        async let thirdBatch = Task(priority: .userInitiated) { () -> [ItemID: [String]] in
            var urls: [ItemID: [String]] = [:]
            for (key, items) in data.loadViewFiles {
                let paths = await uploadFiles(items, ref: filesRef)
                urls[key] = paths
            }
            return urls
        }
        
        var result = await [firstBatch.value, secondBatch.value, thirdBatch.value]
        var attachementUrls: [ItemID: [String]] = result.reduce(into: [:]) { partialResult, subDictionary in
            subDictionary.forEach { key, value in
                partialResult[key] = value
            }
        }
        return attachementUrls
    }
    
    private func uploadImages(_ images: [UIImage?], 
                              toDirectory ref: StorageReference) async -> [String] {
        let result = await withTaskGroup(of: (Int, String?).self) { group -> [String] in
            for (index, image) in images.enumerated() {
                group.addTask(priority: .userInitiated) {
                    let imageName = await self.uploadImage(image, toDirectory: ref)
                    return (index, imageName)
                }
            }
            var urls = Array<String?>(repeating: nil, count: images.count)
            for await (index, value) in group {
                urls[index] = value
            }
            return urls.compactMap { $0 }
        }
        return result
    }
    
    private func uploadImage(_ image: UIImage?,
                             toDirectory ref: StorageReference) async -> String? {
        guard let imageData = image?.pngData() else { return nil }
        let uniqueID = UUID().uuidString
        var imageName: String? = uniqueID + ".png"
        do {
            let metadata = try await ref.child(imageName!).putDataAsync(imageData)
            imageName = metadata.name!
        } catch {
            print("\n Failure in loading image" + imageName!)
            imageName = nil
        }
        return imageName
    }
    
    private func uploadFiles(_ urls: [URL], 
                             ref: StorageReference) async -> [String] {
        
        return []
    }
    
    private func uploadCard(_ data: CardData, 
                            toRef ref: DocumentReference,
                            attachements: [ItemID: [String]]) async -> Bool {
        var FBCard = FirebaseCard(from: data)
        FBCard.insertAttachements(attachements)
        
        var result = false
        guard let encodedData = try? cardEncoder.encode(FBCard) else { return result }
        do {
            try await ref.setData(encodedData)
            result = true
        } catch {
            print(error.localizedDescription)
        }
        return result
    }
}
