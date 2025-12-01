//
//  AppModelTests.swift
//  VisionHenry
//
//  Created by user945400 on 12/1/25.
//

import XCTest
import ComposableArchitecture
import Dependencies
@testable import VisionHenry

@MainActor
final class AppModelTests: XCTestCase {

    func testImmersiveSpaceStateTransitions() async {
        // Creamos el modelo real
        let appModel = AppModel()
        
        // Lo inyectamos como dependency LIVE (no testValue)
        await withDependencies {
            $0.appModel = appModel
        } operation: {
            // Creamos el TestStore CON la dependency inyectada
            let store = TestStore(
                initialState: ContentViewFeature.State(),
                reducer: { ContentViewFeature() }
            ) {
                // Aquí forzamos que use la dependency que inyectamos arriba
                $0.appModel = appModel
            }
            
            // Verificamos estado inicial
            XCTAssertEqual(appModel.immersiveSpaceState, .closed)
            
            // Abrir
            await store.send(.toggleImmersiveSpace)
            await store.receive(.immersiveSpaceOpened) {
                // Aquí SÍ esperamos que el estado del feature cambie
                $0.isImmersiveSpaceShown = true
            }
            XCTAssertEqual(appModel.immersiveSpaceState, .open)
            
            // Cerrar
            await store.send(.toggleImmersiveSpace)
            await store.receive(.immersiveSpaceDismissed) {
                $0.isImmersiveSpaceShown = false
            }
            XCTAssertEqual(appModel.immersiveSpaceState, .closed)
        }
    }
}
