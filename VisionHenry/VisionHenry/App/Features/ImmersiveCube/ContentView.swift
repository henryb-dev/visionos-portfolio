//
//  ContentView.swift
//  VisionHenry
//
//  Created by Henry Bautista on 11/26/25.
//

import SwiftUI
import RealityKit
import RealityKitContent
import ComposableArchitecture

struct ContentView: View {
    let store:StoreOf<ContentViewFeature>
    @Environment(\.openImmersiveSpace) private var openImmersiveSpace
        @Environment(\.dismissImmersiveSpace) private var dismissImmersiveSpace
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            VStack(spacing: 30) {
                Text("My VisionOS + RealityKit App")
                    .font(.largeTitle).bold()
                    .foregroundStyle(.white)
                Text("Production-ready demo – The Composer Architecture (TCA) - 2025")
                    .font(.title2)
                    .foregroundStyle(.white.opacity(0.8))
                Button {
                    viewStore.send(.toggleImmersiveSpace)
                } label: {
                    Text(viewStore.isImmersiveSpaceShown ? "Hide Cube" : "Show Cube")
                        .font(.title2).bold()
                }
                .buttonStyle(.borderedProminent)
                .padding(.horizontal)        }
            .task(id: viewStore.isImmersiveSpaceShown) {
                if viewStore.isImmersiveSpaceShown {
                    await openImmersiveSpace(id: "MyImmersiveSpace")
                } else {
                    await dismissImmersiveSpace()
                }
            }.onAppear {
                viewStore.send(.viewAppeared)
            }
        }
    }

}

#Preview {
    ContentView(
        store: Store(initialState: ContentViewFeature.State()) {
            ContentViewFeature()
        }
    )
}
