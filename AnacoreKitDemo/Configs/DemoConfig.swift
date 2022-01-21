//
//  DemoConfig.swift
//  AnacoreKitDemo
//
//  Created by Shubroto Shuvo on 1/21/22.
//

import AnacoreKit
import Foundation
import UIKit

public struct DemoStyleFontConfig: JRAStyleFontConfigProtocol {
    public var defaultFontSize: UIFont { JRASharedConfigContainer.shared.defaultFont.getFont(with: 20, weight: .regular) }
    
    public var sFontSize: UIFont { JRASharedConfigContainer.shared.defaultFont.getFont(with: 16, weight: .regular) }
    
    public var xsFontSize: UIFont { JRASharedConfigContainer.shared.defaultFont.getFont(with: 14, weight: .regular) }
    
    public var xxsFontSize: UIFont { JRASharedConfigContainer.shared.defaultFont.getFont(with: 12, weight: .regular) }
    
    public var lFontSize: UIFont { JRASharedConfigContainer.shared.defaultFont.getFont(with: 22, weight: .regular) }
    
    public var xlFontSize: UIFont { JRASharedConfigContainer.shared.defaultFont.getFont(with: 28, weight: .regular) }
    
    public var xxlFontSize: UIFont { JRASharedConfigContainer.shared.defaultFont.getFont(with: 34, weight: .regular) }
}

public struct DemoStyleAlertColorConfig: JRAStyleAlertColorConfigProtocol {
    public var infoColor: UIColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
    
    public var successColor: UIColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
    
    public var errorColor: UIColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
    
    public var warningColor: UIColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
}

public struct DemoStyleBaseColorConfig: JRAStyleBaseColorConfigProtocol {
    public var background: UIColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    
    public var primaryColor: UIColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    
    public var secondaryColor: UIColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    
    public var tertiaryColor: UIColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
}

public struct DemoStyleFontColorConfig: JRAStyleFontColorConfigProtocol {
    public var black: UIColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
    
    public var white: UIColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    
    public var primary: UIColor = #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1)
}
