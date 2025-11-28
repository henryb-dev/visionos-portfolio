# VisionOS Full Immersive Space Demo  
**Apple Vision Pro · RealityKit + SwiftUI · visionOS 2 · Xcode 26 · 2025**

### Floating metallic cube with:
- Gentle up/down floating animation
- Fully interactive – grab, hover effect, collision
- 3D extruded text with custom branding
- Professional directional lighting

| Feature                           | Implementation                                  | What it proves                                           |
|-----------------------------------|-------------------------------------------------|----------------------------------------------------------|
| Interactive metallic blue cube    | `ModelEntity(mesh: .generateBox, material: SimpleMaterial(color: ..., isMetallic: true))` | PBR materials, custom appearance                         |
| Infinite Y-axis rotation          | `FromToByAnimation` (linear, 8s, repeat)        | Modern RealityKit 2 animation API (no deprecated .combine) |
| Up/down floating animation        | `FromToByAnimation` (easeInOut, 3s, reverse)    | Smooth ping-pong motion                                  |
| Grab + Hover + Collision          | `InputTargetComponent`, `CollisionComponent`, `HoverEffectComponent` | Full hand interaction in spatial computing               |
| 3D extruded branding text         | `ModelEntity(mesh: .generateText("HENRY BAUTISTA\nVisionOS Dev 2025", extrusionDepth: 0.02))` | Real-world branding in 3D space                          |
| Professional lighting             | `DirectionalLightComponent(intensity: 30000)` + manual orientation | Realistic shadows and depth                              |
| Full Immersive Space              | `@main App → ImmersiveSpace(id: "ImmersiveSpace")` | Complete spatial takeover (no mixed mode)                |

Ready to run on Apple Vision Pro simulator  
(Xcode 26.1.1 or newer)
<div align="center">
Watch Live Demo → ![VisionOS - HenryB](https://github.com/user-attachments/assets/68bd682a-c671-4960-9a50-dbf9a2364ad9)
</div>

### Production-ready highlights
- Zero third-party dependencies
- Built with Xcode 26.1.1 + visionOS 2 SDK
- Tested daily on Apple Vision Pro simulator
- Clean, commented, senior-level code
- Ready for App Store (just change bundle ID)

### Run it yourself
```bash
git clone https://github.com/henryb-dev/visionos-portfolio.git
cd visionos-portfolio
open VisionHenry.xcodeproj
```

**Henry Bautista**  
Senior VisionOS / Spatial Computing Developer  
Available for remote contracts · $45–50 USD/hour  (for the right clients)
Open to fintech, AR dashboards, 3D data visualization projects
hentryx@gmail.com · [LinkedIn](https://www.linkedin.com/in/henry-b-8941012a) · DM ready






