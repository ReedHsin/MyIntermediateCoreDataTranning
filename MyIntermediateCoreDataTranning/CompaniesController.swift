//
//  CompaniesController.swift
//  MyIntermediateCoreDataTranning
//
//  Created by 辛忠翰 on 28/02/18.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit

class CompaniesController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigationBarStyle()
    }

    
}

extension CompaniesController{
    fileprivate func setupNavigationBarStyle(){
        navigationController?.navigationBar.isTranslucent = false
        //設定NavigationBar的title
        navigationItem.title = "Companies"
        //讓title字變大，要加這行下面設定largeTitleTextAttributes的code才有效
        navigationController?.navigationBar.prefersLargeTitles = true
        //讓title變白色且字又變大
        navigationController?.navigationBar.largeTitleTextAttributes = [
            NSAttributedStringKey.foregroundColor : UIColor.white
        ]
        
        //設定bar的背景顏色
        let lightRed = UIColor(red: 247/255, green: 66/255, blue: 82/255, alpha: 1)
        navigationController?.navigationBar.barTintColor = lightRed

        //設定右邊的icon
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "plus")?.withRenderingMode(.alwaysOriginal) , style: .plain, target: self, action: #selector(handleAddCompany))
    }
    
    @objc func handleAddCompany(){
        print("Adding company...")
    }
}

