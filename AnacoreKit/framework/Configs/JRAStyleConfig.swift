//
//  JRAStyleConfig.swift
//  Anacore
//
//  Created by Shubroto Shuvo on 2/13/21.
//

import Foundation
import UIKit

public struct JRAStyleDefaultConfig: JRAStyleBaseColorConfigProtocol, JRAStyleAlertColorConfigProtocol, JRAStyleFontConfigProtocol {
    public var defaultFontSize: CGFloat = 18
    
    public var sFontSize: CGFloat = 16
    
    public var xsFontSize: CGFloat = 14
    
    public var xxsFontSize: CGFloat = 12
    
    public var lFontSize: CGFloat = 22
    
    public var xlFontSize: CGFloat = 25
    
    public var xxlFontSize: CGFloat = 30
    
    public var background: UIColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    
    public var primaryColor: UIColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    
    public var secondaryColor: UIColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    
    public var tertiaryColor: UIColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
    
    public var infoColor: UIColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
    
    public var successColor: UIColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
    
    public var errorColor: UIColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
    
    public var warningColor: UIColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
}
