//
//  JRATable.swift
//  AnacoreKit
//
//  Created by Shubroto Shuvo on 7/27/21.
//

import Foundation
import UIKit

open class JRATable: UITableView {
    required public init(style: UITableView.Style = .plain) {
        super.init(frame: .zero, style: style)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
