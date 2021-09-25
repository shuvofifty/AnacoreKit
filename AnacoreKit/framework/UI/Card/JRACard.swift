//
//  JRACard.swift
//  Anacore
//
//  Created by Shubroto Shuvo on 3/20/21.
//

import Foundation
import UIKit

/**
 This is a UIView with built in stackview and enhanced functionality to add views extremly easily
 
 - **Uses**: Instead of using UIView use this as it is easy to add views sideways, vertically with all the dimension set
 - **Background**: Uses stackview as the base
 */
open class JRACard: UIView {
    fileprivate struct ViewRefStruct {
        var wrapper: UIView
        var stack: UIStackView
    }
    
    /// Base stack that all views will go
    lazy open private(set) var stack: JRAStackView = {
        let stack = JRAStackView(subViews: [], spacing: 10, axis: .vertical)
        return stack
    }()
    
    /// Margin constraints from base stack to the JRACard View
    private var baseStackMargin: JRAConstraintStruct?
    private var viewMap: [String:ViewRefStruct] = [:]
    
    required public init() {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.backgroundColor = .clear
        
        // Setup UI
        self.addSubview(stack)
        
        baseStackMargin = stack.jraLayoutHookToAllSide(of: self, top: 0, right: 0, bottom: 0, left: 0)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
     Set the background color of the card
     
     - Parameter color: The color for the background of the card
     */
    open func setBackground(color: UIColor) -> JRACard {
        self.backgroundColor = color
        return self
    }
    
    /**
     Set the distribution spacing of the base stack
     
     - Parameter to: The equal distribution spacing of the rows
     */
    public func setRowSpacing(to val: CGFloat) -> JRACard {
        stack.spacing = val
        return self
    }
    
    /**
     Use this to set margin space from base stack view to the JRACard view
     
     - Setting the value nil **(which is already by default) ** will not apply any spacing change and will be whatever is set previously or 0 by default
     
     - Parameter top: Top spacing from stack view to JRACard view
     - Parameter right: Right spacing from stack view to JRACard view
     - Parameter left: Left spacing from stack view to JRACard view
     - Parameter Bottom: Bottom spacing from stack view to JRACard view
     */
    public func setMarginSpace(top: CGFloat? = nil,
                               right: CGFloat? = nil,
                               bottom: CGFloat? = nil,
                               left: CGFloat? = nil) -> JRACard {
        baseStackMargin?.setSpacing(top: top, right: right, bottom: bottom, left: left)
        return self
    }
    
    /**
     Adds a horizontal stackview row in the base stack with the desired config. The row should be represented with a unique key
     
     - **Warning**: Make sure for new elements you have unique key otherwise the component will be removed assigned to that key and will be replaced with the one newly created
     
     - It adds a new stackview with horizontal axis and all elemetns will be placed inside depending on layout priority
     
     - Parameters:
        - key: An unique key to identify the row
        - spacingBetweenElements: Space between the elements inside the row **(Default 10)**
        - marginTop: margin to top from row **(Default 0)**
        - marginRight: margin to right from row **(Default 0)**
        - marginBottom: margin to bottom from row **(Default 0)**
        - marginLeft: margin to left from row **(Default 0)**
        - elementDistribution: Stackview distribution style for the row
        - position: If you want to place the row to a certain position in base stackview instead of the at the end by default
     
     - Returns the key for the row created for further reference
     */
    public func addRow(key: String,
                       spacingBetweenElements: CGFloat = 10,
                       marginTop: CGFloat? = 0,
                       marginRight: CGFloat? = 0,
                       marginBottom: CGFloat? = 0,
                       marginLeft: CGFloat? = 0,
                       elementDistribution: UIStackView.Distribution = .fill,
                       position: Int? = nil) -> JRACard {
        let row = JRAStackView(subViews: [], spacing: spacingBetweenElements, axis: .horizontal)
        let (wrapper, _) = row.jraLayoutAddWrapper(top: marginTop, right: marginRight, bottom: marginBottom, left: marginLeft)
        
        row.distribution = elementDistribution
        
        let _ = removeRow(key: key) // Remove everything from that row map before adding elements
        
        if let position = position, stack.arrangedSubviews.count > position {
            stack.insertArrangedSubview(wrapper, at: position)
        } else {
            stack.addArrangedSubview(wrapper)
        }
        
        viewMap[key] = ViewRefStruct(wrapper: wrapper, stack: row)
        
        return self
    }
    
    /**
     Adds view to row that is assigned to the key passed
     
     - You can add as much view as you want. The hugging priority for this row is always set for horizontal
     
     - Parameters:
        - key: The unique key for the row to be added
        - view: The view that needs to be added to that row
        - huggingPriority: Set the hugging priority of the element added
        - indexPosition: The index position of the view to be placed. Pass -1 if no preference
     
     - Returns true if the reference to the row is found and element added to that row
     */
    public func addViewTo(key: String,
                          view: UIView,
                          huggingPriority: UILayoutPriority = .defaultLow,
                          indexPosition: Int = -1) -> JRACard {
        if let ref = viewMap[key] {
            if indexPosition <= -1 {
                ref.stack.addArrangedSubview(view)
            } else {
                ref.stack.insertArrangedSubview(view, at: indexPosition)
            }
            view.setContentCompressionResistancePriority(huggingPriority, for: .horizontal)
            view.setContentHuggingPriority(huggingPriority, for: .horizontal)
        }
        return self
    }
    
    /**
     Removes a row with from the card mentioned with the key
     
     - Returns true if row is found and removed else false if row with the key not found
     */
    public func removeRow(key: String) -> JRACard {
        if let ref = viewMap[key] {
            ref.wrapper.removeFromSuperview()
            viewMap.removeValue(forKey: key)
        }
        return self
    }
    
    /// Removes all the view from the card
    public func removeAllView() -> JRACard {
        for (key, _) in viewMap {
            let _ = removeRow(key: key)
        }
        viewMap = [:]
        return self
    }
}
