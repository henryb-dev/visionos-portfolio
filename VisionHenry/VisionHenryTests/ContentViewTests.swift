//
//  ContentViewTests.swift
//  VisionHenry
//
//  Created by Henry Bautista on 11/30/25.
//
import XCTest
import ComposableArchitecture
@testable import VisionHenry

@MainActor
final class ContentViewTests: XCTestCase {

    func testContentViewRendersAndTogglesState() async {
        let store = Store(initialState: ContentViewFeature.State()) {
            ContentViewFeature()
        }

        _ = ContentView(store: store)

        let testStore = TestStore(
            initialState: ContentViewFeature.State(),
            reducer: { ContentViewFeature() }
        )

        XCTAssertFalse(testStore.state.isImmersiveSpaceShown)

        await testStore.send(.toggleImmersiveSpace)
        await testStore.receive(.immersiveSpaceOpened) {
            $0.isImmersiveSpaceShown = true
        }
        XCTAssertTrue(testStore.state.isImmersiveSpaceShown)

        await testStore.send(.toggleImmersiveSpace)
        await testStore.receive(.immersiveSpaceDismissed) {
            $0.isImmersiveSpaceShown = false
        }
        XCTAssertFalse(testStore.state.isImmersiveSpaceShown)
    }
}
