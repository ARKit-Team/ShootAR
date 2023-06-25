//
//  ViewController.swift
//  Laser-laseran
//
//  Created by Muhammad Abdul Ghani on 24/05/23.
//

import UIKit
import SwiftUI
import RealityKit
import ARKit


//this
class ViewController: UIViewController{
    @IBOutlet var arView: ARView!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setupARView()
        
        arView.session.delegate = self
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(recognizer:)))
        arView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func setupARView(){
        arView.automaticallyConfigureSession = false
        
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal, .vertical]
        config.environmentTexturing = .automatic
        config.isCollaborationEnabled = true
        
        arView.session.run(config)
        
        
    }
    
    @objc func handleTap(recognizer: UITapGestureRecognizer){
        let anchor = ARAnchor(name: "lasergreen", transform: arView!.cameraTransform.matrix)
        arView.session.add(anchor: anchor)
    }
    
    func placeObject(named entityName: String, for anchor: ARAnchor){
        let laserEntity = try! ModelEntity.load(named: entityName)
        let anchorEntity = AnchorEntity(anchor: anchor)
        anchorEntity.addChild(laserEntity)
        arView.scene.addAnchor(anchorEntity)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25){
            self.arView.scene.removeAnchor(anchorEntity)
        }
    }
    
}
//to this


extension ViewController: ARSessionDelegate{
    func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
        for anchor in anchors {
            if let anchorName = anchor.name, anchorName == "lasergreen"{
                placeObject(named: anchorName, for: anchor)
            }
            
            if let participantAnchor = anchor as? ARParticipantAnchor{
                print("Successfully connected with another player!")
                
                let anchorEntity = AnchorEntity(anchor: participantAnchor)
                let mesh = MeshResource.generateSphere(radius: 0.03)
                let color = UIColor.green
                let material = SimpleMaterial(color: color, isMetallic: false)
                let coloredSphere = ModelEntity(mesh: mesh, materials: [material])
                
                anchorEntity.addChild(coloredSphere)
                arView.scene.addAnchor(anchorEntity)
            }
        }
    }
}

//struct ViewControllerWrapper: UIViewControllerRepresentable {
//    func makeUIViewController(context: Context) -> ViewController {
//        let viewController = ViewController()
//        return viewController
//    }
//
//    func updateUIViewController(_ uiViewController: ViewController, context: Context) {
//
//    }
//}
