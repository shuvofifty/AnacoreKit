//
//  JRABorderLabel.swift
//  Anacore
//
//  Created by Shubroto Shuvo on 4/1/21.
//

import Foundation
import UIKit

/**
 A wrapper view of UI label to have a border around or with the background of UILabel. Use spaceConstraint to change space between border and label
 */
open class JRABorderLabel: UIView, JRALabelHuggingProtocol {
    public lazy var label: JRALabel = {
        let view = JRALabel(text: "")
        return view
    }()
    
    public var spaceConstraint: JRAConstraintStruct!
    
    required public init(text: String) {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = text
        
        self.addSubview(label)
        spaceConstraint = label.jraLayoutHookToAllSide(of: self)
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

public protocol JRALabelHuggingProtocol {
    var label: JRALabel { get }
}
