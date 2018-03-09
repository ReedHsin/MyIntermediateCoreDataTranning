//
//  CreateCompanyView.swift
//  MyIntermediateCoreDataTranning
//
//  Created by 辛忠翰 on 02/03/18.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit
protocol CreateCompanyViewDelegate {
    var company: CompanyModel? {get set}
    var profileImageView: UIImageView {get set}
    var selectePhotoButton: UIButton  {get set}
    var nameTextField: UITextField {get set}
    var foundedLabel: UILabel {get set}
    var presentDatePickerLabel: UILabel {get set}
    var datePicker: UIDatePicker {get set}
    func setupViews()
    func fetchNameTextFieldText()-> String
}



class CreateCompanyView: UIView, CreateCompanyViewDelegate {
    internal var delegate: CreateCompanyViewDelegate?
    public var company: CompanyModel? {
        didSet{
            nameTextField.text = company?.name
        }
    }
    
    
    
    internal var profileImageView: UIImageView = {
       let imgView = UIImageView()
        imgView.image = UIImage(named: "select_photo_empty")
        return imgView
    }()

    internal var selectePhotoButton: UIButton = {
       let btn = UIButton(type: .system)
        btn.setTitle("Select Photos", for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.layer.borderWidth = 1.0
        btn.layer.borderColor = UIColor.gray.cgColor
        btn.layer.cornerRadius = 5.0
        return btn
    }()

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
        label.text = "Founded"
        return label
    }()

    internal var presentDatePickerLabel: UILabel = {
       let label = UILabel()
        label.textAlignment = .left
        label.text = "2018/3/2"
        return label
    }()

    internal var datePicker: UIDatePicker = {
       let picker = UIDatePicker()
        return picker
    }()
    
    internal func setupViews(){
        addSubview(profileImageView)
        addSubview(selectePhotoButton)
        addSubview(nameTextField)
        addSubview(foundedLabel)
        addSubview(presentDatePickerLabel)
        addSubview(datePicker)
        profileImageView.anchor(top: topAnchor, bottom: nil, left: nil, right: nil, topPadding: 10, bottomPadding: 0, leftPadding: 0, rightPadding: 0, width: 100, height: 100)
        profileImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        selectePhotoButton.anchor(top: profileImageView.bottomAnchor, bottom: nil, left: leftAnchor, right: rightAnchor, topPadding: 10, bottomPadding: 0, leftPadding: 10, rightPadding: 10, width: 0, height: 50)
        selectePhotoButton.layoutIfNeeded()
        nameTextField.anchor(top: selectePhotoButton.bottomAnchor, bottom: nil, left: selectePhotoButton.leftAnchor, right: selectePhotoButton.rightAnchor, topPadding: 10, bottomPadding: 0, leftPadding: 0, rightPadding: 0, width: 0, height: selectePhotoButton.frame.height)
        
        nameTextField.layoutIfNeeded()
        foundedLabel.anchor(top: nameTextField.bottomAnchor, bottom: nil, left: nameTextField.leftAnchor, right: nil, topPadding: 10, bottomPadding: 0, leftPadding: 0, rightPadding: 0, width: 90, height: nameTextField.frame.height)
        
        presentDatePickerLabel.anchor(top: foundedLabel.topAnchor, bottom: foundedLabel.bottomAnchor, left: foundedLabel.rightAnchor, right: rightAnchor, topPadding: 0, bottomPadding: 0, leftPadding: 10, rightPadding: 0, width: 0, height: 0)
        
        datePicker.anchor(top: presentDatePickerLabel.bottomAnchor, bottom: bottomAnchor, left: leftAnchor, right: rightAnchor, topPadding: 10, bottomPadding: 0, leftPadding: 0, rightPadding: 0, width: 0, height: 0)
    }
    
    public func fetchNameTextFieldText() -> String{
        guard let name = nameTextField.text else {return ""}
        return name
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        delegate = self
        backgroundColor = UIColor.lightBlue
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}






