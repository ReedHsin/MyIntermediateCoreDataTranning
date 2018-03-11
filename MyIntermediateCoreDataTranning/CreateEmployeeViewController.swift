//
//  CreateEmployeeViewController.swift
//  MyIntermediateCoreDataTranning
//
//  Created by 辛忠翰 on 10/03/18.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit
class CreateEmployeeViewController: UIViewController{
    let createEmployeeView: CreateEmployeeView = {
       var cev = CreateEmployeeView()
        return cev
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.tealColor
        setupNavigationBar()
        setupViews()
    }
    
    fileprivate func setupViews(){
        view.addSubview(createEmployeeView)
        createEmployeeView.anchor(top: view.topAnchor, bottom: nil, left: view.leftAnchor, right: view.rightAnchor, topPadding: 0, bottomPadding: 0, leftPadding: 0, rightPadding: 0, width: 0, height: 150)
    }
    
    fileprivate func setupNavigationBar(){
        navigationItem.title = "Create Employee"
        setupLeftNavigationItemByTitle(title: "Cancel", selector: #selector(handleCancelButton))
        setupRightNavigationItemByTitle(title: "Save", selector:  #selector(handleSaveButton))
    }
    
    @objc private func handleCancelButton(){
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func handleSaveButton(){
        guard let name = createEmployeeView.nameTextField.text else {return}
        let date = createEmployeeView.datePicker.date
        let error = CoreDataManager.shared.saveEmployeeData(name: name, birthday: date) { (employee) in
            dismiss(animated: true, completion: {
                
            })
        }
        if let error = error{
            //is where u present error modal of some kind
            //perhaps use a UIAlertController to show ur error message
            print(error)
        }
    }
}
