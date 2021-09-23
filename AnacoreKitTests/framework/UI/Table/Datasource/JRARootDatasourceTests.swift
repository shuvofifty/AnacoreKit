//
//  JRARootDatasourceTest.swift
//  AnacoreKitTests
//
//  Created by Shubroto Shuvo on 7/28/21.
//

import XCTest

@testable import AnacoreKit

class JRARootDatasourceTest: XCTestCase {
    var fakeJRARootVCTableTarget: FakeJRARootVCTableTarget!
    var tableView: JRATable!
    var subject: JRARootDatasource<String>!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        fakeJRARootVCTableTarget = FakeJRARootVCTableTarget()
        tableView = JRATable()
        subject = JRARootDatasource<String>(target: fakeJRARootVCTableTarget, tableView: tableView)
        setDataForTesting()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        subject = nil
        tableView = nil
        fakeJRARootVCTableTarget = nil
    }
    
    func testSetDatas() {
        // GIVEN: datas
        let datas = ["Test1", "Test2", "Test3", "Test4"]
        
        // WHEN: datas are set to datasource
        subject.setDatas(datas)
        
        // THEN: should get all the same data as datasource data
        XCTAssertEqual(datas.count, subject.datas.count)
    }
    
    func testSetDataForSpecificRow() {
        // GIVEN: data for adding
        let data = "Test String"
        let index = 2
        
        // WHEN: data is set in datasource
        subject.set(data: data, at: index, triggerReload: false)
        
        // THEN: should get the same data as datasource data at index 2
        XCTAssertEqual(data, subject.datas[index])
    }
    
    func testSetDataForAddingExtraRowAtEnd() {
        // GIVEN: data for adding
        let data = "Test String"
        let index = 4
        
        // WHEN: data is set in datasource
        subject.set(data: data, at: index, triggerReload: false)
        
        // THEN: should get the same data as datasource data that got added in back
        XCTAssertEqual(data, subject.datas[index])
    }
    
    func testSetDataForAddingExtraRowAtBegining() {
        // GIVEN: data for adding
        let data = "Test String"
        let index = 0
        
        // WHEN: data is set in datasource
        subject.set(data: data, at: -1, triggerReload: false)
        
        // THEN: should get the same data as datasource data that got added in front
        XCTAssertEqual(data, subject.datas[index])
    }
    
    private func setDataForTesting() {
        subject.setDatas(["Test1", "Test2", "Test3", "Test4"])
    }
}

class FakeJRARootVCTableTarget: JRARootVCTableProtocol {
    
}


