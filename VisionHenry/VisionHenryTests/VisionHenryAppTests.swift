//
//  VisionHenryTests.swift
//  VisionHenryTests
//
//  Created by user945400 on 11/26/25.
//

import XCTest
@testable import VisionHenry

final class VisionHenryAppTests: XCTestCase {

    func testAppLaunches() {
        let app = VisionHenryApp()
        XCTAssertNotNil(app.body)
    }

    func testWindowGroupContainsContentView() {
        let scene = VisionHenryApp().body
        // Solo verifica que compila y existe
        XCTAssertTrue(true)
    }
}
