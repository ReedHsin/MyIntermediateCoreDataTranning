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
    
    var allEmployees = [[Employee]]()
    var employeeTypes = [
        EmployeeTypeEnum.Executive.rawValue,
        EmployeeTypeEnum.SeniorManegement.rawValue,
        EmployeeTypeEnum.Staff.rawValue
    ]
    fileprivate func fetchEmployees(){
        guard let employees = company?.employees?.allObjects as? [Employee] else {return}
        allEmployees = []//因為有個didAddEmployee function也會call fetchEmployees，若沒有把allEmployees清空，可能會造成他又新增一個array到allEmployees，這會使得一開始只有設定3個section出錯
        //test
        //name count>5
//        executiveEmployees = employees.filter{ (employee) -> Bool in
//            guard let count = employee.name?.count else {return false}
//            return count > 5
//        }
        //<2
//        staffEmployees = employees.filter{ (employee) -> Bool in
//            guard let count = employee.name?.count else {return false}
//            return count < 5
//        }
        //2~5
//        seniorEmployees = employees.filter{ (employee) -> Bool in
//            guard let count = employee.name?.count else {return false}
//            return count < 5 && count > 2
//        }
        
        //依照employee的職位去區分
        executiveEmployees = employees.filter{
            $0.type == EmployeeTypeEnum.Executive.rawValue
        }
        staffEmployees = employees.filter{
            $0.type == EmployeeTypeEnum.Staff.rawValue
        }
        seniorEmployees = employees.filter{
            $0.type == EmployeeTypeEnum.SeniorManegement.rawValue
        }
        
        
        //最進化的寫法
        employeeTypes.forEach { (employeeType) in
            //總共會跑三次，依序為Executive, SeniorManegement, Staff
            allEmployees.append(
                
                employees.filter{ $0.type == employeeType}//這邊出來會是個array: [Employee]
            )
        }
        
        
//        allEmployees = [
//            executiveEmployees,
//            seniorEmployees,
//            staffEmployees
//        ]
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
//        switch section {
//        case 0:
//            label.text = "Executive"
//        case 1:
//            label.text = "Senior Management"
//        case 2:
//            label.text = "Staff"
//        default:
//            return label
//        }
        
        label.text = employeeTypes[section]
        return label
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
}

extension EmployeesViewController: CreateEmployeeViewControllerDelegate{
    func didAddEmployee(employee: Employee) {
        //使用名字字數做分類的情況，只用於test
//        guard let count = employee.name?.count else {return}
//        let indexPath: IndexPath?
//        if count > 5{
//            allEmployees[0].append(employee)
//            indexPath = IndexPath(row: executiveEmployees.count , section: 0)
//        }else if count < 2{
//            allEmployees[2].append(employee)
//            indexPath = IndexPath(row: staffEmployees.count , section: 2)
//        }else{
//            allEmployees[1].append(employee)
//            indexPath = IndexPath(row: seniorEmployees.count , section: 1)
//        }
//        guard let newIndexPath = indexPath else {return}
//        tableView.insertRows(at: [newIndexPath], with: .middle)
        
        
        //一次抓取所有的employees，再一次全更新，但沒有tableView的動畫
//        fetchEmployees()
//        tableView.reloadData()
        
        //用insert的方式插入新的員工，有動畫
        guard let type = employee.type else {
            return
        }
        guard let section = employeeTypes.index(of: type) else {return}
        let row = allEmployees[section].count
        let indexPath = IndexPath(row: row, section: section)
        allEmployees[section].append(employee)
        tableView.insertRows(at: [indexPath], with: .middle)
    }
}


