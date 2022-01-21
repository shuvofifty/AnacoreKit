//
//  JRAConfigContainer.swift
//  AnacoreKit
//
//  Created by Shubroto Shuvo on 9/26/21.
//

import Foundation


/**
 Its a container that have all the shared dependencies and can be shared or injected however you want.
 
 - Important: No need to instantiate this class. The public init is only for **testing** so that its easy to inject fake classes for better tests
 - Important: The config container can be **updated once** and best recommendation is to do it in app delegate otherwise not
 - Important: Access this using **JRASharedConfigContainer.shared**
 - Important: **(Not Recommended)** All default framework components are using this. If you want to have your own instance of this class and also want to update the framework components with this instance then use **JRASharedConfigContainer.shared.update(...)**  as all default component will use the share version **JRASharedConfigContainer.shared**
 
 - The concept of using Config Container is to setup all configuration of the app in the app delegate and either you inject into your controllers or use the shared instance to access them from any where of the app
 - This container have configs of these stuffs:
    - fontSizeConfig: JRAStyleFontConfigProtocol
    - alertConfig: JRAStyleAlertColorConfigProtocol
    - baseColorConfig: JRAStyleBaseColorConfigProtocol
    - fontColorConfig: JRAStyleFontColorConfigProtocol
    - defaultFont: JRAStyleCustomFontProtocol
    - Logging: JRALoggingEngineProtocol
 */
public class JRAConfigContainer {
    public private(set) var fontSizeConfig: JRAStyleFontConfigProtocol
    public private(set) var alertConfig: JRAStyleAlertColorConfigProtocol
    public private(set) var baseColorConfig: JRAStyleBaseColorConfigProtocol
    public private(set) var fontColorConfig: JRAStyleFontColorConfigProtocol
    public private(set) var defaultFont: JRAStyleCustomFontProtocol
    /**
     Helper class to log all your dev stuffs
     
     - Use this instead of basic print functionality for advance and easy level of logging
     - Inject your implementation class of how you want to display or do with the logs
     */
    public private(set) var logEngine: JRALoggingEngineProtocol
    
    private var configUpdated: Int = 0
    
    public init(fontSizeConfig: JRAStyleFontConfigProtocol,
         alertConfig: JRAStyleAlertColorConfigProtocol,
         baseColorConfig: JRAStyleBaseColorConfigProtocol,
         fontColorConfig: JRAStyleFontColorConfigProtocol,
         defaultFont: JRAStyleCustomFontProtocol,
         logEngine: JRALoggingEngineProtocol) {
        self.fontSizeConfig = fontSizeConfig
        self.alertConfig = alertConfig
        self.baseColorConfig = baseColorConfig
        self.fontColorConfig = fontColorConfig
        self.defaultFont = defaultFont
        self.logEngine = logEngine
    }
    
    /**
     Block updating the config container so that no one can update the shared configuration in the middle of the app
     
     - This is used to block update of the container  when you create your own custom **JRAConfigContainer** and then use it in your own way like injecting or your own shared instance  instead of using the JRA Provided **JRASharedConfigContainer**
     */
    func blockUpdate() {
        configUpdated = 1
    }
    
    /**
     Update the style configuration with your own custom config and the changes will be applied to all components and sub components
     */
    public func update(fontSizeConfig: JRAStyleFontConfigProtocol,
                       alertConfig: JRAStyleAlertColorConfigProtocol,
                       baseColorConfig: JRAStyleBaseColorConfigProtocol,
                       fontColorConfig: JRAStyleFontColorConfigProtocol,
                       defaultFont: JRAStyleCustomFontProtocol,
                       logEngine: JRALoggingEngineProtocol) {
        guard configUpdated == 0 else {
            logEngine.log("Config Container can be updated only once")
            return
        }
        self.fontSizeConfig = fontSizeConfig
        self.alertConfig = alertConfig
        self.baseColorConfig = baseColorConfig
        self.fontColorConfig = fontColorConfig
        self.defaultFont = defaultFont
        self.logEngine = logEngine
        
        configUpdated = 1
    }
}

/**
 A shared config container for all the default configuration for the app config.
 
 - This shared container is being used by every component in the framework by default
 */
public class JRASharedConfigContainer {
    public static let shared = JRAConfigContainer(
        fontSizeConfig: JRAStyleDefaultFontConfig(),
        alertConfig: JRAStyleDefaultAlertColorConfig(),
        baseColorConfig: JRAStyleDefaultBaseColorConfig(),
        fontColorConfig: JRAStyleDefaultFontColorConfig(),
        defaultFont: JRAStyleOswaldFont(),
        logEngine: JRADefaultLogEngine()
    )
    
    private init() {}
}
