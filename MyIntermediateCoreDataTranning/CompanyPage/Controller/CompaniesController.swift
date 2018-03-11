//
//  CompaniesController.swift
//  MyIntermediateCoreDataTranning
//
//  Created by 辛忠翰 on 28/02/18.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit
import CoreData

protocol CompaniesControllerProtocol {
    var companies: [CompanyModel] {get set}
    var tableView: UITableView {get}
    func setupCompaniesNaviStyle()
    func setupTableView()
    func setupTableViewStyle()
    func registerCell()
    func fetchCompaniesFromCoreData()
}



class CompaniesController: UIViewController{
    var companiesControllerDelegate: CompaniesControllerProtocol?
    
    let tableView: UITableView = {
       let tbv = UITableView()
        return tbv
    }()
    var companies = [CompanyModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
        companiesControllerDelegate = self
        setupCompaniesNaviStyle()
        setupTableView()
        setupTableViewStyle()
        registerCell()
        fetchCompaniesFromCoreData()
    }
}



//MARK: CompaniesControllerProtocol
extension CompaniesController: CompaniesControllerProtocol{
    internal func setupCompaniesNaviStyle(){
        navigationItem.title = "Companies"
        //因為TableView在滑動的時候，預設的title顏色為black，但我們希望是white
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedStringKey.foregroundColor : UIColor.white
        ]
        
        //設定bar的背景顏色
        let lightRed = UIColor.color(red: 247, green: 66, blue: 82)
        navigationController?.navigationBar.barTintColor = lightRed

        setupRightNavigationItemByImage(img: "plus", selector: #selector(handleAddCompany))
        setupLeftNavigationItemByTitle(title: "Reset", selector: #selector(handleResetItem))
    }
    
    @objc private func handleAddCompany(){
        let createCompanyController = CreateCompanyController()
        createCompanyController.addAndEditDelegate = self
        let naviController = CustomNavigationController(rootViewController: createCompanyController)
        present(naviController, animated: true, completion: nil)
    }
    
    @objc private func handleResetItem(){
        let context = CoreDataManager.shared.persistantContainer.viewContext
        //這種方式也可以把資料從coreData中刪除
        //但無法批量刪除
        //        companies.forEach { (company) in
//            context.delete(company)
//        }
        
        //這個方式可以批量刪除Data
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: CompanyModel.fetchRequest())
        do{
            try context.execute(batchDeleteRequest)
            //但若想要有動畫的效果的話，就不能用這種方式
            //而是要一列一列的刪除，並往左移
            var indexPathToMove = [IndexPath]()
            for (index, _) in companies.enumerated(){
                let indexPath = IndexPath(row: index, section: 0)
                indexPathToMove.append(indexPath)
            }
            companies.removeAll()
            tableView.deleteRows(at: indexPathToMove, with: .left)
//            companies.removeAll()
//            tableView.reloadData()
        }catch let deleteErr{
            print("Failed to batch delete company: ", deleteErr.localizedDescription)
        }
    }
    
    internal func setupTableView(){
        view.addSubview(tableView)
        tableView.fullAnchor(superView: view)
    }
    
    internal func setupTableViewStyle(){
        tableView.backgroundColor = UIColor.darkBlueColor
//        tableView.separatorStyle = .none
        tableView.separatorColor = .white
        //讓沒有row的地方，直接就是底色
        let blankView = UIView(frame: .zero)
        tableView.tableFooterView = blankView
    }
    
    internal func registerCell(){
        tableView.register(CompanyCell.self, forCellReuseIdentifier: "CompanyCell")
    }
    
    internal func fetchCompaniesFromCoreData() {
        CoreDataManager.shared.fetchCompanies { (companies) in
            self.companies = companies
            self.tableView.reloadData()
        }
    }
}








