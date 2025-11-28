//
//  ContentView.swift
//  VisionHenry
//
//  Created by user945400 on 11/26/25.
//

import SwiftUI
import RealityKit

struct ContentView: View {

    @Environment(\.openImmersiveSpace) private var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) private var dismissImmersiveSpace

    @Binding var rotateTrigger: Bool
    @Binding var verticalSpin: Bool

    @State private var immersiveShown = false

    var body: some View {
        VStack(spacing: 30) {
            Text("Mi App visionOS")
                .font(.largeTitle)
                .bold()
            Button("Mostrar Cubo") {
                Task {
                    if !immersiveShown {
                        await openImmersiveSpace(id: "MyImmersive")
                        immersiveShown = true
                    }
                }
            }
            .buttonStyle(.borderedProminent)
            .padding(.horizontal)

/*            // Rotar cubo
            Button("Rotar Cubo") {
                rotateTrigger.toggle()    // Activa animación en ImmersiveView
            }
            .buttonStyle(.borderedProminent)
            
            Button("Giro Vertical") {      // Nuevo botón
                verticalSpin.toggle()
            }
            .buttonStyle(.borderedProminent)*/
            
            // Salir
            Button("Ocultar Cubo") {
                Task {
                    await dismissImmersiveSpace()
                    immersiveShown = false
                }
            }
            .buttonStyle(.bordered)
        }
        .padding()
    }
}


#Preview(windowStyle: .automatic) {
    ContentView(rotateTrigger: .constant(false), verticalSpin: .constant(false))
        .environment(AppModel())
}
