//
//  CreateCompanyController.swift
//  MyIntermediateCoreDataTranning
//
//  Created by 辛忠翰 on 01/03/18.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit
import CoreData
protocol AddCompanyProtocol {
    func didAddCompany(company: Company)
}

protocol CreateCompanyControllerPrototcol {
    func setupCreateCompanyNaviBar()
    func setupViews()
}


class CreateCompanyController: UIViewController {
    let createCompanyView = CreateCompanyView()
    var delegate: AddCompanyProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.darkBlueColor
        setupCreateCompanyNaviBar()
        setupViews()
    }
}











extension CreateCompanyController: CreateCompanyControllerPrototcol{
    internal func setupCreateCompanyNaviBar(){
        navigationItem.title = "Create Company"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancelItem))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(handleSaveItem))
    }
    
    @objc func handleCancelItem(){
        print("Tap cancel button...")
        dismiss(animated: true, completion: nil)
    }
    
    @objc func handleSaveItem(){
        dismiss(animated: true){
            let company = Company(name: self.createCompanyView.fetchNameTextFieldText(), founded: Date())
            self.delegate?.didAddCompany(company: company)
            
            //1.initialization of our Core Data stack
            //1.1:需與我們剛創的.xcdatamodeld的檔名相同
            let persistantContainer = NSPersistentContainer(name: "MyIntermediateCoreDatatranningModel")
            //1.2:去loading persistantStore
            persistantContainer.loadPersistentStores { (storeDescription, err) in
                if let err = err{
                    //若不對，在app runtime期間，app就會crash
                    fatalError("Loading of store failure: \(err)")
                }
                print("Successfully load store!!")
            }
            //1.2:去抓取viewContext
            let context = persistantContainer.viewContext
            //1.3:去抓取我們新增在core data的entity
            let companyEntity = NSEntityDescription.insertNewObject(forEntityName: "CompanyModel", into: context)
            //1.4:針對entity的欄位去新增資料(目前我們的company entity只有name欄位)
            companyEntity.setValue(company.name, forKey: "name")
            //perform the save(做完這步，此時你的company model已經被建立在core data中了)
            //記得要用do-catch來實作context.save
            do{
                try context.save()
            }catch let saveErr{
                print("Failed to save: ", saveErr.localizedDescription)
            }
            //接下來，到CompaniesController中的viewDidLoad，在程式一開始執行時，去檢查core data中有沒有存資料
        }
        
    }
    
    internal func setupViews(){
        view.addSubview(createCompanyView)
        createCompanyView.anchor(top: view.topAnchor, bottom: nil, left: view.leftAnchor, right: view.rightAnchor, topPadding: 0, bottomPadding: 0, leftPadding: 0, rightPadding: 0, width: 0, height: view.frame.height*2/3)
        
    }
}

