//
//  ImmersiveView.swift
//  VisionHenry
//
//  Created by Henry B on 11/26/25.
//
import SwiftUI
import RealityKit
import RealityKitContent

struct ImmersiveView: View {
    @Binding var rotateTrigger: Bool
    @Binding var verticalSpinTrigger: Bool
    @State private var cube: ModelEntity?

    var body: some View {
        RealityView { content in
            let anchor = AnchorEntity(world: .zero)
            setupLights(anchor)
            content.add(anchor)

            // --- Cubo ---
            let cube = ModelEntity(
                mesh: .generateBox(size: 0.3),
                materials: [
                    SimpleMaterial(
                        color: .init(red: 0.1, green: 0.6, blue: 1.0, alpha: 1.0),
                        isMetallic: true
                    )
                ]
            )

            // ➜ Posición correcta frente al usuario
            cube.position = SIMD3<Float>(0, 1.0, -1.0)
            self.cube = cube

            // --- Animación de flotación ---
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
            cube.playAnimation(floatAnim)

            // Interacción
            cube.components.set(InputTargetComponent())
            cube.components.set(CollisionComponent(shapes: [.generateBox(size: [0.35, 0.35, 0.35])]))
            cube.components.set(HoverEffectComponent())

            content.add(cube)

            // --- Texto flotante ---
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

            anchor.addChild(textEntity)
        }

        // 🔥 Reaccionar al botón "Rotar Cubo"
        .onChange(of: rotateTrigger) {
            guard let cube else { return }

            if rotateTrigger {
                let rotation = FromToByAnimation<Transform>(
                    name: "rotate",
                    from: Transform(rotation: simd_quatf(angle: 0, axis: [0, 1, 0])),
                    to: Transform(rotation: simd_quatf(angle: 2 * Float.pi, axis: [0, 1, 0])),
                    duration: 8.0,
                    timing: .linear,
                    bindTarget: .transform,
                    repeatMode: .repeat
                )

                let rotationAnim = try! AnimationResource.generate(with: rotation)
                cube.playAnimation(rotationAnim, transitionDuration: 0.3)
            } else {
                cube.stopAllAnimations()
            }
        }
        .onChange(of: verticalSpinTrigger) {
            guard let cube else { return }

                if verticalSpinTrigger {
                    let rotationAnim = try! cube.generateRotationAnimation(
                        angle: 2*Float.pi,
                        axis: SIMD3<Float>(0,1,0),
                        duration: 5.0,
                        repeatMode: .repeat
                    )
                    cube.playAnimation(rotationAnim)
                } else {
                    cube.stopAllAnimations()
                }
        }
    }
}

// --- Luz direccional ---
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

extension ModelEntity {
    func generateRotationAnimation(
        angle: Float,
        axis: SIMD3<Float>,
        duration: TimeInterval,
        repeatMode: AnimationRepeatMode = .repeat
    ) throws -> AnimationResource {
        let rotation = FromToByAnimation<Transform>(
            name: "verticalSpin",
            from: Transform(),
            to: Transform(rotation: simd_quatf(angle: angle, axis: axis)),
            duration: duration,
            timing: .linear,
            bindTarget: .transform,
            repeatMode: repeatMode
        )
        return try AnimationResource.generate(with: rotation)
    }
}

#Preview(immersionStyle: .full) {
    ImmersiveView(rotateTrigger: .constant(false), verticalSpinTrigger: .constant(false))
        .environment(AppModel())
}
