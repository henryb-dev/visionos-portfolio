//
//  AppModel.swift
//  VisionHenry
//
//  Created by Henry Bautista on 11/26/25.
//

import SwiftUI
import Dependencies

/// Maintains app-wide state
@MainActor
@Observable
class AppModel {
    let immersiveSpaceID = "MyImmersiveSpace"
    enum ImmersiveSpaceState {
        case closed
        case inTransition
        case open
    }
    var immersiveSpaceState = ImmersiveSpaceState.closed
}


extension DependencyValues {
    var appModel: AppModel {
        get { self[AppModelKey.self] }
        set { self[AppModelKey.self] = newValue }
    }
}

private struct AppModelKey: DependencyKey {
    static let liveValue = AppModel()
    static let testValue = AppModel()   // ← para tests
}
