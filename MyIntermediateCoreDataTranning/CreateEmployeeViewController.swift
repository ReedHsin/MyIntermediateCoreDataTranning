//
//  CreateEmployeeViewController.swift
//  MyIntermediateCoreDataTranning
//
//  Created by 辛忠翰 on 10/03/18.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit
class CreateEmployeeViewController: UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.tealColor
        setupNavigationBar()
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
    
    }
}
