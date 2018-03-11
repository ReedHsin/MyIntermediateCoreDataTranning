//
//  CompaniesController+TableView.swift
//  MyIntermediateCoreDataTranning
//
//  Created by 辛忠翰 on 10/03/18.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit
//MARK: TableView Delegate and Datasource
extension CompaniesController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return companies.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.lightBlue
        let textLabel = UILabel()
        textLabel.text = "Company"
        textLabel.textColor = UIColor(white: 1.0, alpha: 0.6)
        textLabel.font = UIFont.boldSystemFont(ofSize: 16)
        headerView.addSubview(textLabel)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor).isActive = true
        textLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerLabel = UILabel()
        footerLabel.text = "No avaliable companies..."
        footerLabel.textColor = UIColor.white
        footerLabel.textAlignment = .center
        footerLabel.font = UIFont.boldSystemFont(ofSize: 16)
        
        return footerLabel
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return companies.count == 0 ? 150 : 0
    }
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CompanyCell", for: indexPath) as! CompanyCell
        cell.company = companies[indexPath.item]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete", handler: deleteHandlerFunction)
        let editAction = UITableViewRowAction(style: .normal, title: "Edit", handler: editHandlerFunction)
        deleteAction.backgroundColor = UIColor.lightRed
        editAction.backgroundColor = UIColor.darkBlueColor
        return [deleteAction, editAction]
    }
    
    fileprivate func deleteHandlerFunction(_: UITableViewRowAction, indexPath: IndexPath){
        //remove the company from coreData
        let context = CoreDataManager.shared.persistantContainer.viewContext
        let company = self.companies[indexPath.row]
        context.delete(company)//最後要讓這個delete save到persistant store
        do{
            try context.save()
        }catch let err {
            print("Failed to delete company from CoreData: \(err.localizedDescription)")
        }
        
        //remove the company from tableView
        //要先把這個row從companies中移除，在做self.tableView.deleteRows。
        //因為在執行self.tableView.deleteRows後，會觸發numberOfRowsInSection function，如此一來company個數才會一置，否則app會crash
        self.companies.remove(at: indexPath.row)
        self.tableView.deleteRows(at: [indexPath], with: .fade)
    }
    
    fileprivate func editHandlerFunction(_: UITableViewRowAction, indexPath: IndexPath){
        let createCompanyController = CreateCompanyController()
        createCompanyController.createCompanyView.company = companies[indexPath.row]
        createCompanyController.addAndEditDelegate = self
        let naviController = UINavigationController(rootViewController: createCompanyController)
        present(naviController, animated: true, completion: nil)
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let evc = EmployeesViewController()
        evc.company = companies[indexPath.row]
        navigationController?.pushViewController(evc, animated: true)
    }
}
