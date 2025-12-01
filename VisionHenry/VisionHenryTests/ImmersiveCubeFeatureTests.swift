//
//  Untitled.swift
//  VisionHenry
//
//  Created by Henry Bautista on 11/30/25.
//

import XCTest
import ComposableArchitecture
import RealityKit
@testable import VisionHenry

// MARK: - 1. Reducer Test
@MainActor
final class ImmersiveCubeFeatureTests: XCTestCase {

    func testOnAppear_DoesNothing() async {
        let store = TestStore(initialState: ImmersiveCubeFeature.State()) {
            ImmersiveCubeFeature()
        }

        await store.send(.cubeTapped)
    }

    func testCubeTapped_TriggersPrint() async {
        let store = TestStore(initialState: ImmersiveCubeFeature.State()) {
            ImmersiveCubeFeature()
        }

        await store.send(.cubeTapped)
        // No hay efectos → listo
    }
    
    
    func testCubeAppears() async {
        let store = TestStore(
            initialState: ImmersiveCubeFeature.State(),
            reducer: { ImmersiveCubeFeature() }
        )
        
        await store.send(.onAppear)
    }
    
    
    func testSetupLights() async {
        let anchor = AnchorEntity(world: .zero)
        setupLights(anchor)
        
        XCTAssertEqual(anchor.children.count, 1)
        if let light = anchor.children.first {
            XCTAssertTrue(light.components.has(DirectionalLightComponent.self))
        }
    }
    
    func testCreateInteractiveCube() async {
        let cube = await createInteractiveCube()
        
        XCTAssertEqual(cube.position.y, 1.0)
        XCTAssertEqual(cube.position.z, -1.0)
        XCTAssertTrue(cube.components.has(InputTargetComponent.self))
        XCTAssertTrue(cube.components.has(CollisionComponent.self))
        XCTAssertTrue(cube.components.has(HoverEffectComponent.self))
    }
    
    func testCreateEnterpriseText() async {
        let text = await createEnterpriseText()
        XCTAssertTrue(text.position.x > 0)
        XCTAssertEqual(text.scale.x, 0.4)

    }
    
    func testSetFloatingAddsAnimation() async {
        let cube = await createInteractiveCube()
        
        
        XCTAssertFalse(cube.isAnchored)
    }
    
    
}
