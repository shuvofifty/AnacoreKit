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
public protocol JRAStyleBaseColorConfigProtocol {
    var primaryColor: UIColor { get }
    var secondaryColor: UIColor { get }
    var tertiaryColor: UIColor { get }
    var background: UIColor { get }
}

public protocol JRAStyleFontColorConfigProtocol {
    var black: UIColor { get }
    var white: UIColor { get }
    var primary: UIColor { get }
}

/**
 Basic alert colors for using in alert type
 */
public protocol JRAStyleAlertColorConfigProtocol {
    var infoColor: UIColor { get }
    var successColor: UIColor { get }
    var errorColor: UIColor { get }
    var warningColor: UIColor { get }
}

/**
 Basic font configuration for various sizes
 */
public protocol JRAStyleFontConfigProtocol {
    var defaultFontSize: UIFont { get }
    /// Small Font
    var sFontSize: UIFont { get }
    /// Extra small font
    var xsFontSize: UIFont { get }
    /// Extra extra small font
    var xxsFontSize: UIFont { get }
    /// Large font
    var lFontSize: UIFont { get }
    /// Extra large font
    var xlFontSize: UIFont { get }
    /// Extra extra large font
    var xxlFontSize: UIFont { get }
}

public protocol JRAStyleCustomFontProtocol {
    /**
     Get custom UI Font with specific size and speicific weight
     
     - Important: Every weight need to be mapped with the correct font and must follow the apple default weight enum
     */
    func getFont(with size: CGFloat, weight: UIFont.Weight) -> UIFont
    
    /**
     Get font name with weight
     
     - Important: Every weight need to be mapped with the correct font and must follow the apple default weight enum
     */
    func getFontName(with weight: UIFont.Weight) -> String
    
    /**
     Register default Fonts from framework in your project
     
     - Important: Make sure you call this in your app delegate to enable to register the font programmatically in order to make it work properly
     */
    func registerAsDefaultFont(with bundle: Bundle)
}
