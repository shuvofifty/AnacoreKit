//
//  JRALayoutHelper.swift
//  Anacore
//
//  Created by Shubroto Shuvo on 2/13/21.
//

import Foundation
import UIKit

extension UIView {
    /**
     🤠 Hooks the child view to side of parent view.
     
     **WARNING:** The view must be added before calling this function
     
     - Returns: A constraint struct of all the constraint added for reference in future
     */
    public func jraLayoutHookToAllSide(of parent: UIView, top: CGFloat? = 0, right: CGFloat? = 0, bottom: CGFloat? = 0, left: CGFloat? = 0) -> JRAConstraintStruct {
        var mainCon = JRAConstraintStruct()
        if let top = top {
            mainCon.top = self.topAnchor.constraint(equalTo: parent.topAnchor, constant: top)
            mainCon.top?.isActive = true
        }
        if let right = right {
            mainCon.right = self.rightAnchor.constraint(equalTo: parent.rightAnchor, constant: -right)
            mainCon.right?.isActive = true
        }
        if let bottom = bottom {
            mainCon.bottom = self.bottomAnchor.constraint(equalTo: parent.bottomAnchor, constant: -bottom)
            mainCon.bottom?.isActive = true
        }
        if let left = left {
            mainCon.left = self.leftAnchor.constraint(equalTo: parent.leftAnchor, constant: left)
            mainCon.left?.isActive = true
        }
        return mainCon
    }
    
    /**
     🤠 Set width and/or height of a view
     
     If you want to set either one of the properties just provide the value for that and the other one to nil
     
     - Returns: A width height constraint struct for reference in future
     */
    public func jraLayoutSet(width: CGFloat? = nil, height: CGFloat? = nil) -> JRAConstraintStruct {
        var mainCon = JRAConstraintStruct()
        if let width = width {
            mainCon.width = self.widthAnchor.constraint(equalToConstant: width)
            mainCon.width?.isActive = true
        }
        if let height = height {
            mainCon.height = self.heightAnchor.constraint(equalToConstant: height)
            mainCon.height?.isActive = true
        }
        return mainCon
    }
    
    /**
     🤠 Center x and/or y to parent element
     
     **WARNING:** The view must be added before calling this function
     
     - Returns: A center x and/or center y constraint structure for reference in future
     */
    public func jraLayoutCenter(to parent: UIView, x: CGFloat? = nil, y: CGFloat? = nil) -> JRAConstraintStruct {
        var mainCon = JRAConstraintStruct()
        if let x = x {
            mainCon.centerX = self.centerXAnchor.constraint(equalTo: parent.centerXAnchor, constant: x)
            mainCon.centerX?.isActive = true
        }
        if let y = y {
            mainCon.centerY = self.centerYAnchor.constraint(equalTo: parent.centerYAnchor, constant: y)
            mainCon.centerY?.isActive = true
        }
        return mainCon
    }
    
    /**
     🤯 Adds a UIView as wrapper to current view which is the child of wrapper view
     
    - Mostly used for padding or margin of a view or isolate a view in a view. Heavily uses in stack for images
     
    - **Warning:** Becareful of putting the values in parameter. Make sure you have good understanding of how constraint work so that you don't have a conflicting constraint and break the layout
     
    - Set value to nil if you don't want to add a particular constraint. For example, if you don't want top constraint just set top param to nil
     
     - Parameter top: Top spacing from wrapper view to child view
     - Parameter right: Right spacing from wrapper view to child view
     - Parameter left: Left spacing from wrapper view to child view
     - Parameter Bottom: Bottom spacing from wrapper view to child view
     - Parameter x: Horizontal spacing from wrapper view to child view
     - Parameter y: Vertical spacing from wrapper view to child view
     - Parameter width: Width of the view
     - Parameter height: Height of the view
     
     - Returns: The wrapper UIView and a constraint struct of the ones added for future reference
     */
    public func jraLayoutAddWrapper(top: CGFloat? = nil, right: CGFloat? = nil, bottom: CGFloat? = nil, left: CGFloat? = nil, x: CGFloat? = nil, y: CGFloat? = nil, width: CGFloat? = nil, height: CGFloat? = nil) -> (UIView, JRAConstraintStruct) {
        let wrapper = UIView()
        wrapper.translatesAutoresizingMaskIntoConstraints = false
        
        wrapper.addSubview(self)
        
        let sideCon = self.jraLayoutHookToAllSide(of: wrapper, top: top, right: right, bottom: bottom, left: left)
        let centerCon = self.jraLayoutCenter(to: wrapper, x: x, y: y)
        let sizeCon = self.jraLayoutSet(width: width, height: height)
        
        var mainCon = JRAConstraintStruct()
        mainCon.top = sideCon.top
        mainCon.bottom = sideCon.bottom
        mainCon.left = sideCon.left
        mainCon.right = sideCon.right
        
        mainCon.centerY = centerCon.centerY
        mainCon.centerX = centerCon.centerX
        
        mainCon.width = sizeCon.width
        mainCon.height = sizeCon.height
        
        return (wrapper, mainCon)
    }
}
