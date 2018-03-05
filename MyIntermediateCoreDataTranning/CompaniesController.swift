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
    var tableView: UITableView {get}
    func setupCompaniesNaviStyle()
    func setupTableView()
    func setupTableViewStyle()
    func registerCell()
    func fetchCompaniesFromCoreData()
}



class CompaniesController: UIViewController{
    var delegate: CompaniesControllerProtocol?
    
    let tableView: UITableView = {
       let tbv = UITableView()
        return tbv
    }()
    var companies = [
        Company(name: "Apple", founded: Date()),
        Company(name: "Google", founded: Date()),
        Company(name: "Twitter", founded: Date())
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        delegate = self
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

        //設定右邊的icon
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "plus")?.withRenderingMode(.alwaysOriginal) , style: .plain, target: self, action: #selector(handleAddCompany))
    }
    
    @objc func handleAddCompany(){
        let createCompanyController = CreateCompanyController()
        createCompanyController.delegate = self
        let naviController = CustomNavigationController(rootViewController: createCompanyController)
        present(naviController, animated: true, completion: nil)
    }
    
    internal func setupTableView(){
        tableView.dataSource = self
        tableView.delegate = self
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
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CompanyCell")
    }
    
    internal func fetchCompaniesFromCoreData() {
        //attempt my core data fetch somehow
        let persistantContainer = NSPersistentContainer(name: "MyIntermediateCoreDatatranningModel")
        persistantContainer.loadPersistentStores { (description, err) in
            if let err = err{
                fatalError("Loading of store failure: \(err)")
            }
            print("Loading of stor successful!")
        }
        
        let context = persistantContainer.viewContext
        //去抓取core data中存的資料
        //這邊xcode會自動幫我們加<NSFetchRequestResult>，但是我們需要自行把它改成我們的entity name(這邊是CompanyModel)
        let fetchRequest = NSFetchRequest<CompanyModel>(entityName: "CompanyModel")
        //用do-catch來實做context.fetch
        do{
            let companies = try context.fetch(fetchRequest)
            companies.forEach({ (company) in
                print(company.name)
            })
            
        }catch let err {
            print("Fetching of companies failure: ", err.localizedDescription)
            return
        }
        
        
        
    }
    
    
    
}



//MARK: AddCompanyProtocol
extension CompaniesController: AddCompanyProtocol{
    func didAddCompany(company: Company) {
        companies.append(company)
        //insert a new row in tableview
        let newIndexpath = IndexPath(row: companies.count-1, section: 0)
        tableView.insertRows(at: [newIndexpath], with: .bottom)
    }
}



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
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CompanyCell", for: indexPath)
        cell.backgroundColor = UIColor.tealColor
        let company = companies[indexPath.item]
        cell.textLabel?.text = company.name
        cell.textLabel?.textColor = UIColor.white
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        return cell
    }
}

