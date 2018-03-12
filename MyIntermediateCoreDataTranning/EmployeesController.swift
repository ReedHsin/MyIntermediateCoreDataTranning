//
//  EmployeesController.swift
//  MyIntermediateCoreDataTranning
//
//  Created by 辛忠翰 on 10/03/18.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit
class EmployeesViewController: UIViewController {
    var employees = [Employee]()
    
    var company: Company?{
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
        fetchEmployees()
    }
    
    fileprivate func setupTableView(){
        view.addSubview(tableView)
        tableView.fullAnchor(superView: view)
        tableView.backgroundColor = UIColor.darkBlueColor
    }
    
    fileprivate func registerCell(){
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
    }
    
    fileprivate func setupNavigationBar(company: Company){
        navigationItem.title = company.name
        setupRightNavigationItemByImage(img: "plus", selector: #selector(handleAddItem))
    }
//
    @objc fileprivate func handleAddItem(){
        let createEmployeeController = CreateEmployeeViewController()
        createEmployeeController.delegate = self
        createEmployeeController.company = company
        let naviController = UINavigationController(rootViewController: createEmployeeController)
        present(naviController, animated: true, completion: nil)
        
    }
    
    fileprivate func fetchEmployees(){
        guard let employees = company?.employees?.allObjects as? [Employee] else {return}
        self.employees = employees
    }
}


extension EmployeesViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employees.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        cell.backgroundColor = UIColor.tealColor
        let employee = employees[indexPath.row]
        cell.textLabel?.text = employee.name
        if let taxId = employee.employeeInformation?.taxId, let company = employee.company?.name, let birthdayDate = employee.employeeInformation?.birthday{
            let dateformatter = DateFormatter()
            let birthday = dateformatter.dateToStr(date: birthdayDate)
            cell.textLabel?.text = "\(employee.name ?? "")  -\(taxId)  -\(company) -\(birthday)"
            
            
        }
        cell.textLabel?.textColor = .white
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

extension EmployeesViewController: CreateEmployeeViewControllerDelegate{
    func didAddEmployee(employee: Employee) {
        employees.append(employee)
        let indexPath0 = IndexPath(row: employees.count - 1, section: 0)
        let indexPath1 = IndexPath(row: employees.count - 1, section: 1)
        let indexPath2 = IndexPath(row: employees.count - 1, section: 2)
        tableView.insertRows(at: [indexPath0, indexPath1, indexPath2], with: .middle)
//        tableView.reloadData()
    }
}


