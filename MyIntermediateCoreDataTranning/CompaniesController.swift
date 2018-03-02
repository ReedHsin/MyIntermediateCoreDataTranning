//
//  CompaniesController.swift
//  MyIntermediateCoreDataTranning
//
//  Created by 辛忠翰 on 28/02/18.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit

class CompaniesController: UITableViewController{

    var companies = [
        Company(name: "Apple", founded: Date()),
        Company(name: "Google", founded: Date()),
        Company(name: "Twitter", founded: Date())
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupCompaniesNaviStyle()
        setupTableViewStyle()
        registerCell()
    }

    
    //Mark: TableView DataSource
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return companies.count
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
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
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    //Mark: TableView Delegate
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CompanyCell", for: indexPath)
        cell.backgroundColor = UIColor.tealColor
        let company = companies[indexPath.item]
        cell.textLabel?.text = company.name
        cell.textLabel?.textColor = UIColor.white
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        return cell
    }
    
    
    
    
    
    
    
}

extension CompaniesController{
    fileprivate func setupCompaniesNaviStyle(){
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
    
    fileprivate func setupTableViewStyle(){
        tableView.backgroundColor = UIColor.darkBlueColor
//        tableView.separatorStyle = .none
        tableView.separatorColor = .white
        //讓沒有row的地方，直接就是底色
        let blankView = UIView(frame: .zero)
        tableView.tableFooterView = blankView
    }
    
    fileprivate func registerCell(){
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CompanyCell")
    }
}


extension CompaniesController: CreateCompanyControllerDelegate{
    func didAddCompany(company: Company) {
        companies.append(company)
        //insert a new row in tableview
        let newIndexpath = IndexPath(row: companies.count-1, section: 0)
        tableView.insertRows(at: [newIndexpath], with: .bottom)
    }
    
    
}


