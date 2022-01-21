//
//  JRAConfigContainer.swift
//  AnacoreKit
//
//  Created by Shubroto Shuvo on 9/26/21.
//

import Foundation


/**
 Its a container that have all the shared dependencies and can be shared or injected however you want.
 
 - The concept of using Config Container is to setup all configuration of the app in the app delegate and either you inject into your controllers or use the shared instance to access them from any where of the app
 - Its used to tackle the problem of testing especially if you inject the config container which will be easy to do the testing
 */
public class JRAConfigContainer {
    public private(set) var fontSizeConfig: JRAStyleFontConfigProtocol
    public private(set) var alertConfig: JRAStyleAlertColorConfigProtocol
    public private(set) var baseColorConfig: JRAStyleBaseColorConfigProtocol
    public private(set) var fontColorConfig: JRAStyleFontColorConfigProtocol
    public private(set) var defaultFont: JRAStyleCustomFontProtocol
    
    public init(fontSizeConfig: JRAStyleFontConfigProtocol,
                alertConfig: JRAStyleAlertColorConfigProtocol,
                baseColorConfig: JRAStyleBaseColorConfigProtocol,
                fontColorConfig: JRAStyleFontColorConfigProtocol,
                defaultFont: JRAStyleCustomFontProtocol) {
        self.fontSizeConfig = fontSizeConfig
        self.alertConfig = alertConfig
        self.baseColorConfig = baseColorConfig
        self.fontColorConfig = fontColorConfig
        self.defaultFont = defaultFont
    }
    
    /**
     Update the style configuration with your own custom config and the changes will be applied to all components and sub components
     */
    public func update(fontSizeConfig: JRAStyleFontConfigProtocol,
                       alertConfig: JRAStyleAlertColorConfigProtocol,
                       baseColorConfig: JRAStyleBaseColorConfigProtocol,
                       fontColorConfig: JRAStyleFontColorConfigProtocol,
                       defaultFont: JRAStyleCustomFontProtocol) {
        self.fontSizeConfig = fontSizeConfig
        self.alertConfig = alertConfig
        self.baseColorConfig = baseColorConfig
        self.fontColorConfig = fontColorConfig
        self.defaultFont = defaultFont
    }
}

/**
 A shared config container for all the default configuration for the app config.
 */
public class JRASharedConfigContainer {
    public static let shared = JRAConfigContainer(fontSizeConfig: JRAStyleDefaultFontConfig(),
                                                  alertConfig: JRAStyleDefaultAlertColorConfig(),
                                                  baseColorConfig: JRAStyleDefaultBaseColorConfig(),
                                                  fontColorConfig: JRAStyleDefaultFontColorConfig(),
                                                  defaultFont: JRAStyleOswaldFont())
    
    private init() {}
}
