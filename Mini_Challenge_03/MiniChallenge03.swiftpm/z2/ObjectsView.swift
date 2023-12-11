import SpriteKit
import SwiftUI

class ObjectsView: SKScene {
    var objects: [SKSpriteNode] = []
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
        self.backgroundColor = .clear
        camera?.setScale(1.0)
        scheduleObjectCreation()  // Agendar criação de objetos
    }

    func scheduleObjectCreation() {
        let wait = SKAction.wait(forDuration: 60.0)
        let create = SKAction.run {
            self.createObjects()
            self.scheduleObjectCreation()
        }
        let sequence = SKAction.sequence([wait, create])
        run(sequence, withKey: "objectCreation")
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        _ = touch.location(in: self)
        _ = touch.previousLocation(in: self)
    }

    override func update(_ currentTime: TimeInterval) {
        moveObjects(withSpeed: CGFloat(sceneSpeed))
        removeObjectsOutOfBounds()
    }

    func createObjects() {
        let object: SKSpriteNode = {
            let node = SKSpriteNode(imageNamed: "jupiter")
            node.size = CGSize(width: 600, height: 600)
            let x = size.width * 1.5
            node.position = CGPoint(x: x, y: 250)

            return node
        }()

        objects.append(object)
        addChild(object)
    }

    func removeObjectsOutOfBounds() {
        for object in objects {
            let x = object.position.x
            let screenWidth = size.width
            if x < -screenWidth/2 {
                object.removeFromParent()

                if let indexToRemove = objects.firstIndex(of: object) {
                    objects.remove(at: indexToRemove)
                }
            }
        }
    }

    func moveObjects(withSpeed speed: CGFloat) {
        for object in objects {
            if object.action(forKey: "moving") == nil {
                let speedFactor = 1
                let moveAction = SKAction.moveBy(x: -10 * (speed * 0.2) * CGFloat(speedFactor), y: 0, duration: 0.1)
                object.run(moveAction, withKey: "moving")
            }
        }
    }
}

struct ObjectsSceneView: UIViewRepresentable {
    @Binding var sceneSpeed: Double

    func makeUIView(context: Context) -> SKView {
        let skView = SKView()
        skView.isMultipleTouchEnabled = true
        skView.backgroundColor = .clear
        let sceneSize = CGSize(width: 700, height: 500)
        let gameScene = ObjectsView(sceneSpeed: $sceneSpeed)
        gameScene.size = sceneSize
        skView.presentScene(gameScene)

        return skView
    }

    func updateUIView(_ uiView: SKView, context: Context) {
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }

    func updateUIView(_ uiView: ObjectsView, context: Context) {
    }
}
