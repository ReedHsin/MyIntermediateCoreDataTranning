//
//  Extension.swift
//  MyIntermediateCoreDataTranning
//
//  Created by 辛忠翰 on 01/03/18.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    static let blackColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
    static func color(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    
    static let lightRed = UIColor.color(red: 247, green: 66, blue: 82)
    static let tealColor = UIColor.color(red: 48, green: 164, blue: 184)
    static let darkBlueColor = UIColor.color(red: 9, green: 45, blue: 64)
    static let lightBlue = UIColor.color(red: 218, green: 235, blue: 243)
}

extension UIViewController{
    //但最好的方式是在appdelegate中統一所有的navigation bar的appearance
//    func setupNavigationBarStyle(){
//        navigationController?.navigationBar.isTranslucent = false
//        navigationController?.navigationBar.barTintColor = UIColor.lightRed
//        navigationController?.navigationBar.prefersLargeTitles = true
//        navigationController?.navigationBar.largeTitleTextAttributes = [
//            NSAttributedStringKey.foregroundColor : UIColor.white
//        ]
//    }
}

extension UIView{
    func anchor(top: NSLayoutYAxisAnchor?, bottom: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, right: NSLayoutXAxisAnchor?, topPadding: CGFloat, bottomPadding: CGFloat, leftPadding: CGFloat, rightPadding: CGFloat, width: CGFloat, height: CGFloat ) {
        translatesAutoresizingMaskIntoConstraints = false
        if let top = top{
            topAnchor.constraint(equalTo: top, constant: topPadding).isActive = true
        }
        
        if let bottom = bottom{
            bottomAnchor.constraint(equalTo: bottom, constant: -bottomPadding).isActive = true
        }
        
        if let left = left{
            leftAnchor.constraint(equalTo: left, constant: leftPadding).isActive = true
        }
        
        if let right = right{
            rightAnchor.constraint(equalTo: right, constant: -rightPadding).isActive = true
        }
        
        if width != 0{
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        if height != 0{
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
    func fullAnchor(superView: UIView) {
        anchor(top: superView.topAnchor, bottom: superView.bottomAnchor, left: superView.leftAnchor, right: superView.rightAnchor, topPadding: 0, bottomPadding: 0, leftPadding: 0, rightPadding: 0, width: 0, height: 0)
    }
    
    func middleAnchor(superView: UIView, width: CGFloat, height: CGFloat) {
        anchor(top: nil, bottom: nil, left: nil, right: nil, topPadding: 0, bottomPadding: 0, leftPadding: 0, rightPadding: 0, width: width, height: height)
        centerXAnchor.constraint(equalTo: superView.centerXAnchor).isActive = true
        centerYAnchor.constraint(equalTo: superView.centerYAnchor).isActive = true
    }
    
}


extension UIViewController{
    func setupRightNavigationItemByImage(img: String, selector: Selector) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: img), style: .plain, target: self, action: selector)
    }
    func setupLeftNavigationItemByImage(img: String, selector: Selector) {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: img), style: .plain, target: self, action: selector)
    }
    func setupRightNavigationItemByTitle(title: String, selector: Selector) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: title, style: .plain, target: self, action: selector)
    }
    func setupLeftNavigationItemByTitle(title: String, selector: Selector) {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: title, style: .plain, target: self, action: selector)
    }
}







