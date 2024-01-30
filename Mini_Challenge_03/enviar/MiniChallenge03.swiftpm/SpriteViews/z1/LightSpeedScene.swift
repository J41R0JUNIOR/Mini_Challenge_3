import SpriteKit
import SwiftUI

class LightSpeedScene: SKScene {
    let cameraNode = SKCameraNode()
    var show2 : Bool = false
    var i: Int = 0
    
  
    var physics: SKSpriteNode = {
        let object = SKSpriteNode(imageNamed: ObjectsEnum.scientist.rawValue)
//        object.size = CGSize(width: 100, height: 100)
        return object
    }()
    
    override func didMove(to view: SKView) {
        add()
    }
    
    func add(){
        //add and setting camera to the scene
        self.backgroundColor = .clear
        self.addChild(cameraNode)
        cameraNode.position = CGPoint(x: 0, y: 0)
        cameraNode.setScale(1.0)
        self.camera = cameraNode
        
        //add Physic to the scene
        self.addChild(physics)
    }
    
    func characterSetting(){
        if show2{
            let frame = (CGFloat(self.view?.bounds.size.width ?? 700)/2) * 0.5
            physics.size = CGSize(width: frame, height: frame)
            
            if let view = self.view{
                physics.position = CGPoint(x: (view.frame.width / 2) * 0.5 , y: 0)
            }
            physics.isHidden = false
            addSecondScene()
        }else{
            physics.isHidden = true
        }
    }
    
    func addSecondScene() {
           // Create a new scene (you can replace this with your own scene class)
//        let secondScene = ChatScene(witchObject: <#T##Binding<String>#>, canClearChat: <#T##Binding<Bool>#>)
           

           // Add the second scene as a child of the main scene
//           self.addChild(secondScene)
       }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        show2.toggle()
    }

    override func update(_ currentTime: TimeInterval) {
       characterSetting()
    
    }
}



struct LightsSpeedSceneView: UIViewRepresentable {
   
    func makeUIView(context: Context) -> SKView {
        let skView = SKView()
        skView.isMultipleTouchEnabled = true
        skView.backgroundColor = .clear
        let sceneSize = CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        let gameScene = LightSpeedScene()
        gameScene.size = sceneSize
        skView.presentScene(gameScene)

        // Save the reference to the scene
//        context.coordinator.scene = gameScene
        return skView
    }

    func updateUIView(_ uiView: SKView, context: Context) {
  
    }

//    class Coordinator: NSObject {
//        var scene: ShipScene?
//
//        @objc func update(_ sender: UITapGestureRecognizer) {
//
//        }
//    }

    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }

    func updateUIView(_ uiView: LightsSpeedSceneView, context: Context) {
    
    }
}
