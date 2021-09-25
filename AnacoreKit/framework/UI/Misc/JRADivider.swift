//
//  JRADivider.swift
//  Anacore
//
//  Created by Shubroto Shuvo on 4/6/21.
//

import Foundation
import UIKit

open class JRADivider: UIView {
    public var fatness: CGFloat = 5 {
        didSet {
            set()
        }
    }
    public var axis: NSLayoutConstraint.Axis = .horizontal {
        didSet {
            set()
        }
    }
    public var color: UIColor = .black {
        didSet {
            set()
        }
    }
    
    private var widthHeightConstraintStruct: JRAConstraintStruct?
    
    required public init(axis: NSLayoutConstraint.Axis,
                         fatness: CGFloat,
                         color: UIColor) {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.fatness = fatness
        self.axis = axis
        self.color = color
        
        set()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// This is used by the property to set the divider UI
    open func set() {
        if axis == .horizontal {
            if let heightConstraint = widthHeightConstraintStruct?.height { // Remove the height constraint only
                self.removeConstraint(heightConstraint)
            }
            widthHeightConstraintStruct = self.jraLayoutSet(width: nil, height: fatness)
        } else {
            if let widthConstraint = widthHeightConstraintStruct?.width { // Remove the width constraint only
                self.removeConstraint(widthConstraint)
            }
            widthHeightConstraintStruct = self.jraLayoutSet(width: fatness, height: nil)
        }
        self.backgroundColor = color
    }
}
