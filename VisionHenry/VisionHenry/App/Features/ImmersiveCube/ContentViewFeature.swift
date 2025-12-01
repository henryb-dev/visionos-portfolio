//
//  ContentViewFeature.swift
//  VisionHenry
//
//  Created by Henry Bautista on 11/30/25.
//

import SwiftUI
import ComposableArchitecture

@Reducer
struct ContentViewFeature {
    struct State: Equatable {
        var isImmersiveSpaceShown = false
    }
    
    enum Action {
        case toggleImmersiveSpace
        case immersiveSpaceOpened
        case immersiveSpaceDismissed
        case viewAppeared
    }
    @Dependency(\.appModel) var appModel
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .toggleImmersiveSpace:
                let shouldOpen = !state.isImmersiveSpaceShown
                return .run { send in
                    if shouldOpen {
                        await send(.immersiveSpaceOpened)
                    } else {
                        await send(.immersiveSpaceDismissed)
                    }
                }
                
            case .immersiveSpaceOpened:
                state.isImmersiveSpaceShown = true
                appModel.immersiveSpaceState = .open
                return .none
                
            case .immersiveSpaceDismissed:
                state.isImmersiveSpaceShown = false
                appModel.immersiveSpaceState = .closed
                return .none
            case .viewAppeared:
                return .none
            }
        }
    }
}
