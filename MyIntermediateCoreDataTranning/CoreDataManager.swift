//
//  CoreDataManager.swift
//  MyIntermediateCoreDataTranning
//
//  Created by 辛忠翰 on 05/03/18.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import CoreData
import UIKit
struct CoreDataManager {
    //It will leave forever as long as ur app is still alive, it's properites will too
    static let shared = CoreDataManager()//這樣的寫法可以創造singleTern
    //如此一來CoreDataManager的所有properties便可永遠活在app run time時期
    let persistantContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MyIntermediateCoreDatatranningModel")
        container.loadPersistentStores { (storeDescription, err) in
            if let err = err{
                fatalError("Loading of store failure: \(err)")
            }
            print("Successfully load store!!")
        }
        return container
    }()
    
    
    func fetchCompanies(completion: (_ companies: [Company]) -> ()) {
        //attempt my core data fetch somehow
        //        let persistantContainer = NSPersistentContainer(name: "MyIntermediateCoreDatatranningModel")
        //        persistantContainer.loadPersistentStores { (description, err) in
        //            if let err = err{
        //                fatalError("Loading of store failure: \(err)")
        //            }
        //            print("Loading of stor successful!")
        //        }
        //直接用CoreDataMeneger Singletern
        let context = persistantContainer.viewContext
        //去抓取core data中存的資料
        //這邊xcode會自動幫我們加<NSFetchRequestResult>，但是我們需要自行把它改成我們的entity name(這邊是Company)
        let fetchRequest = NSFetchRequest<Company>(entityName: "Company")
        //用do-catch來實做context.fetch
        do{
            let companies = try context.fetch(fetchRequest)
            completion(companies)
        }catch let err {
            print("Fetching of companies failure: ", err.localizedDescription)
        }
    }
    
    func saveCompanyData(companyName: String, foundedDate: Date, profileImage: UIImage, completion: (Company) -> ()) {
        let context = persistantContainer.viewContext
        let company = NSEntityDescription.insertNewObject(forEntityName: "Company", into: context) as! Company
        
        company.setValue(companyName, forKey: "name")
        company.setValue(foundedDate, forKey: "founded")
        let imgData = UIImageJPEGRepresentation(profileImage, 1.0)
        company.setValue(imgData, forKey: "profileImgData")
        do{
            try context.save()
            //success
            completion(company)
        }catch let saveErr{
            print("Failed to save: ", saveErr.localizedDescription)
        }
    }
    
    func saveEmployeeData(name: String, birthday: Date, company: Company, completion: (Employee) -> ()) -> Error?{
        let context = persistantContainer.viewContext
        let employee = NSEntityDescription.insertNewObject(forEntityName: "Employee", into: context) as! Employee
        
//        employee.setValue(name, forKey: "name")
        employee.name = name//safer way to access attribute
        
        let employeeInformation = NSEntityDescription.insertNewObject(forEntityName: "EmployeeInformation", into: context) as! EmployeeInformation
        let taxId = "364"
//        employeeInformation.setValue(taxId, forKey: "taxId")
        employeeInformation.taxId = taxId
        employeeInformation.birthday = birthday
        employee.employeeInformation = employeeInformation

        employee.company = company
        do{
            try context.save()
            //success
            completion(employee)
            return nil
        }catch let saveErr{
            print("Failed to save: ", saveErr.localizedDescription)
            return saveErr
        }
    }
    
    func fetchEmployee(completion: (_ employees: [Employee])->()) {
        let context = persistantContainer.viewContext
        let fetchRequest = NSFetchRequest<Employee>(entityName: "Employee")
        do{
            let employee = try context.fetch(fetchRequest)
            completion(employee)
        }catch let err {
            print("Fetching of companies failure: ", err.localizedDescription)
        }
    }
    
}
