//
//  JRARootTableViewCell.swift
//  AnacoreKit
//
//  Created by Shubroto Shuvo on 2/3/22.
//

import Foundation
import UIKit

public protocol JRARootTableViewCellProtocol {
    /**
     Render all UI components when cell is first loaded or reused
     
    - Important
        - This should be only responsible for rendering the UI first time and basic adding constraints and adding to view nothing else
        - indexPath of the cell is stored to send for registered actions back to datasource
     
     - Parameters:
            - indexPath: The whole index path of the data thats registered to this cell
     */
    func renderSetupUI(indexPath: IndexPath)
    /**
     Configure the cell with necessary datas and represent the cell with an unique id
     
     */
    func configure(with data: Any, uid: Any)
}

/**
 Sends back data from cell to datasource
 
 - Mostly used through button tapped action or some other targeted event
 */
public protocol JRADatasourceCallBackProtocol {
    /**
     Send target event from cell back to datasource when user does some action
     
     - Parameters:
        - type: Event type to see if its clicked or swiped or anything elese. ** Use JRAUserAction** if meeded. Use the type to register in implementation about what the user did back in the cell.
        - value: The value you like to pass back to the datsource
        - indexPath: Index path of the data cell
        - uid: unique id for the cell to identify
     */
    func sendTargetEvent(with type: Any,
                         value: Any,
                         indexPath: IndexPath,
                         uid: Any)
}

/**
    The root table view cell that goes with JRADatssource. Most of the hard lifting is cinfugred through this. Extend it to make your custom one
 
    - Important: To intialize the cell follow the following step
        - First call renderSetupUI
        - Second call configure
        - Third set eventDelegate
 */
open class JRARootTableViewCell: UITableViewCell, JRARootTableViewCellProtocol {
    public var indexPath: IndexPath = IndexPath()
    public var uid: Any = ""
    
    public var eventDelegate: JRADatasourceCallBackProtocol?
    
    open func renderSetupUI(indexPath: IndexPath) {
        self.indexPath = indexPath
    }
    
    open func configure(with data: Any, uid: Any) {
        self.uid = uid
    }
}
