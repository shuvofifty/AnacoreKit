//
//  TableViewController.swift
//  AnacoreKitDemo
//
//  Created by Shubroto Shuvo on 10/15/21.
//

import AnacoreKit
import Foundation

class TableViewController: JRARootVC {
    private lazy var jraTable: JRATable = {
        JRATable()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = JRASharedConfigContainer.shared.baseColorConfig.background
        
        view.addSubview(jraTable)
        let _ = jraTable.jraLayoutHookToAllSide(of: view, useSafeAreaLayoutGuide: true)
    }
}