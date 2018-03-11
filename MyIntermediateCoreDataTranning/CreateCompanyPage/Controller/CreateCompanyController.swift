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
    func didAddCompany(company: CompanyModel)
    func didEditCompany(company: CompanyModel)
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
        //1.initialization of our Core Data stack
        //1.1:需與我們剛創的.xcdatamodeld的檔名相同
        //        let persistantContainer = NSPersistentContainer(name: "MyIntermediateCoreDatatranningModel")
        //1.2:去loading persistantStore
        //        persistantContainer.loadPersistentStores { (storeDescription, err) in
        //            if let err = err{
        //                //若不對，在app runtime期間，app就會crash
        //                fatalError("Loading of store failure: \(err)")
        //            }
        //            print("Successfully load store!!")
        //        }
        //1.2:去抓取viewContext
        //        let context = persistantContainer.viewContext
        //利用singleTern去解的話，context就會一直活著
        let context =         CoreDataManager.shared.persistantContainer.viewContext
        
        //1.3:去抓取我們新增在core data的entity
        let companyModel = NSEntityDescription.insertNewObject(forEntityName: "CompanyModel", into: context)
        //1.4:針對entity的欄位去新增資料(目前我們的company entity只有name欄位)
        let companyName = createCompanyView.fetchNameTextFieldText()
        let foundedDate = createCompanyView.fetchFoundedDate()
        companyModel.setValue(companyName, forKey: "name")
        companyModel.setValue(foundedDate, forKey: "founded")
        
        let profileImg = createCompanyView.fetchProfileImg()
        let imgData = UIImageJPEGRepresentation(profileImg, 1.0)
        companyModel.setValue(imgData, forKey: "profileImgData")
        //perform the save(做完這步，此時你的company model已經被建立在core data中了)
        //記得要用do-catch來實作context.save
        //接下來，到CompaniesController中的viewDidLoad，在程式一開始執行時，去檢查core data中有沒有存資料
        do{
            try context.save()
            //success
            dismiss(animated: true){
                self.addAndEditDelegate?.didAddCompany(company: companyModel as! CompanyModel)
            }
        }catch let saveErr{
            print("Failed to save: ", saveErr.localizedDescription)
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




