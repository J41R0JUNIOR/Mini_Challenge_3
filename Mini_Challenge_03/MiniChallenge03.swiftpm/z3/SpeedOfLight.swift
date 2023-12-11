import SpriteKit
import SwiftUI

class LightSpeedScene: SKScene {
    var stars: [SKSpriteNode] = []
    @Binding var sceneSpeed: Double
    var speedToGoBack = 49.0

    var starCreationRate: Double = 0.0
    var lastStarCreationTime: TimeInterval = 0
    
    var eistein: SKSpriteNode = {
        let object = SKSpriteNode(imageNamed: "einstein")
        object.size = CGSize(width: 300, height: 300)
        return object
    }()

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
            
            eistein.position = CGPoint(x: 500, y: 0)
            addChild(eistein)
            
            // Adiciona um atraso de 5 segundos antes de começar a criar as estrelas
            let delayAction = SKAction.wait(forDuration: 15.0)
            let createStarsAction = SKAction.run { [weak self] in
                self?.createStars()
            }
            let sequenceAction = SKAction.sequence([delayAction, createStarsAction])
            run(sequenceAction)
        }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        _ = touch.location(in: self)
        _ = touch.previousLocation(in: self)
    }

    override func update(_ currentTime: TimeInterval) {
        moveStars()

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

                if x < -(view?.frame.midX ?? -700) || x > (view?.frame.midX ?? -700) {
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
            let x = (CGFloat(self.view?.bounds.midX ?? 700)) * CGFloat(speedFactor)
            let randomY = CGFloat.random(in: -((self.view?.bounds.midY) ?? 500)...(self.view?.bounds.midY ?? 500))
            object.position = CGPoint(x: x, y: randomY)

            return object
        }()

        self.stars.append(star)
        self.addChild(star)
    }

    func updateStarWidth(estrelaNode: SKSpriteNode) {
        let originalWidth: CGFloat = 8.0
        let scaleFactor = CGFloat(1.0) + CGFloat(self.sceneSpeed) * 0.4
        let newWidth = originalWidth * scaleFactor
        let proportion = newWidth / originalWidth

        estrelaNode.size = CGSize(width: newWidth, height: (newWidth / proportion))
    }

    func moveStars() {
        for star in stars {
            if star.action(forKey: "moving") == nil {
                var moveDistance: CGFloat = -10
                if sceneSpeed > speedToGoBack {
                    // Ajuste a velocidade para um valor maior ao simular a velocidade da luz
                    moveDistance *= 10
                }
                let moveAction = SKAction.moveBy(x: moveDistance, y: 0, duration: 0.1)
                star.run(moveAction, withKey: "moving")
            }
        }
    }
}





struct SpriteKitBackGroundLightSpeed: UIViewRepresentable {
    @Binding var sceneSpeed: Double
    func makeUIView(context: Context) -> SKView {
        let skView = SKView()
        skView.isMultipleTouchEnabled = true
        skView.backgroundColor = .clear
        let sceneSize = CGSize(width: 700, height: 500)
        let gameScene = LightSpeedScene(sceneSpeed: $sceneSpeed)
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

    func updateUIView(_ uiView: BackGround, context: Context) {
    
    }
    
    
}

