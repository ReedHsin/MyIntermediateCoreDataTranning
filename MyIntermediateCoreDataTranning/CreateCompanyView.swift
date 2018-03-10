//
//  CreateCompanyView.swift
//  MyIntermediateCoreDataTranning
//
//  Created by 辛忠翰 on 02/03/18.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit
protocol CreateCompanyViewImageViewDelegate {
    func presentImgPicker()
}



protocol CreateCompanyViewProtocol {
    var company: CompanyModel? {get set}
    var profileImg: UIImage? {get set}
    var profileImageView: UIImageView {get set}
    var nameTextField: UITextField {get set}
    var foundedLabel: UILabel {get set}
    var presentDatePickerLabel: UILabel {get set}
    var datePicker: UIDatePicker {get set}
    func setupViews()
    func fetchNameTextFieldText()-> String
    func fetchFoundedDate() -> Date
    func fetchProfileImg() -> UIImage
}



class CreateCompanyView: UIView, CreateCompanyViewProtocol {
    internal var delegate: CreateCompanyViewProtocol?
    public var imgViewDelegate: CreateCompanyViewImageViewDelegate?
    public var company: CompanyModel? {
        didSet{
            nameTextField.text = company?.name
            guard let founded = company?.founded else {return}
            datePicker.date = founded
            guard let profileImgData = company?.profileImgData else {return }
            guard let profileImg = UIImage(data: profileImgData) else {return}
            profileImageView.image = profileImg
        }
    }
    
    public var profileImg: UIImage?{
        didSet{
            profileImageView.image = profileImg
        }
    }
    
    internal lazy var profileImageView: UIImageView = {
       let imgView = UIImageView()
        imgView.image = UIImage(named: "select_photo_empty")
        imgView.contentMode = .scaleAspectFill
       //為了讓imgView可以被使用者點選
        imgView.isUserInteractionEnabled = true // imgViews by default are not interactive with user
        imgView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapImageView)))
        return imgView
    }()

    @objc fileprivate func handleTapImageView(){
        print("U tap the imgView...")
        imgViewDelegate?.presentImgPicker()
    }
    
    

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
       let dp = UIDatePicker()
        dp.datePickerMode = .date
        return dp
    }()
    
    internal func setupViews(){
        addSubview(profileImageView)
        addSubview(nameTextField)
        addSubview(foundedLabel)
        addSubview(presentDatePickerLabel)
        addSubview(datePicker)
        profileImageView.anchor(top: topAnchor, bottom: nil, left: nil, right: nil, topPadding: 10, bottomPadding: 0, leftPadding: 0, rightPadding: 0, width: 150, height: 150)
        profileImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        profileImageView.layoutIfNeeded()
        profileImageView.layer.cornerRadius = profileImageView.frame.height/2
        profileImageView.clipsToBounds = true
        
        nameTextField.anchor(top: profileImageView.bottomAnchor, bottom: nil, left: leftAnchor, right: rightAnchor, topPadding: 10, bottomPadding: 0, leftPadding: 10, rightPadding: 10, width: 0, height: 30)
        
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
    
    public func fetchProfileImg() -> UIImage {
        guard let img = profileImageView.image else{ return UIImage()}
        return img
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






