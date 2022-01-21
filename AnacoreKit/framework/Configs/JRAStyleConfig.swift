//
//  JRAStyleConfig.swift
//  Anacore
//
//  Created by Shubroto Shuvo on 2/13/21.
//

import Foundation
import UIKit

public struct JRAStyleDefaultFontConfig: JRAStyleFontConfigProtocol {
    public var defaultFontSize: UIFont { JRAStyleOswaldFont().getFont(with: 20, weight: .regular) }
    
    public var sFontSize: UIFont { JRAStyleOswaldFont().getFont(with: 16, weight: .regular) }
    
    public var xsFontSize: UIFont { JRAStyleOswaldFont().getFont(with: 14, weight: .regular) }
    
    public var xxsFontSize: UIFont { JRAStyleOswaldFont().getFont(with: 12, weight: .regular) }
    
    public var lFontSize: UIFont { JRAStyleOswaldFont().getFont(with: 22, weight: .regular) }
    
    public var xlFontSize: UIFont { JRAStyleOswaldFont().getFont(with: 28, weight: .regular) }
    
    public var xxlFontSize: UIFont { JRAStyleOswaldFont().getFont(with: 34, weight: .regular) }
}

public struct JRAStyleDefaultAlertColorConfig: JRAStyleAlertColorConfigProtocol {
    public var infoColor: UIColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
    
    public var successColor: UIColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
    
    public var errorColor: UIColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
    
    public var warningColor: UIColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
}

public struct JRAStyleDefaultBaseColorConfig: JRAStyleBaseColorConfigProtocol {
    public var background: UIColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    
    public var primaryColor: UIColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    
    public var secondaryColor: UIColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    
    public var tertiaryColor: UIColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
}

public struct JRAStyleDefaultFontColorConfig: JRAStyleFontColorConfigProtocol {
    public var black: UIColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    
    public var white: UIColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    
    public var primary: UIColor = #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1)
}

public struct JRAStyleRobotoFont: JRAStyleCustomFontProtocol {
    
    public init() {}
    
    public func getFont(with size: CGFloat, weight: UIFont.Weight) -> UIFont {
        UIFont(name: getFontName(with: weight), size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    public func getFontName(with weight: UIFont.Weight) -> String {
        switch weight {
        case .black: return "Roboto-Black"
        case .bold, .semibold, .heavy: return "Roboto-Bold"
        case .light, .ultraLight: return "Roboto-Light"
        case .medium: return "Roboto-Medium"
        case .regular: return "Roboto-Regular"
        case .thin: return "Roboto-Thin"
        default: return "Roboto-Regular"
        }
    }
    
    public func registerAsDefaultFont(with bundle: Bundle) {
        UIFont.jraRegisterFrameworkFont(withFilenameString: "\(self.getFontName(with: .black)).ttf", bundle: bundle)
        UIFont.jraRegisterFrameworkFont(withFilenameString: "\(self.getFontName(with: .bold)).ttf", bundle: bundle)
        UIFont.jraRegisterFrameworkFont(withFilenameString: "\(self.getFontName(with: .light)).ttf", bundle: bundle)
        UIFont.jraRegisterFrameworkFont(withFilenameString: "\(self.getFontName(with: .medium)).ttf", bundle: bundle)
        UIFont.jraRegisterFrameworkFont(withFilenameString: "\(self.getFontName(with: .regular)).ttf", bundle: bundle)
        UIFont.jraRegisterFrameworkFont(withFilenameString: "\(self.getFontName(with: .thin)).ttf", bundle: bundle)
    }
}

public struct JRAStyleOswaldFont: JRAStyleCustomFontProtocol {
    
    public init() {}
    
    public func getFont(with size: CGFloat, weight: UIFont.Weight) -> UIFont {
        UIFont(name: getFontName(with: weight), size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    public func getFontName(with weight: UIFont.Weight) -> String {
        switch weight {
        case .bold, .heavy, .black: return "Oswald-Bold"
        case .semibold: return "Oswald-SemiBold"
        case .ultraLight, .thin: return "Oswald-ExtraLight"
        case .light: return "Oswald-Light"
        case .medium: return "Oswald-Medium"
        case .regular: return "Oswald-Regular"
        default: return "Oswald-Regular"
        }
    }
    
    public func registerAsDefaultFont(with bundle: Bundle) {
        UIFont.jraRegisterFrameworkFont(withFilenameString: "\(self.getFontName(with: .ultraLight)).ttf", bundle: bundle)
        UIFont.jraRegisterFrameworkFont(withFilenameString: "\(self.getFontName(with: .bold)).ttf", bundle: bundle)
        UIFont.jraRegisterFrameworkFont(withFilenameString: "\(self.getFontName(with: .light)).ttf", bundle: bundle)
        UIFont.jraRegisterFrameworkFont(withFilenameString: "\(self.getFontName(with: .medium)).ttf", bundle: bundle)
        UIFont.jraRegisterFrameworkFont(withFilenameString: "\(self.getFontName(with: .regular)).ttf", bundle: bundle)
        UIFont.jraRegisterFrameworkFont(withFilenameString: "\(self.getFontName(with: .semibold)).ttf", bundle: bundle)
    }
}
