import SpriteKit
import SwiftUI

class ReverseBackGround: SKScene {
    var isTrue = true
    let cameraNode = SKCameraNode()
    var stars: [SKSpriteNode] = []
    var speedToGoBack = 49.0

    var starCreationRate: Double = 0.0
    var lastStarCreationTime: TimeInterval = 0
    
    @Binding var sceneSpeed: Double

    init(sceneSpeed: Binding<Double>) {
        self._sceneSpeed = sceneSpeed
        super.init(size: CGSize(width: 1, height: 1))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func didMove(to view: SKView) {
        view.showsFPS = true
        view.showsNodeCount = true
        backgroundColor = UIColor(resource: .sky)
        cameraNode.setScale(1.0)
        self.camera = cameraNode
        createStars()
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        _ = touch.location(in: self)
        _ = touch.previousLocation(in: self)
    }

    override func update(_ currentTime: TimeInterval) {
           moveStars(withSpeed: CGFloat(sceneSpeed))

           let speedMultiplier = 1.0 + CGFloat(sceneSpeed)
           starCreationRate = max(0.5 / speedMultiplier, 0.000001)

           if currentTime - lastStarCreationTime > starCreationRate {
               createStars()
               lastStarCreationTime = currentTime
           }

           for (_, estrela) in self.children.enumerated().reversed() {
               if let estrelaNode = estrela as? SKSpriteNode {
                   updateStarWidth(estrelaNode: estrelaNode)
                   let x = estrelaNode.position.x

                   if x > (view?.frame.midX ?? 700) {
                       estrelaNode.removeFromParent()

                       if let indexToRemove = stars.firstIndex(of: estrelaNode) {
                           stars.remove(at: indexToRemove)
                       }
                   }
               }
           }
       }

       func createStars() {
           let star: SKSpriteNode = {
               let object = SKSpriteNode(imageNamed: "star")
               let originalWidth: CGFloat = 8.0
               let scaleFactor = CGFloat(1.0) + CGFloat(self.sceneSpeed) * 0.5
               let newWidth = originalWidth * scaleFactor
               let proportion = newWidth / originalWidth
               object.size = CGSize(width: newWidth, height: newWidth / proportion)

               let speedFactor = 1
               let x = -(CGFloat(self.view?.bounds.midX ?? -700)) * CGFloat(speedFactor)
               let randomY = CGFloat.random(in: -((self.view?.bounds.midY) ?? 500)...(self.view?.bounds.midY ?? 500))
               object.position = CGPoint(x: x, y: randomY)

               return object
           }()

           self.stars.append(star)
           self.addChild(star)
       }

       func moveStars(withSpeed speed: CGFloat) {
           for star in stars {
               if star.action(forKey: "moving") == nil {
                   let speedFactor = 1
                   let moveAction = SKAction.moveBy(x: 10 * speed * CGFloat(speedFactor), y: 0, duration: 0.1)
                   star.run(moveAction, withKey: "moving")
               }
           }
       }

    func updateStarWidth(estrelaNode: SKSpriteNode) {
        let originalWidth: CGFloat = 8.0

        let scaleFactor = CGFloat(1.0) + CGFloat(self.sceneSpeed) * 0.4
        var newWidth = CGFloat()
        
        newWidth = originalWidth * scaleFactor
        
        
        let proportion = newWidth / originalWidth

        estrelaNode.size = CGSize(width: newWidth, height: (newWidth / proportion))
    }




}

