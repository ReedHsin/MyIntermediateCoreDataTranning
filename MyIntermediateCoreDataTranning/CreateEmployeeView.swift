//
//  CreateEmployeeView.swift
//  MyIntermediateCoreDataTranning
//
//  Created by 辛忠翰 on 11/03/18.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit
class CreateEmployeeView: UIView {
//    public var company: Company? {
//        didSet{
//            nameTextField.text = company?.name
//            guard let founded = company?.founded else {return}
//            datePicker.date = founded
//            guard let profileImgData = company?.profileImgData else {return }
//            guard let profileImg = UIImage(data: profileImgData) else {return}
//        }
//    }
    
    
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
    
    internal var foundedLabel: UILabel = {
        let label = UILabel()
        label.text = "Birthday"
        return label
    }()
    
    internal var presentDatePickerLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = "2018/3/2"
        return label
    }()
    
    internal var datePicker: UIDatePicker = {
        let dp = UIDatePicker()
        dp.datePickerMode = .date
        return dp
    }()
    
    internal func setupViews(){
        addSubview(nameTextField)
        addSubview(foundedLabel)
        addSubview(presentDatePickerLabel)
        addSubview(datePicker)
        
        nameTextField.anchor(top: topAnchor, bottom: nil, left: leftAnchor, right: rightAnchor, topPadding: 10, bottomPadding: 0, leftPadding: 10, rightPadding: 10, width: 0, height: 30)
        
        nameTextField.layoutIfNeeded()
        foundedLabel.anchor(top: nameTextField.bottomAnchor, bottom: nil, left: nameTextField.leftAnchor, right: nil, topPadding: 10, bottomPadding: 0, leftPadding: 0, rightPadding: 0, width: 90, height: nameTextField.frame.height)
        
        presentDatePickerLabel.anchor(top: foundedLabel.topAnchor, bottom: foundedLabel.bottomAnchor, left: foundedLabel.rightAnchor, right: rightAnchor, topPadding: 0, bottomPadding: 0, leftPadding: 10, rightPadding: 0, width: 0, height: 0)
        
        datePicker.anchor(top: presentDatePickerLabel.bottomAnchor, bottom: bottomAnchor, left: leftAnchor, right: rightAnchor, topPadding: 10, bottomPadding: 0, leftPadding: 0, rightPadding: 0, width: 0, height: 0)
    }
    
    public func fetchNameTextFieldText() -> String{
        guard let name = nameTextField.text else {return ""}
        return name
    }
    
    public func fetchFoundedDate() -> Date{
        let foundedDate = datePicker.date
        return foundedDate
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
