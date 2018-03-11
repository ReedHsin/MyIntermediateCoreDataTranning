//
//  CompaniesController+AddAndEditCompanyDelegate.swift
//  MyIntermediateCoreDataTranning
//
//  Created by 辛忠翰 on 10/03/18.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit

//MARK: AddCompanyProtocol
//這邊一開始會發現雖然會出現一個新的row，但這個row的context會是nil
//原因在CreateCompanyController的context，會在handleAddItem function結束後，context也會移出記憶體
//所以在這邊試圖存取時，自然會找不到
//但可以用創造一個Singleton CoreDataManager去解
extension CompaniesController: AddAndEditCompanyDelegate{
    func didEditCompany(company: CompanyModel) {
        guard let row = companies.index(of: company) else {
            return
        }
        let indexPath = IndexPath(row: row, section: 0)//可以找到company的indexPath
        tableView.reloadRows(at: [indexPath], with: .middle)
    }
    
    func didAddCompany(company: CompanyModel) {
        companies.append(company)
        //insert a new row in tableview
        let newIndexpath = IndexPath(row: companies.count-1, section: 0)
        tableView.insertRows(at: [newIndexpath], with: .bottom)
    }
}
