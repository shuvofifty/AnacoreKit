//
//  JRAStyleProtocols.swift
//  Anacore
//
//  Created by Shubroto Shuvo on 2/13/21.
//

import Foundation
import UIKit

/**
 Basic colors for overall app
 */
protocol JRAStyleBaseColorConfigProtocol {
    var primaryColor: UIColor { get }
    var secondaryColor: UIColor { get }
    var tertiaryColor: UIColor { get }
    var background: UIColor { get }
}

/**
 Basic alert colors for using in alert type
 */
protocol JRAStyleAlertColorConfigProtocol {
    var infoColor: UIColor { get }
    var successColor: UIColor { get }
    var errorColor: UIColor { get }
    var warningColor: UIColor { get }
}

/**
 Basic font configuration for various sizes
 */
protocol JRAStyleFontConfigProtocol {
    var defaultFontSize: CGFloat { get }
    /// Small Font
    var sFontSize: CGFloat { get }
    /// Extra small font
    var xsFontSize: CGFloat { get }
    /// Extra extra small font
    var xxsFontSize: CGFloat { get }
    /// Large font
    var lFontSize: CGFloat { get }
    /// Extra large font
    var xlFontSize: CGFloat { get }
    /// Extra extra large font
    var xxlFontSize: CGFloat { get }
}
