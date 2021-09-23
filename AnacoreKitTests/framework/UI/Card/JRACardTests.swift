//
//  JRACardTests.swift
//  AnacoreKitTests
//
//  Created by Shubroto Shuvo on 6/12/21.
//

import XCTest

@testable import AnacoreKit

class JRACardTests: XCTestCase, GWTExpression {
    
    var subject: JRACard!

    override func setUpWithError() throws {
        subject = JRACard()
    }

    override func tearDownWithError() throws {
        subject = nil
    }

    func testIntialization() {
        XCTAssertEqual(subject.subviews.count, 1)
        XCTAssertTrue(subject.subviews.first is JRAStackView)
    }
    
    func testCard_ChangeBackgroundColor() {
        let backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        
        when("Background color is set for subject") {
            let _ = subject.setBackground(color: backgroundColor)
        }
        
        then("background color for the subject matches") {
            XCTAssertEqual(subject.backgroundColor, backgroundColor)
        }
    }
    
    func testCard_RowSpacing() {
        var spacing: CGFloat = 0
        
        given("Card Spacing") {
            spacing = 30
        }
        
        when("set card row spacing to spacing") {
            let _ = subject.setRowSpacing(to: spacing)
        }
        
        then("card row spacing should match the custom spacing set") {
            XCTAssertEqual(subject.stack.spacing, spacing)
        }
    }
}
