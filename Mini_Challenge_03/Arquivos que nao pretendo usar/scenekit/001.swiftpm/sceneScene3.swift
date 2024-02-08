import SwiftUI
import SceneKit

struct SceneScene3: UIViewRepresentable {
    
//    @Binding var scene: SCNScene?
    let scene: SCNScene = SCNScene()
  
   

    func makeUIView(context: Context) -> SCNView {
        let sceneView = SCNView()
        sceneView.scene = scene
       
        sceneView.autoenablesDefaultLighting = true
        sceneView.allowsCameraControl = true
        sceneView.defaultCameraController.interactionMode = .orbitTurntable
        sceneView.defaultCameraController.inertiaEnabled = true

        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 5)
        scene.rootNode.addChildNode(cameraNode)
        
        let modelNode = scene.rootNode.childNode(withName: "nave", recursively: true)
        modelNode?.position = SCNVector3(x: 0, y: 0, z: 0)  // Ajuste conforme necessário
        modelNode?.scale = SCNVector3(x: 0.1, y: 0.1, z: 0.1)  // Ajuste conforme necessário


        return sceneView
    }


    func updateUIView(_ uiView: SCNView, context: Context) {
        let rotationAction = SCNAction.rotateBy(x: 0, y: CGFloat(2 * Double.pi), z: 0, duration: 5.0)
        _ = SCNAction.repeatForever(rotationAction)
 
        
        
    }

    



    typealias UIViewType = SCNView
}

