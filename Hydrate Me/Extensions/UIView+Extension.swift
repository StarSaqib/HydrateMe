//
//  UIView+Extension.swift
//  Hydrate Me
//
//  Created by admin on 25/1/25.
//

import Foundation
import UIKit

extension UIView {

    func dropShadow(shadowRadius: CGFloat = 4, cornerRadius: CGFloat = 8) {
           layer.masksToBounds = false
           layer.shadowColor = UIColor.black.cgColor
           layer.shadowOpacity = 0.4
           layer.shadowOffset = CGSize(width: 1, height: 1)
           layer.shadowRadius = shadowRadius
           layer.shouldRasterize = true
           layer.rasterizationScale = UIScreen.main.scale
           
           layer.cornerRadius = cornerRadius
       }
}
