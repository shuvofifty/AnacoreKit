//
//  JRAStackView.swift
//  Anacore
//
//  Created by Shubroto Shuvo on 2/13/21.
//

import Foundation
import UIKit

/**
 Custom stack view which should be used instead of regular stack view for extra functionality
 */
open class JRAStackView: UIStackView {
    required public init(subViews: [UIView] = [], spacing: CGFloat = 10, axis: NSLayoutConstraint.Axis = .vertical) {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        for view in subViews {
            self.addArrangedSubview(view)
        }
        self.distribution = .fill
        self.axis = axis
        self.spacing = spacing
    }
    
    public required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
