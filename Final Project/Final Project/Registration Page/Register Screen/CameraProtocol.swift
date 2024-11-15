//
//  CameraProtocol.swift
//  Final Project
//
//  Created by YHY on 11/14/24.
//
import UIKit
import PhotosUI

extension RegisterViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    //camera protocol - UIImagePickerController
    func imagePickerController(_ picker: UIImagePickerController, didFinishPiclingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        picker.dismiss(animated: true)
        
        if let image = info[.editedImage] as? UIImage{
            self.registerView.buttonTakeSelfie.setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
            self.pickedImage = image
        }
        
    }
}
extension RegisterViewController:PHPickerViewControllerDelegate{
    //gallery protocol - PHPickerViewController protocol
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        dismiss(animated: true)
        
        print(results)
        
        let itemprovider = results.map(\.itemProvider)
        
        for item in itemprovider{
            if item.canLoadObject(ofClass: UIImage.self){
                item.loadObject(ofClass: UIImage.self, completionHandler: { (image, error) in
                    DispatchQueue.main.async{
                        if let uwImage = image as? UIImage{
                            self.registerView.buttonTakeSelfie.setImage(uwImage.withRenderingMode(.alwaysOriginal), for: .normal
                            )
                            self.pickedImage = uwImage
                        }
                    }
                }
            )
            }
        }
    }
}

