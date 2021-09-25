//
//  JRAConstraintStruct.swift
//  Anacore
//
//  Created by Shubroto Shuvo on 2/13/21.
//

import Foundation
import UIKit

/**
 Base Constraint structure used through out the framework for keeping a reference mostly
 
 All values are nil by default and will have values depending on the functions sets here. So make sure you know what constraints functions are setting and refer to it
 */
public struct JRAConstraintStruct {
    var top, bottom, left, right, centerX, centerY, width, height: NSLayoutConstraint?
    
    /**
     Use this to set spacing for the constraints here. It accepts normal positive values and convert them accordingly to fit the desired layout
     */
    public func setSpacing(top: CGFloat? = nil,
                           right: CGFloat? = nil,
                           bottom: CGFloat? = nil,
                           left: CGFloat? = nil) {
        if let top = top {
            self.top?.constant = top
        }
        if let right = right {
            self.right?.constant = -right
        }
        if let bottom = bottom {
            self.bottom?.constant = -bottom
        }
        if let left = left {
            self.left?.constant = left
        }
    }
}
