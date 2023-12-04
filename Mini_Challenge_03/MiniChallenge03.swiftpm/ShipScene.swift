import SpriteKit
import SwiftUI

class ShipScene: SKScene {
    @Binding var sceneSpeed: Double

    init(sceneSpeed: Binding<Double>) {
        self._sceneSpeed = sceneSpeed
        super.init(size: CGSize(width: 1, height: 1))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var isTrue = true
    let cameraNode = SKCameraNode()
    
    
    let shipTextures = [SKTexture(imageNamed: "im1"),
                        SKTexture(imageNamed: "im2"),
                        SKTexture(imageNamed: "im3"),
                        SKTexture(imageNamed: "im4"),
                        SKTexture(imageNamed: "im5")]
    
    let ship : SKSpriteNode = {
        let object = SKSpriteNode(imageNamed: "im1")
        
        let proportion = CGFloat(349) / CGFloat(120)
        let width: CGFloat = 200
        let height: CGFloat = width / proportion
               
        object.size = CGSize(width: width, height: height)
        
        return object
    }()
    
    let fireTextures = [SKTexture(imageNamed: "f1"),
                        SKTexture(imageNamed: "f2"),
                        SKTexture(imageNamed: "f3"),
                        SKTexture(imageNamed: "f4"),
                        SKTexture(imageNamed: "f5")]
    
    let fireNode: SKSpriteNode = {
          let fire = SKSpriteNode(imageNamed: "f1")
        
        let proportion = CGFloat(60) / CGFloat(120)
        let width: CGFloat = 200
        let height: CGFloat = width / proportion
               
        fire.size = CGSize(width: width, height: height)
          return fire
      }()
    
    var characterNode: SKSpriteNode?

    override func sceneDidLoad() {
        self.scaleMode = .fill
        self.backgroundColor = .clear
    }

    override func didMove(to view: SKView) {
        
        
        self.backgroundColor = .clear
        
        ship.position = CGPoint(x: view.frame.midX, y: view.frame.midY)
        ship.zPosition = 1
        addChild(ship)
        ship.position = CGPoint(x: 0 , y: 0)
        ship.addChild(cameraNode)
        cameraNode.setScale(1.0)
        self.camera = cameraNode
                
        let moveAction = SKAction.repeatForever(.animate(with: shipTextures, timePerFrame: 0.2))
        moveAction.speed = 0
        ship.run(moveAction, withKey: "move")
        
        let moveFire = SKAction.repeatForever(.animate(with: fireTextures, timePerFrame: 0.2))
        moveAction.speed = 0
        
        fireNode.size = CGSize(width: ship.size.width, height: ship.size.height)
       
        fireNode.position = CGPoint(x: ship.position.x - ship.size.width /** 0.5*/, y: ship.position.y) // Ajuste conforme necessário
        self.addChild(fireNode)
        fireNode.run(moveFire, withKey: "moveF")
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }

        _ = touch.location(in: self)
        _ = touch.previousLocation(in: self)

    }

    override func update(_ currentTime: TimeInterval) {
//        print(sceneSpeed)
    }
}





struct SpriteKitView3: UIViewRepresentable {
    @Binding var sceneSpeed: Double
    func makeUIView(context: Context) -> SKView {
        let skView = SKView()
        skView.isMultipleTouchEnabled = true
        skView.backgroundColor = .clear
        let sceneSize = CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        let gameScene = ShipScene( sceneSpeed: $sceneSpeed)
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

    func updateUIView(_ uiView: ShipScene, context: Context) {
    
    }
    
    
}
