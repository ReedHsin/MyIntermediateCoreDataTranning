//
//  CreateCompanyController.swift
//  MyIntermediateCoreDataTranning
//
//  Created by 辛忠翰 on 01/03/18.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit
import CoreData
protocol AddAndEditCompanyDelegate {
    func didAddCompany(company: Company)
    func didEditCompany(company: Company)
}

protocol CreateCompanyControllerPrototcol {
    func setupCreateCompanyNaviBar()
    func setupViews()
}


class CreateCompanyController: UIViewController {
    let createCompanyView = CreateCompanyView()
    var addAndEditDelegate: AddAndEditCompanyDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.darkBlueColor
        createCompanyView.imgViewDelegate = self
        setupCreateCompanyNaviBar()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = createCompanyView.company == nil ? "Create Company" : "Edit Company"
    }
}







extension CreateCompanyController: CreateCompanyControllerPrototcol{
    internal func setupCreateCompanyNaviBar(){
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancelItem))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(handleSaveItem))
    }
    
    @objc func handleCancelItem(){
        dismiss(animated: true, completion: nil)
    }
    
    @objc func handleSaveItem(){
        let company = createCompanyView.company
        if company == nil{
            createNewCompanyIntoCoreData()
        }else {
            editCompanyInCoreData()
        }
    }
    
    fileprivate func createNewCompanyIntoCoreData(){
        let companyName = createCompanyView.fetchNameTextFieldText()
        let foundedDate = createCompanyView.fetchFoundedDate()
        let profileImg = createCompanyView.fetchProfileImg()
        CoreDataManager.shared.saveCompanyData(companyName: companyName, foundedDate: foundedDate, profileImage: profileImg) { (company) in
            dismiss(animated: true){
                self.addAndEditDelegate?.didAddCompany(company: company )
            }
        }
    }
    
    fileprivate func editCompanyInCoreData(){
        let context = CoreDataManager.shared.persistantContainer.viewContext
        guard let company = createCompanyView.company else {return}
        company.name = createCompanyView.fetchNameTextFieldText()
        company.founded = createCompanyView.fetchFoundedDate()
        
        let profileImgData = UIImageJPEGRepresentation(createCompanyView.fetchProfileImg(), 1.0)
        company.profileImgData = profileImgData
        
        do{
            try context.save()
            dismiss(animated: true){
                self.addAndEditDelegate?.didEditCompany(company: company)
            }
        }catch let saveErr{
            print("Failed to edit: ", saveErr)
        }
    }
    
    
    internal func setupViews(){
        view.addSubview(createCompanyView)
        createCompanyView.anchor(top: view.topAnchor, bottom: nil, left: view.leftAnchor, right: view.rightAnchor, topPadding: 0, bottomPadding: 0, leftPadding: 0, rightPadding: 0, width: 0, height: view.frame.height*2/3)
    }
}




