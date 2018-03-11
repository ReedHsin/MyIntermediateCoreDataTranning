//
//  EmployeesController.swift
//  MyIntermediateCoreDataTranning
//
//  Created by 辛忠翰 on 10/03/18.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit
class EmployeesViewController: UIViewController {
    var company: CompanyModel?{
        didSet{
            guard let company = company else {return}
            setupNavigationBar(company: company)
        }
    }
    
    let tableView: UITableView = {
       let tv = UITableView()
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        setupTableView()
        registerCell()
    }
    
    fileprivate func setupTableView(){
        view.addSubview(tableView)
        tableView.fullAnchor(superView: view)
        tableView.backgroundColor = UIColor.darkBlueColor
    }
    
    fileprivate func registerCell(){
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
    }
    
    fileprivate func setupNavigationBar(company: CompanyModel){
        navigationItem.title = company.name
        setupRightNavigationItemByImage(img: "plus", selector: #selector(handleAddItem))
    }
//
    @objc fileprivate func handleAddItem(){
        let createEmployeeController = CreateEmployeeViewController()
        let naviController = UINavigationController(rootViewController: createEmployeeController)
        present(naviController, animated: true, completion: nil)
        
    }
}


extension EmployeesViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        cell.backgroundColor = UIColor.tealColor
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.backgroundColor = .lightBlue
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 22)
        switch section {
        case 0:
            label.text = "Executive"
        case 1:
            label.text = "Senior Management"
        case 2:
            label.text = "Staff"
        default:
            return label
        }
        return label
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
}
