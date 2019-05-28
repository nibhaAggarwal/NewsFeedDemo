//
//  CustomSearchView.swift
//  SampleInsta
//
//  Created by Nibha Aggarwal on 28/05/19.
//  Copyright © 2019 Nibha Aggarwal. All rights reserved.
//

import UIKit

class CustomSearchView: UIView {

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    func commonInit() {
        self.layer.cornerRadius = self.bounds.height/2
        self.clipsToBounds = true
        self.setProperties(borderWidth: 1.0, borderColor:UIColor.black)
    }
    func setProperties(borderWidth: Float, borderColor: UIColor) {
        self.layer.borderWidth = CGFloat(borderWidth)
        self.layer.borderColor = borderColor.cgColor
    }

}
