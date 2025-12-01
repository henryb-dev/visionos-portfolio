//
//  ImmersiveCubeFeature.swift
//  VisionHenry
//
//  Created by Henry Bautista on 11/30/25.
//

import ComposableArchitecture
import SwiftUI
import RealityKit
import RealityKitContent

@Reducer
public struct ImmersiveCubeFeature {
    // MARK: - State
    public struct State: Equatable {
        public init() {}
    }
    
    // MARK: - Action
    public enum Action {
        case onAppear
        case cubeTapped
    }
    
    // MARK: - Reducer (New Format)
    public var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .none
            case .cubeTapped:
                print("Cube tapped – ready for haptics, analytics, etc.")
                return .none
            }
        }
    }
}

// MARK: - View
public struct ImmersiveCubeView: View {
    private let store = Store(initialState: ImmersiveCubeFeature.State()) {
        ImmersiveCubeFeature()
    }
    
    public init() {}
    
    public var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            RealityView { content in
                let anchor = AnchorEntity(world: .zero)
                setupLights(anchor)
                content.add(anchor)
                let cube = await createInteractiveCube()
                anchor.addChild(cube)
                let text = await createEnterpriseText()
                anchor.addChild(text)
            }
            .gesture(TapGesture().onEnded { viewStore.send(.cubeTapped) })
            .onAppear { viewStore.send(.onAppear) }
        }
    }
}

func setupLights(_ anchor: AnchorEntity) {
    let directionalLight = Entity()
    var light = DirectionalLightComponent()
    light.color = .white
    light.intensity = 30000
    directionalLight.components.set(light)
    directionalLight.orientation = simd_quatf(
        angle: -Float.pi / 4,
        axis: SIMD3(1, 0, 0)
    )
    anchor.addChild(directionalLight)
}

func createInteractiveCube() async -> Entity {
    let cube = ModelEntity(
        mesh: .generateBox(size: 0.3),
        materials: [
            SimpleMaterial(
                color: .init(red: 0.1, green: 0.6, blue: 1.0, alpha: 1.0),
                isMetallic: true
            )
        ]
    )
    cube.position = SIMD3<Float>(0, 1.0, -1.0)
    let floatingCube = await setFloating(cube)
    return floatingCube
}

func setFloating(_ entity: Entity) async -> Entity {
    let float = FromToByAnimation<Transform>(
        name: "float",
        from: Transform(translation: SIMD3<Float>(0, 1.0, -1)),
        to: Transform(translation: SIMD3<Float>(0, 1.2, -1)),
        duration: 3.0,
        timing: .easeInOut,
        bindTarget: .transform,
        repeatMode: .autoReverse
    )
    let floatAnim = try! AnimationResource.generate(with: float)
    entity.playAnimation(floatAnim)
    entity.components.set(InputTargetComponent())
    entity.components.set(CollisionComponent(shapes: [.generateBox(size: [0.35, 0.35, 0.35])]))
    entity.components.set(HoverEffectComponent())
    return entity
}

func setSpining(_ entity: Entity) async -> Entity {
    let rotation = FromToByAnimation<Transform>(
        name: "verticalSpin",
        from: Transform(),
        to: Transform(rotation: simd_quatf(angle: -Float.pi / 4, axis: SIMD3<Float>(0, 1.0, -1))),
        duration: 4,
        timing: .linear,
        bindTarget: .transform,
        repeatMode: AnimationRepeatMode.repeat
    )
    let rotationAnim = try! AnimationResource.generate(with: rotation)
    entity.playAnimation(rotationAnim)
    return entity
}

func createEnterpriseText() async -> Entity {
    let textMesh = MeshResource.generateText(
        "HENRY BAUTISTA\nVisionOS Dev 2025",
        extrusionDepth: 0.02,
        font: .systemFont(ofSize: 0.08)
    )
    let textEntity = ModelEntity(
        mesh: textMesh,
        materials: [SimpleMaterial(color: .white, isMetallic: false)]
    )
    textEntity.position = SIMD3<Float>(0.3, 1.2, -1)
    textEntity.scale = SIMD3<Float>(0.4, 0.4, 0.4)
    return textEntity
}

#Preview(immersionStyle: .full) {
    ImmersiveCubeView()
        .environment(AppModel())
}
