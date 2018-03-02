//
//  CreateCompanyController.swift
//  MyIntermediateCoreDataTranning
//
//  Created by 辛忠翰 on 01/03/18.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit
protocol CreateCompanyControllerDelegate {
    func didAddCompany(company: Company)
}


class CreateCompanyController: UIViewController {
    let createCompanyView = CreateCompanyView()
    var delegate: CreateCompanyControllerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.darkBlueColor
        setupCreateCompanyNaviBar()
        setupViews()
    }
}











extension CreateCompanyController{
    fileprivate func setupCreateCompanyNaviBar(){
        navigationItem.title = "Create Company"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancelItem))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(handleSaveItem))
    }
    
    @objc func handleCancelItem(){
        print("Tap cancel button...")
    }
    
    @objc func handleSaveItem(){
        dismiss(animated: true){
            let company = Company(name: self.createCompanyView.fetchNameTextFieldText(), founded: Date())
            self.delegate?.didAddCompany(company: company)
        }
        
    }
    
    fileprivate func setupViews(){
        view.addSubview(createCompanyView)
        createCompanyView.anchor(top: view.topAnchor, bottom: nil, left: view.leftAnchor, right: view.rightAnchor, topPadding: 0, bottomPadding: 0, leftPadding: 0, rightPadding: 0, width: 0, height: view.frame.height*2/3)
        
    }
}

