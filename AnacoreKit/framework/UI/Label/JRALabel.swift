//
//  JRALabel.swift
//  Anacore
//
//  Created by Shubroto Shuvo on 4/1/21.
//

import Foundation
import UIKit

/**
 Custom UILabel with added functionality and easily change fonts and color and boldness
 
 - Subclass this if you need to add more functionality
 - Functions:
    - Ability to tap on the label to create some action
    - Change size with one code
    - Change weight with one code
 */
open class JRALabel: UILabel {
    public typealias TapCompletionType = (_ val: Any?) -> Void
    
    /// Font size
    public var size: CGFloat = 18 {
        didSet {
            updateFontSystem()
        }
    }
    
    /// Font weight
    public var weight: UIFont.Weight = .regular {
        didSet {
            updateFontSystem()
        }
    }
    
    public var customFont: JRAStyleCustomFontProtocol!
    
    private var tapClosure: TapCompletionType = {any in }
    private var tapValue: Any? = nil
    
    private var tapGestrureRe: UITapGestureRecognizer?
    
    required public init(text: String,
                         font: UIFont = JRASharedConfigContainer.shared.fontSizeConfig.defaultFontSize,
                         color: UIColor = JRASharedConfigContainer.shared.fontColorConfig.black,
                         customFontConfig: JRAStyleCustomFontProtocol = JRASharedConfigContainer.shared.defaultFont) {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.customFont = customFontConfig
        self.text = text
        self.numberOfLines = 1
        self.font = font
        self.textColor = color
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
     No need to call this from outside. Used this to override only. Setting size and weight will trigger this
     */
    open func updateFontSystem() {
        self.font = customFont.getFont(with: size, weight: weight)
    }
    
    /**
     Quick helper function to change the font style of size and weight in function
     
     - Parameters:
        - size: Size of the font mentioned
        - weight: Weight of the font mentioned
     */
    open func changeStyle(size: CGFloat, weight: UIFont.Weight) {
        self.size = size
        self.weight = weight
    }
    
    /**
     Make the whole UI Label tappable with passed value and completion when the user tap on the label
     */
    open func addTapFeature(value: Any?, completion: @escaping TapCompletionType) {
        if tapGestrureRe == nil {
            tapGestrureRe = UITapGestureRecognizer(target: self, action: #selector(labelTapped))
        }
        self.isUserInteractionEnabled = true
        self.tapValue = value
        self.tapClosure = completion
        self.addGestureRecognizer(tapGestrureRe!)
    }
    
    @objc private func labelTapped() {
        tapClosure(tapValue)
    }
}
