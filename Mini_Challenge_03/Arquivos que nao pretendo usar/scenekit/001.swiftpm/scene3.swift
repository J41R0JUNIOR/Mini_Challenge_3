import SpriteKit
import SwiftUI

class GameView3: SKScene {
   
    var isTrue = true
    let cameraNode = SKCameraNode()
    
    var stars : [SKSpriteNode] = []
    
    let shipTextures = [SKTexture(imageNamed: "im1"),
                        SKTexture(imageNamed: "im2")]
    
    let ship : SKSpriteNode = {
        let object = SKSpriteNode(imageNamed: "im1")
        
        let proportion = CGFloat(349) / CGFloat(120)
        let width: CGFloat = 349
        let height: CGFloat = width / proportion
               
        object.size = CGSize(width: width, height: height)
        
        return object
    }()

    override func didMove(to view: SKView) {
        
        view.showsFPS = true
        view.showsNodeCount = true
        
        backgroundColor = UIColor(resource: .sky)
        ship.position = CGPoint(x: view.frame.midX, y: view.frame.midY)
        ship.zPosition = 1
        addChild(ship)
        ship.position = CGPoint(x: 0 , y: 0)
        ship.addChild(cameraNode)
        cameraNode.setScale(1.0)
        self.camera = cameraNode
        
       createStars()
        
        let moveAction = SKAction.repeatForever(.animate(with: shipTextures, timePerFrame: 0.2))
        moveAction.speed = 0
        ship.run(moveAction, withKey: "move")
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }

        _ = touch.location(in: self)
        _ = touch.previousLocation(in: self)

    }

    override func update(_ currentTime: TimeInterval) {
        
        moveStars()
        
        for (_, estrela) in self.children.enumerated().reversed() {
           if let estrelaNode = estrela as? SKSpriteNode {
               if estrelaNode.position.x < -(view?.frame.midX ?? -2000) {
                   estrelaNode.removeFromParent()
                   
                   if let indexToRemove = stars.firstIndex(of: estrelaNode) {
                       stars.remove(at: indexToRemove)
                       print(stars.count)
                   }
               }
           }
       }
    }
    
    func createStars() {
        let waitAction = SKAction.wait(forDuration: 0.1)
        
        let createStarAction = SKAction.run {
            let star : SKSpriteNode = {
                
                let object = SKSpriteNode(imageNamed: "star")
                let proportion = CGFloat(64) / CGFloat(64)
                let width: CGFloat = 15
                let height: CGFloat = width / proportion
                
                object.size = CGSize(width: width, height: height)
                
                let randomX = CGFloat(self.view?.bounds.midX ?? 2000) + 100
                let randomY = CGFloat.random(in: -((self.view?.bounds.midY) ?? 500)...(self.view?.bounds.midY ?? 500))
                object.position = CGPoint(x: randomX, y: randomY)
                
                return object
            }()
            
            self.stars.append(star)
            self.addChild(star)
        }

        let infiniteSequence = SKAction.repeatForever(SKAction.sequence([waitAction, createStarAction]))
        run(infiniteSequence, withKey: "createStarsSequence")
    }

    func moveStars(){
        for star in stars {
            if star.action(forKey: "moving") == nil{
                let moveAction = SKAction.moveBy(x: -10, y: 0, duration: 0.1)
                star.run(moveAction, withKey: "moving")
            }
        }
    }

    func loadSKSFile() {
        if let sksFileName = Bundle.main.path(forResource: "GameScene3", ofType: "sks") {
            if let scene = SKScene(fileNamed: sksFileName) {
                if let skView = view {
                    skView.presentScene(scene)
                }
            }
        }
    }
}









struct SpriteKitView3: UIViewRepresentable {
    func makeUIView(context: Context) -> SKView {
        let skView = SKView()
        skView.isMultipleTouchEnabled = true
        let sceneSize = CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        let gameScene = GameView3(size: sceneSize)
        skView.presentScene(gameScene)

        // Save the reference to the scene
        context.coordinator.scene = gameScene
        return skView
    }

    func updateUIView(_ uiView: SKView, context: Context) {
  
    }

    class Coordinator: NSObject {
        var scene: GameView3?

        @objc func update(_ sender: UITapGestureRecognizer) {
          
        }

        @objc func addPlanetButtonPressed() {
            
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }

    func updateUIView(_ uiView: GameView3, context: Context) {
    
    }
    
    
}
