//
//  CakeListUITests.swift
//  CakeListUITests
//
//  Created by mahesh lad on 11/09/2026.
//

import XCTest
@testable import CakeList

final class CakeListUITests: XCTestCase {

    let app = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }

    func test_cakeDetailSheet_opensAndDismisses() throws {
        // 1. Wait for the list to load and verify the first item exists
        let firstCakeRow = app.buttons.matching(identifier: "cakeRow").firstMatch
        
        // Alternative if you identify rows by title/text:
        // let firstCakeRow = app.buttons.staticTexts["Lemon Drizzle"].firstMatch
        
        XCTAssertTrue(firstCakeRow.waitForExistence(timeout: 5.0), "Cake list failed to load within timeout.")
        
        // 2. Tap row to present sheet
        firstCakeRow.tap()

        // 3. Verify sheet content appears
        let closeButton = app.buttons["cakePopupCloseButton"]
        XCTAssertTrue(closeButton.waitForExistence(timeout: 2.0), "Sheet did not present upon tapping cake row.")

        // 4. Tap 'Close' button to dismiss sheet
        closeButton.tap()

        // 5. Verify sheet is dismissed
        let sheetDismissed = NSPredicate(format: "exists == false")
        expectation(for: sheetDismissed, evaluatedWith: closeButton, handler: nil)
        waitForExpectations(timeout: 2.0, handler: nil)
    }
}
