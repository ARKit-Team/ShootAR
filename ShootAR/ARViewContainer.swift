//
//  ARViewContainer.swift
//  ShootAR
//
//  Created by Ziady Mubaraq on 22/06/23.
//

import SwiftUI
import ARKit
import RealityKit

struct ARViewContainer: UIViewRepresentable {
  typealias UIViewType = ARView
  
  func makeUIView(context: Context) -> ARView {
    let arView = ARView(frame: .zero, cameraMode: .ar, automaticallyConfigureSession: true)
    
    return arView
  }
  
  func updateUIView(_ uiView: ARView, context: Context) {
    
  }
}
