//
//  JRATextField.swift
//  Anacore
//
//  Created by Shubroto Shuvo on 4/6/21.
//

import Foundation
import UIKit

/**
 Custom JRA Text Field with ability to add views on both side of the text field.
 
 - Important:
    - Implementations:
        - Uses the basic form of UIText field in the center and added left and right stack view.
        - The whole thing is put on a **textFieldCard** to add its custom padding and background
        - There is a **base** where all the views goes which includes header, info/ error label and textFieldCard
    - Override this to create your own design of textfield utilizing the functionality it comes with. Override **setupUI** to add the elements or placement.
 */
open class JRATextField: UIView {
    static let titleRowKey = "textFieldTitleRow_JRA88933421"
    static let textFieldRowKey = "textFieldRow_JRA8890323"
    static let infoRowKey = "textFieldInfoRow_JRA8894412"
    
    /// All UI Related to textfield will go here
    public lazy var base: JRACard = {
        let card = JRACard()
        
        return card
    }()
    
    /// The whole textfield with left stack view, textfield and right stack view will go into this card. It can have margin space and own color and complete seperate from other row in the base card view
    public lazy var textFieldCard: JRACard = {
        let card = JRACard()
        
        let textFieldRow = card.addRow(key: JRATextField.textFieldRowKey)
        let _ = card.addViewTo(key: textFieldRow, view: field, huggingPriority: .defaultLow)
        
        card.setMarginSpace(top: 5, right: 0, bottom: 0, left: 0)
        
        return card
    }()
    
    /// The main text field to refer to
    public lazy var field: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    /// Left side of the text field to use
    public lazy var leftStack: JRAStackView = {
        let stack = JRAStackView(axis: .horizontal)
        return stack
    }()
    
    /// Right side of the text field to use
    public lazy var rightStack: JRAStackView = {
        let stack = JRAStackView(axis: .horizontal)
        return stack
    }()
    
    /// Header of the text field
    public lazy var titleLabel: JRALabel = {
        let label = JRALabel(text: "Default header")
        return label
    }()
    
    /// Header of the text field
    public lazy var infoLabel: JRALabel = {
        let label = JRALabel(text: "")
        return label
    }()
    
    public lazy var textFieldDivider: JRADivider = {
        let divider = JRADivider(axis: .horizontal, fatness: 2, color: .black)
        return divider
    }()
    
    init() {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        setupUI()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
     Setup UI Constraint. **No need to call this from outside. Use for overriding if necessary for subclass**
     */
    open func setupUI() {
        // Add UI
        self.addSubview(base)
        
        let _ = base.jraLayoutHookToAllSide(of: self)
        
        let _ = base.addViewTo(key: base.addRow(key: JRATextField.titleRowKey), view: titleLabel)
        let _ = base.addViewTo(key: base.addRow(key: "textFieldCardRow_JRA8891212"), view: textFieldCard, huggingPriority: .defaultLow)
        let _ = base.addViewTo(key: base.addRow(key: "textFieldDividerRow_JRA8896123"), view: textFieldDivider)
        let _ = base.addViewTo(key: base.addRow(key: JRATextField.infoRowKey), view: infoLabel)
    }
    
    /**
     Set the title of the textfield
     
     - Parameters:
        - title: Title of the text field
     */
    open func set(title: String) {
        titleLabel.text = title
    }
    
    /**
     Set the placeholder of the textfield
     
     - Parameters:
        - placeHolder: Placeholder of the text field
     */
    open func set(placeHolder: String) {
        field.placeholder = placeHolder
    }
    
    /**
     Add a view to left side of the text field
     
     - Implementation notes:
        - This uses a stack view at left and use this function to add views to left view
        - It checks first if there views and if not then it add the left stack first then it add the view
        - **leftStack** is used for this. Change the property of that view directly if needed
     - Override Notes:
        - Make sure you understand the implementation first before overriding to avoid any UX bug
     
     - Parameters:
        - left: An UIView to be added to the left
     */
    open func addViewTo(left view: UIView) {
        if leftStack.subviews.count == 0 { // Add the left stack first
            let _ = textFieldCard.addViewTo(key: JRATextField.textFieldRowKey, view: leftStack, huggingPriority: .defaultHigh, indexPosition: 0)
        }
        leftStack.addArrangedSubview(view)
    }
    
    /**
     Removes a view from the left side of the view
     
     - Important:
        - Use this to remove view instead of removing the view directly as this will also remove the stackview if no view present to prevent UX bugs
     
     - Parameters:
        - left: An UIView to be removed
     */
    open func removeViewFrom(left view: UIView) {
        view.removeFromSuperview()
        if leftStack.subviews.count == 0 { // If no element remove the view
            leftStack.removeFromSuperview()
        }
    }
    
    /**
     Add a view to right side of the text field
     
     - Implementation notes:
        - This uses a stack view at left and use this function to add views to left view
        - It checks first if there views and if not then it add the left stack first then it add the view
        - **rightStack** is used for this. Change the property of that view directly if needed
     - Override Notes:
        - Make sure you understand the implementation first before overriding to avoid any UX bug
     
     - Parameters:
        - left: An UIView to be added to the left
     */
    open func addViewTo(right view: UIView) {
        if rightStack.subviews.count == 0 { // Add the left stack first
            let _ = textFieldCard.addViewTo(key: JRATextField.textFieldRowKey, view: rightStack, huggingPriority: .defaultHigh)
        }
        rightStack.addArrangedSubview(view)
    }
    
    /**
     Removes a view from the right side of the view
     
     - Important:
        - Use this to remove view instead of removing the view directly as this will also remove the stackview if no view present to prevent UX bugs
     
     - Parameters:
        - right: An UIView to be removed
     */
    open func removeViewFrom(right view: UIView) {
        view.removeFromSuperview()
        if rightStack.subviews.count == 0 { // If no element remove the view
            rightStack.removeFromSuperview()
        }
    }
}
