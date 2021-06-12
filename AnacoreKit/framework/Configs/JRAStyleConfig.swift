//
//  JRAStyleConfig.swift
//  Anacore
//
//  Created by Shubroto Shuvo on 2/13/21.
//

import Foundation
import UIKit

/**
 Configuration helper class for styles for the framework component
 
 - Able to inject your own custom configs. Just create a struct which implements the config protocol
    - JRAStyleBaseColorConfigProtocol
    - JRAStyleAlertColorConfigProtocol
    - JRAStyleFontConfigProtocol
 - By default it will use the JRA Default style config struct
 */
class JRAStyleHelper {
    typealias StyleProtocols = JRAStyleBaseColorConfigProtocol & JRAStyleAlertColorConfigProtocol & JRAStyleFontConfigProtocol
    
    static let shared = JRAStyleHelper()
    
    public private(set) var styleConfig: StyleProtocols
    
    private init() {
        styleConfig = JRAStyleDefaultConfig()
    }
    
    func setStyleConfig(config: StyleProtocols) {
        styleConfig = config
    }
}

struct JRAStyleDefaultConfig: JRAStyleBaseColorConfigProtocol, JRAStyleAlertColorConfigProtocol, JRAStyleFontConfigProtocol {
    var defaultFontSize: CGFloat = 18
    
    var sFontSize: CGFloat = 16
    
    var xsFontSize: CGFloat = 14
    
    var xxsFontSize: CGFloat = 12
    
    var lFontSize: CGFloat = 22
    
    var xlFontSize: CGFloat = 25
    
    var xxlFontSize: CGFloat = 30
    
    var background: UIColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    
    var primaryColor: UIColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    
    var secondaryColor: UIColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    
    var tertiaryColor: UIColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
    
    var infoColor: UIColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
    
    var successColor: UIColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
    
    var errorColor: UIColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
    
    var warningColor: UIColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
}
