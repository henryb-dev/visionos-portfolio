//
//  VisionHenryApp.swift
//  VisionHenry
//
//  Created by Henry Bautista on 11/26/25.
//

import SwiftUI
import ComposableArchitecture

@main
struct VisionHenryApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(
                store: Store(initialState: ContentViewFeature.State()) {
                    ContentViewFeature()
                }
            )
        }
        
        ImmersiveSpace(id: "MyImmersiveSpace") {
            ImmersiveCubeView()
        }
        .immersionStyle(selection: .constant(.mixed), in: .mixed)
    }
}
