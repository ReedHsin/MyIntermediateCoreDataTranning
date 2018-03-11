//
//  FileCreateCompanyController+UINavigationControllerDelegate+UIImagePickerControllerDelegate.swift
//  MyIntermediateCoreDataTranning
//
//  Created by 辛忠翰 on 10/03/18.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit
extension CreateCompanyController: UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    //在IOS10後，都要詢問使用者才可以去得使用手機相簿的權限
    //info.plist ->
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        //我們可以加入 imgPickerController.allowsEditing = true 來縮放照片，也就是我們的editedImg
        if let editedImg = info[UIImagePickerControllerEditedImage] as? UIImage{
            createCompanyView.profileImg = editedImg
        }else if let originalImg = info[UIImagePickerControllerOriginalImage] as? UIImage {
            createCompanyView.profileImg = originalImg
        }
        dismiss(animated: true, completion: nil)
    }
    
}
