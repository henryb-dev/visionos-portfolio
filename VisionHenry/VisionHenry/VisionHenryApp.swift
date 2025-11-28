//
//  VisionHenryApp.swift
//  VisionHenry
//
//  Created by user945400 on 11/26/25.
//

import SwiftUI

@main
struct VisionHenryApp: App {

    @State private var appModel = AppModel()
    
    @State private var rotateTrigger = false   // Control del cubo
    @State private var verticalSpin = false
    
    var body: some Scene {
        
        WindowGroup {
            ContentView(rotateTrigger: $rotateTrigger, verticalSpin: $verticalSpin)
        }
        
        ImmersiveSpace(id: "MyImmersive") {
            ImmersiveView(rotateTrigger: $rotateTrigger, verticalSpinTrigger: $verticalSpin)
        }
    }
    
}

