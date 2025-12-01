//
//  ContentViewFeatureTests.swift
//  VisionHenry
//
//  Created by Henry Bautista on 11/30/25.
//

import XCTest
import ComposableArchitecture
@testable import VisionHenry

@MainActor
final class ContentViewFeatureTests: XCTestCase {

    func testFullToggleFlow() async {
        let store = TestStore(
            initialState: ContentViewFeature.State(),
            reducer: { ContentViewFeature() }
        )

        await store.send(.toggleImmersiveSpace)
        await store.receive(.immersiveSpaceOpened) {
            $0.isImmersiveSpaceShown = true
        }

        await store.send(.toggleImmersiveSpace)
        await store.receive(.immersiveSpaceDismissed) {
            $0.isImmersiveSpaceShown = false
        }
    }
}
