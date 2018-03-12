//
//  CreateEmployeeView.swift
//  MyIntermediateCoreDataTranning
//
//  Created by 辛忠翰 on 11/03/18.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit
class CreateEmployeeView: UIView {
    
    internal var nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Type ur name here..."
        textField.leftViewMode = UITextFieldViewMode.always
        textField.leftViewMode = .always
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        label.text = "Name"
        textField.leftView = label
        return textField
    }()
    
    internal var birthdayTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "MM/dd/yyyy"
        textField.leftViewMode = UITextFieldViewMode.always
        textField.leftViewMode = .always
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        label.text = "Birthday"
        textField.leftView = label
        return textField
    }()
    
    internal func setupViews(){
        addSubview(nameTextField)
        addSubview(birthdayTextField)
        
        
        nameTextField.anchor(top: topAnchor, bottom: nil, left: leftAnchor, right: rightAnchor, topPadding: 10, bottomPadding: 0, leftPadding: 10, rightPadding: 10, width: 0, height: 30)
        
        nameTextField.layoutIfNeeded()
        birthdayTextField.anchor(top: nameTextField.bottomAnchor, bottom: nil, left: nameTextField.leftAnchor, right: nameTextField.rightAnchor, topPadding: 10, bottomPadding: 0, leftPadding: 0, rightPadding: 0, width: 0, height: nameTextField.frame.height)
    }
    
    public func fetchNameTextFieldText() -> String{
        guard let name = nameTextField.text else {return ""}
        return name
    }

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.lightBlue
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
