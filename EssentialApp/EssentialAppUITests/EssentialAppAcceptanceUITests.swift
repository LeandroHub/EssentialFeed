//
//  EssentialAppAcceptanceUITests.swift
//  EssentialAppAcceptanceUITests
//
//  Created by Leandro Fournier on 8/7/23.
//

import XCTest

final class EssentialAppAcceptanceUITests: XCTestCase {

    func test_onLaunch_displaysRemoteFeedWhenCustomerHasConnectivity() {
        let app = XCUIApplication()

        app.launch()

        XCTAssertEqual(app.cells.count, 22)
        // The following assertion fails probably due to internet connection issues
        XCTAssertEqual(app.cells.firstMatch.images.count, 1)
    }
}
