//
//  ImagePickerController.swift
//  ArchO
//
//  Created by Tixon Markin on 15.11.2023.
//

import Foundation
import PhotosUI
import UIKit

protocol ImagePickerDelegate: AnyObject {
    func imagePicker(_ picker: ImagePicker, didFinichPicking images: [UIImage])
}

class ImagePicker: UIResponder, PickerProtocol {
    weak var delegate: ImagePickerDelegate?
    var picker: PHPickerViewController!
    
    private var customNext: UIResponder?
    override var next: UIResponder? {
        return customNext
    }

    init(next: UIResponder) {
        customNext = next
    }
    
    func present(pickLimit: Int) {
        var config = PHPickerConfiguration(photoLibrary: .shared())
        config.filter = .images
        config.selectionLimit = pickLimit
        picker = PHPickerViewController(configuration: config)
        picker.delegate = self
        
        UIApplication.shared.sendAction(#selector(ResponderAction.showPicker(_:)), to: nil, from: self, for: nil)
    }
}

extension ImagePicker: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        var images: [UIImage] = []
        
        let group = DispatchGroup()
        results.forEach { result in
            group.enter()
            result.itemProvider.loadObject(ofClass: UIImage.self) { object, error in
                if let image = object as? UIImage {
                    images.append(image)
                }
                group.leave()
            }
        }
        
        group.notify(queue: .main, work: DispatchWorkItem(block: { [weak self] in
            guard let self = self else { return }
            delegate?.imagePicker(self, didFinichPicking: images)
            picker.dismiss(animated: true)
        }))
    }
    
    
}

