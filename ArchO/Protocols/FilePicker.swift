//
//  FilePicker.swift
//  ArchO
//
//  Created by Tixon Markin on 27.11.2023.
//

import Foundation
import UIKit

protocol FilePickerDelegate: AnyObject {
    func filePicker(_ picker: FilePicker, didFinichPickingFiles urls: [URL])
}

class FilePicker: UIResponder, PickerProtocol {
    weak var delegate: FilePickerDelegate?
    var picker: UIDocumentPickerViewController!
    
    private var customNext: UIResponder?
    override var next: UIResponder? {
        return customNext
    }

    init(next: UIResponder) {
        customNext = next
    }
    
    func present(pickLimit limit: Int) {
        picker = UIDocumentPickerViewController(forOpeningContentTypes: [.pdf])
        picker.allowsMultipleSelection = true
        picker.delegate = self
        UIApplication.shared.sendAction(#selector(ResponderAction.showPicker(_:)), to: nil, from: self, for: nil)
    }
}

extension FilePicker: UIDocumentPickerDelegate {
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        delegate?.filePicker(self, didFinichPickingFiles: urls)
    }
}
