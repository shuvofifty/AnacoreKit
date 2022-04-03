//
//  JRARootDatasource.swift
//  AnacoreKit
//
//  Created by Shubroto Shuvo on 7/27/21.
//

import Foundation
import UIKit

/**
 Root datasource class that can be used to show and display data on tableview. All configuration are set. Ovveride this to setup your own configs
 
 - **Uses**: Use **JRARootVCTableProtocol** to communicate back to the component using it
 */
open class JRARootDatasource: NSObject, UITableViewDelegate, UITableViewDataSource, JRADatasourceCallBackProtocol {
    
    public static let CELL_ID = "JRARootDatasource_Cell_ID"
    
    private(set) var datas: [Any] = []
    
    private let target: JRARootVCTableProtocol
    private let tableView: JRATable
    private let singleCellIdentifier: String
    
    required public init(target: JRARootVCTableProtocol,
         tableView: JRATable,
         singleCellIdentifier: String = JRARootDatasource.CELL_ID) {
        self.target = target
        self.tableView = tableView
        self.singleCellIdentifier = singleCellIdentifier
    }
    
    /**
     Override this to do custom setup or by default it will just coonect the assigned tableView datasource and delegate to this class
     */
    open func setup() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    /**
     Set data at the specific index of datas and will update that specific row
     
     - Important:
        - This will reload the table view at the specific row.
        - If the index is out of range then the data will be appended or -1 will prepend it to list. This will trigger whole table update
     
     - Parameters:
        - data: The data you want to set
        - index: The index value of the data you want to replace. If negative then will be placed at first of the data array
        - triggerReload: Trigger reload table otherwise not
        - animation: The animation to reload the row with
     */
    open func set(data: Any,
                  at index: Int,
                  triggerReload: Bool = true,
                  with animation: UITableView.RowAnimation = .none) {
        guard index >= 0 else {
            datas.insert(data, at: 0)
            if triggerReload { reloadTable() }
            return
        }
        guard (datas.count - 1) >= index else {
            datas.append(data)
            if triggerReload { reloadTable() }
            return
        }
        
        datas[index] = data
        if triggerReload { reloadTable(at: [IndexPath(row: index, section: 0)], with: animation) }
    }
    
    /**
     Replace current datas with new data completly
     
     - Parameters:
        - datas: List of all the data to be set
        - triggerReload: Trigger reload whole table. Set false if not needed
     */
    open func setDatas(_ datas: [Any],
                       triggerReload: Bool = true
    ) {
        self.datas = datas
        if triggerReload { reloadTable() }
    }
    
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        datas.count
    }
    
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: getTableCellIdentifier(from: indexPath), for: indexPath) as! JRARootTableViewCell
        cell.renderSetupUI(indexPath: indexPath)
        cell.eventDelegate = self
        return configTableCell(with: indexPath, cell: cell)
    }
    
    open func configTableCell(with indexPath: IndexPath, cell: JRARootTableViewCell) -> JRARootTableViewCell {
        cell.configure(with: datas[indexPath.row], uid: datas[indexPath.row])
        return cell
    }
    
    open func sendTargetEvent(with type: Any, value: Any, indexPath: IndexPath, uid: Any) {
        // TODO:- Send targeted event back to VC or upto you
    }
    
    open func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        9000
    }
    
    open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    open func getTableCellIdentifier(from indexPath: IndexPath) -> String {
        singleCellIdentifier
    }
    
    /**
     Reload particular rows of table view. If set nil then it will reload the whole table
     
     - Parameters:
        - indexPaths: The index path to reload the rows at. If set nil then whole table view get reloaded
        - animation: Animation to reload the rows with
     */
    func reloadTable(at indexPaths: [IndexPath]? = nil, with animation: UITableView.RowAnimation = .none) {
        guard let indexPaths = indexPaths else {
            tableView.reloadData()
            return
        }
        tableView.reloadRows(at: indexPaths, with: animation)
    }
}
