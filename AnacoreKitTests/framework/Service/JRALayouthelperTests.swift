//
//  JRALayouthelperTests.swift
//  AnacoreKitTests
//
//  Created by Shubroto Shuvo on 6/7/21.
//

import XCTest

@testable import AnacoreKit

class JRALayouthelperTests: XCTestCase, GWTExpression {
    
    var view: UIView!
    var parent: UIView!
    var recievedConstraintStruct: JRAConstraintStruct!

    override func setUpWithError() throws {
        view = UIView()
        parent = UIView()
        recievedConstraintStruct = JRAConstraintStruct()
        view.translatesAutoresizingMaskIntoConstraints = false
    }

    override func tearDownWithError() throws {
        view = nil
        parent = nil
        recievedConstraintStruct = nil
    }

    func testConstraint_HookToAllSides_AllSet() {
        var top: CGFloat = 0
        var bottom: CGFloat = 0
        var left: CGFloat = 0
        var right: CGFloat = 0
        
        given("side constraints value") {
            top = 10
            bottom = 20
            left = 15
            right = 70
        }
        
        when("constraint set to view") {
            parent.addSubview(view)
            recievedConstraintStruct =  view.jraLayoutHookToAllSide(of: parent, top: top, right: right, bottom: bottom, left: left)
        }
        
        then("constraint struct top, right, bottom, left should not be nil") {
            XCTAssertNotNil(recievedConstraintStruct.top)
            XCTAssertNotNil(recievedConstraintStruct.right)
            XCTAssertNotNil(recievedConstraintStruct.bottom)
            XCTAssertNotNil(recievedConstraintStruct.left)
        }
        
        then("match top, bottom, left, right constraint to expected value") {
            XCTAssertEqual(recievedConstraintStruct.top?.constant, top)
            XCTAssertEqual(recievedConstraintStruct.bottom?.constant, -bottom)
            XCTAssertEqual(recievedConstraintStruct.left?.constant, left)
            XCTAssertEqual(recievedConstraintStruct.right?.constant, -right)
        }
        
        then("match isActive for top, right, bottom, left to true") {
            XCTAssertTrue(recievedConstraintStruct.top?.isActive ?? false)
            XCTAssertTrue(recievedConstraintStruct.right?.isActive ?? false)
            XCTAssertTrue(recievedConstraintStruct.bottom?.isActive ?? false)
            XCTAssertTrue(recievedConstraintStruct.left?.isActive ?? false)
        }
        
        given("top, right, bottom, left constraint to different value") {
            top = 40
            bottom = 42
            left = 43
            right = 44
        }
        
        when("Set spacing directly from JRAConstraintStruct") {
            recievedConstraintStruct.setSpacing(top: top, right: right, bottom: bottom, left: left)
        }
        
        then("match top, bottom, left, right constraint to expected value") {
             XCTAssertEqual(recievedConstraintStruct.top?.constant, top)
             XCTAssertEqual(recievedConstraintStruct.bottom?.constant, -bottom)
             XCTAssertEqual(recievedConstraintStruct.left?.constant, left)
             XCTAssertEqual(recievedConstraintStruct.right?.constant, -right)
        }
    }
    
    func testConstraint_SetWidthHeight_AllSet() {
        var width: CGFloat = 0
        var height: CGFloat = 0
        
        given("width and height value") {
            width = 10
            height = 15
        }
        
        when("width and height constraint set to view") {
            recievedConstraintStruct = view.jraLayoutSet(width: width, height: height)
        }
        
        then("match the width and height value with the expected") {
            XCTAssertEqual(recievedConstraintStruct.width?.constant, width)
            XCTAssertEqual(recievedConstraintStruct.height?.constant, height)
        }
        
        then("check width and height constraint is active") {
            XCTAssertTrue(recievedConstraintStruct.width?.isActive ?? false)
            XCTAssertTrue(recievedConstraintStruct.height?.isActive ?? false)
        }
    }
    
    func testConstraint_SetCenterXY_AllSet() {
        var centerX: CGFloat = 0
        var centerY: CGFloat = 0
        
        given("Center x and Center y value") {
            centerX = 10
            centerY = 15
        }
        
        when("Center x and y value is set to view related to parent view") {
            parent.addSubview(view)
            recievedConstraintStruct = view.jraLayoutCenter(to: parent, x: centerX, y: centerY)
        }
        
        then("match the center x and y with the expected") {
            XCTAssertEqual(recievedConstraintStruct.centerX?.constant, centerX)
            XCTAssertEqual(recievedConstraintStruct.centerY?.constant, centerY)
        }
        
        then("check center x and y constraint is active") {
            XCTAssertTrue(recievedConstraintStruct.centerX?.isActive ?? false)
            XCTAssertTrue(recievedConstraintStruct.centerY?.isActive ?? false)
        }
    }
    
    func testConstraint_AddWrapperToView_AllSet() {
        var top: CGFloat = 0
        var bottom: CGFloat = 0
        var left: CGFloat = 0
        var right: CGFloat = 0
        
        var centerX: CGFloat = 0
        var centerY: CGFloat = 0
        
        var width: CGFloat = 0
        var height: CGFloat = 0
        
        var receivedWrapper: UIView = UIView()
        
        given("all constraints value") {
            top = 10
            bottom = 20
            left = 15
            right = 70
            
            centerX = 10
            centerY = 15
            
            width = 10
            height = 15
        }
        
        when("wrapper view is created with all value added") {
            (receivedWrapper, recievedConstraintStruct) = view.jraLayoutAddWrapper(top: top, right: right, bottom: bottom, left: left, x: centerX, y: centerY, width: width, height: height)
        }
        
        then("view must be inside the wrapper") {
            XCTAssertTrue(receivedWrapper.subviews.contains(view))
        }
        
        then("match top, bottom, left, right, width, height, center x and y constraint to expected value") {
            XCTAssertEqual(recievedConstraintStruct.top?.constant, top)
            XCTAssertEqual(recievedConstraintStruct.bottom?.constant, -bottom)
            XCTAssertEqual(recievedConstraintStruct.left?.constant, left)
            XCTAssertEqual(recievedConstraintStruct.right?.constant, -right)
            
            XCTAssertEqual(recievedConstraintStruct.centerX?.constant, centerX)
            XCTAssertEqual(recievedConstraintStruct.centerY?.constant, centerY)
            
            XCTAssertEqual(recievedConstraintStruct.width?.constant, width)
            XCTAssertEqual(recievedConstraintStruct.height?.constant, height)
        }
        
        then("check top, bottom, left, right, width, height, center x and y constraint is active") {
            XCTAssertTrue(recievedConstraintStruct.top?.isActive ?? false)
            XCTAssertTrue(recievedConstraintStruct.right?.isActive ?? false)
            XCTAssertTrue(recievedConstraintStruct.bottom?.isActive ?? false)
            XCTAssertTrue(recievedConstraintStruct.left?.isActive ?? false)
            
            XCTAssertTrue(recievedConstraintStruct.centerX?.isActive ?? false)
            XCTAssertTrue(recievedConstraintStruct.centerY?.isActive ?? false)
            
            XCTAssertTrue(recievedConstraintStruct.width?.isActive ?? false)
            XCTAssertTrue(recievedConstraintStruct.height?.isActive ?? false)
        }
    }

}
