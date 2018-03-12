//
//  CompanyCell.swift
//  MyIntermediateCoreDataTranning
//
//  Created by 辛忠翰 on 09/03/18.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit
enum CompanyCellConstants: CGFloat {
    case padding = 10
    case height = 40
}



class CompanyCell: UITableViewCell {
    var company: Company?{
        didSet{
            if let profileImgData = company?.profileImgData{
                let profileImg = UIImage(data: profileImgData)
                profileImageView.image = profileImg
            }
            setupTitleLabel(company: company)
        }
    }
    
    fileprivate func setupTitleLabel(company: Company?){
          guard let companyName = company?.name else {return}
        let attributedText = NSMutableAttributedString(string: companyName, attributes:[
            NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 16),
            NSAttributedStringKey.foregroundColor : UIColor.white
            ]
        )
        let foundedDateString = formateDate(company: company)
        attributedText.append(NSMutableAttributedString(string: "  -founded: \(foundedDateString)", attributes: [
            NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 13),
            NSAttributedStringKey.foregroundColor : UIColor.white
            ])
        )
        titleLabel.attributedText = attributedText
    }
    
    fileprivate func formateDate(company: Company?) -> String{
        guard let companyFoundedDate = company?.founded else {return ""}
        //但目前系統給的時間格式很不好讀，所以可以利用locale轉成人類好讀的格式
        //        let locale = Locale(identifier: "EN")
        //        cell.textLabel?.text = "\(name) - founded: \(founded.description(with: locale))"
        //更進階好用的是用dateFormatter把date轉成 MMM dd, yyyy的格式
        //or MMM dd, yyyy hh:mm:ss有各種formatter可用
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy"
        let foundedDateString = dateFormatter.string(from: companyFoundedDate)
        return foundedDateString
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "GG"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()
    
    let profileImageView: UIImageView = {
       let piv = UIImageView()
        piv.image = UIImage(named: "select_photo_empty")
        piv.backgroundColor = UIColor.white
        piv.contentMode = .scaleAspectFill
        return piv
    }()
    
    fileprivate func setupViews(){
        addSubview(profileImageView)
        addSubview(titleLabel)
        profileImageView.anchor(top: nil, bottom: nil, left: leftAnchor, right: nil, topPadding: 0, bottomPadding: 0, leftPadding: CompanyCellConstants.padding.rawValue, rightPadding: 0, width: CompanyCellConstants.height.rawValue, height: CompanyCellConstants.height.rawValue)
        profileImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        profileImageView.layoutIfNeeded()
        profileImageView.layer.cornerRadius = profileImageView.frame.height/2
        profileImageView.clipsToBounds = true
        
        titleLabel.anchor(top: profileImageView.topAnchor, bottom: profileImageView.bottomAnchor, left: profileImageView.rightAnchor, right: rightAnchor, topPadding: 0, bottomPadding: 0, leftPadding: CompanyCellConstants.padding.rawValue, rightPadding: CompanyCellConstants.padding.rawValue, width: 0, height: 0)
        
    }
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor.tealColor
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
