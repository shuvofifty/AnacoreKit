//
//  JRARootVC.swift
//  Anacore
//
//  Created by Shubroto Shuvo on 2/13/21.
//

import Foundation
import UIKit

/**
 Protocols that other component  in **Anacore** framework uses to communicate back to the View controller
 
 - **Uses**: Simply implement the functions and connect the appropriate delegates
 */
protocol JRARootVCMainProtocol {
    
}

/**
 Root View controller for all the screens
 
 - Use this instead of UIViewController as all the component have support for this class and also recomennded for any new screen you work on
 - Already implements JRARootVCMainProtocol for ease of use
 */
open class JRARootVC: UIViewController, JRARootVCMainProtocol {
    open override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = JRAStyleHelper.shared.styleConfig.background
    }
}
