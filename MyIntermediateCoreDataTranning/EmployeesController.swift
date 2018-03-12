//
//  EmployeesController.swift
//  MyIntermediateCoreDataTranning
//
//  Created by 辛忠翰 on 10/03/18.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit



class EmployeesViewController: UIViewController {
    
   
    var staffEmployees = [Employee]()
    var seniorEmployees = [Employee]()
    var executiveEmployees = [Employee]()
    var allEmployees = [[Employee]]()
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
        //test
        //name count>5
        executiveEmployees = employees.filter{ (employee) -> Bool in
            guard let count = employee.name?.count else {return false}
            return count > 5
        }
        //<2
        staffEmployees = employees.filter{ (employee) -> Bool in
            guard let count = employee.name?.count else {return false}
            return count < 5
        }
        //2~5
        seniorEmployees = employees.filter{ (employee) -> Bool in
            guard let count = employee.name?.count else {return false}
            return count < 5 && count > 2
        }
        
        allEmployees = [
            executiveEmployees,
            seniorEmployees,
            staffEmployees
        ]
    }
}


extension EmployeesViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return allEmployees.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allEmployees[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        cell.backgroundColor = UIColor.tealColor
        let employee = allEmployees[indexPath.section][indexPath.row]
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
        let label = IdentedLabel()
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
        guard let count = employee.name?.count else {return}
        let indexPath: IndexPath?
        if count > 5{
            allEmployees[0].append(employee)
            indexPath = IndexPath(row: executiveEmployees.count , section: 0)
        }else if count < 2{
            allEmployees[2].append(employee)
            indexPath = IndexPath(row: staffEmployees.count , section: 2)
        }else{
            allEmployees[1].append(employee)
            indexPath = IndexPath(row: seniorEmployees.count , section: 1)
        }
        guard let newIndexPath = indexPath else {return}
        tableView.insertRows(at: [newIndexPath], with: .middle)
//        tableView.reloadData()
    }
}


