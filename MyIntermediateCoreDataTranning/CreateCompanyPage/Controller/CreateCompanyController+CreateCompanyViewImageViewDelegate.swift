//
//  CreateCompanyController+CreateCompanyViewImageViewDelegate.swift
//  MyIntermediateCoreDataTranning
//
//  Created by 辛忠翰 on 10/03/18.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit
extension CreateCompanyController: CreateCompanyViewImageViewDelegate{
    func presentImgPicker() {
        let imgPickerController = UIImagePickerController()
        imgPickerController.delegate = self
        imgPickerController.allowsEditing = true
        present(imgPickerController, animated: true, completion: nil)
    }
}
