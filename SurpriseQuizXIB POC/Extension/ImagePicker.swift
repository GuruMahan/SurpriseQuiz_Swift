//
//  ImagePicker.swift
//  Staff_Attendance
//
//  Created by apple on 10/04/21.
//  Copyright © 2021 adminstrator. All rights reserved.
//

import UIKit

public protocol ImagePickerDelegate: AnyObject {
    func didSelect(image: UIImage?)
}

class ImagePicker: NSObject {
    
    var pickerController = UIImagePickerController()
    var didSelectMedia: ((URL?) -> Void)!
    
    override init() {
        super.init()
    }
    convenience init(didSelectMedia: @escaping ((URL?) -> Void)) {
        
        self.init()
        
        self.didSelectMedia = didSelectMedia
        
        self.pickerController.delegate = self
        self.pickerController.allowsEditing = true
       // self.pickerController.mediaTypes = ["public.image", "public.movie"]
        self.pickerController.sourceType = .photoLibrary
      //  self.pickerController.videoMaximumDuration = TimeInterval(Constants.maxVideoDuration)
    }
    public func present(presentationController: UIViewController) {
        
        presentationController.present(self.pickerController, animated: true)
    }
    
    private func pickerController(_ controller: UIImagePickerController, didSelect url: URL?) {
        
        controller.dismiss(animated: true, completion: { [weak self] in
            self?.didSelectMedia(url)
        })
        
    }
    
}

extension ImagePicker: UIImagePickerControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.pickerController(picker, didSelect: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        
        if let url = info[.originalImage] as? URL {
            let splitArr = url.lastPathComponent.components(separatedBy: ".")
            let fileExtension = splitArr.last ?? ""
            let fileName = splitArr.dropLast().last ?? ""
            
            //  let fileManager = FileManagerNew()
            //            fileManager.createDirectory(directoryName: "Attachments")
            //            let newUrl = fileManager.copyFileToDirectory(fileName: "\(fileName).\(fileExtension)", toDir: "Attachments", fromDir: url)
            //            self.pickerController(picker, didSelect: newUrl)
            //        } else if let url = info[.imageURL] as? URL {
            //            let fileName = url.lastPathComponent
            //         //   let fileManager = FileManagerNew()
            //            fileManager.createDirectory(directoryName: "Attachments")
            //            let newUrl = fileManager.moveFileToDirectory(fileName: fileName, toDir: "Attachments", fromDir: url)
            //            self.pickerController(picker, didSelect: newUrl)
            //        }  else {
            //            self.pickerController(picker, didSelect: nil)
            //        }
            
        }
    }
}
extension ImagePicker: UINavigationControllerDelegate {

}
