//
//  IdentedLabel.swift
//  MyIntermediateCoreDataTranning
//
//  Created by 辛忠翰 on 12/03/18.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit
class IdentedLabel: UILabel {
    //調整label中text與四周的邊距
    override func drawText(in rect: CGRect) {
        let customInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        let customRect = UIEdgeInsetsInsetRect(rect, customInsets)
        super.drawText(in: customRect)
    }
}
