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
    /**
     - Able to inject your own custom configs. Just create a struct which implements the config protocol
        - JRAStyleBaseColorConfigProtocol
        - JRAStyleAlertColorConfigProtocol
        - JRAStyleFontConfigProtocol
     */
    public typealias StyleProtocols = JRAStyleBaseColorConfigProtocol & JRAStyleAlertColorConfigProtocol & JRAStyleFontConfigProtocol
    
    private var styleConfig: StyleProtocols!
    
    public init(styleConfig: StyleProtocols) {
        self.styleConfig = styleConfig
    }
}

/**
 A shared config container for all the default configuration for the app config.
 */
public class JRASharedConfigContainer {
    static let shared = JRAConfigContainer(styleConfig:  JRAStyleDefaultConfig())
    
    private init() {}
}
