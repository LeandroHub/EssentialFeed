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

        let feedCells = app.cells.matching(identifier: "feed-image-cell")
        XCTAssertEqual(feedCells.count, 22)

        let firstImage = app.images.matching(identifier: "feed-image-view").firstMatch
        XCTAssertTrue(firstImage.exists)
    }

    func test_onLaunch_displaysCachedRemoteFeedWhenCustomerHasNoConnectivity() {
        let onlineApp = XCUIApplication()
        onlineApp.launch()

        let offlineApp = XCUIApplication()
        offlineApp.launchArguments = ["-connectivity", "offline"]
        offlineApp.launch()

        let feedCells = offlineApp.cells.matching(identifier: "feed-image-cell")
        XCTAssertEqual(feedCells.count, 22)

        let firstImage = offlineApp.images.matching(identifier: "feed-image-view").firstMatch
        XCTAssertTrue(firstImage.exists)
    }

    func test_onLaunch_displaysEmptyFeedWhenCustomerHasNoConnectivityAndNoCache() {
        let app = XCUIApplication()
        app.launchArguments = ["-reset", "-connectivity", "offline"]
        app.launch()

        let feedCells = app.cells.matching(identifier: "feed-image-cell")
        XCTAssertEqual(feedCells.count, 0)
    }
}
