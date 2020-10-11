//
//  UIView.swift
//  BookMyShowAssignment
//
//  Created by Sourabh Kumbhar on 11/10/20.
//  Copyright © 2020 Sourabh Kumbhar. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func setRadius(_ radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
       
    func addShadowToView(opacity: Float = 0.5) {
        self.backgroundColor = .white
        self.layer.masksToBounds = true
        self.clipsToBounds = false
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowRadius = 5
    }
    
    func addBorder(width: CGFloat, color: UIColor) {        
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
    }
    
    func setRadius(radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true 
    }
}


