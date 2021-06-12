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

    override func setUpWithError() throws {
        view = UIView()
        parent = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
    }

    override func tearDownWithError() throws {
        view = nil
        parent = nil
    }

    func testConstraint_AllSides_Struct() {
        var top: CGFloat = 0
        var bottom: CGFloat = 0
        var left: CGFloat = 0
        var right: CGFloat = 0
        var returnedConstraintStruct: JRAConstraintStruct = JRAConstraintStruct()
        
        given("side constraints value") {
            top = 10
            bottom = 20
            left = 15
            right = 70
        }
        
        when("constraint set to view") {
            parent.addSubview(view)
            returnedConstraintStruct =  view.jraLayoutHookToAllSide(of: parent, top: top, right: right, bottom: bottom, left: left)
        }
        
        then("constraint struct top, right, bottom, left should not be nil") {
            XCTAssertNotNil(returnedConstraintStruct.top)
            XCTAssertNotNil(returnedConstraintStruct.right)
            XCTAssertNotNil(returnedConstraintStruct.bottom)
            XCTAssertNotNil(returnedConstraintStruct.left)
        }
        
        then("match top, bottom, left, right constraint to expected value") {
            XCTAssertEqual(returnedConstraintStruct.top?.constant, top)
            XCTAssertEqual(returnedConstraintStruct.bottom?.constant, -bottom)
            XCTAssertEqual(returnedConstraintStruct.left?.constant, left)
            XCTAssertEqual(returnedConstraintStruct.right?.constant, -right)
        }
        
        then("match isActive for top, right, bottom, left to true") {
            XCTAssertTrue(returnedConstraintStruct.top?.isActive ?? false)
            XCTAssertTrue(returnedConstraintStruct.right?.isActive ?? false)
            XCTAssertTrue(returnedConstraintStruct.bottom?.isActive ?? false)
            XCTAssertTrue(returnedConstraintStruct.left?.isActive ?? false)
        }
    }

}
