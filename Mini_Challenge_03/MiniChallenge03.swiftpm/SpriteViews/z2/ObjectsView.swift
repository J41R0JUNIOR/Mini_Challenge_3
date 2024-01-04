import SpriteKit
import SwiftUI

class ObjectsView: SKScene {
    var objects: [SKSpriteNode] = []
    @Binding var sceneSpeed: Double
    @Binding var witchObject: String
    @Binding var canClearChat: Bool
    
    let cameraNode = SKCameraNode()

    
    var objectsName: [String] = ["earth", "jupiter", "earth", "jupiter", "earth", "jupiter", "earth", "jupiter", "earth", "jupiter", "earth", "jupiter", "earth"]
    
    
    var areThereObjectAtScreen: Bool = false

    init(sceneSpeed: Binding<Double>, witchObject: Binding<String>, canClearChat: Binding<Bool>) {
        self._sceneSpeed = sceneSpeed
        self._witchObject = witchObject
        self._canClearChat = canClearChat
        super.init(size: CGSize(width: 700, height: 500))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func didMove(to view: SKView) {
        view.showsFPS = true
        view.showsNodeCount = true
        self.backgroundColor = .clear
        cameraNode.setScale(1.0)
        self.camera = cameraNode
        cameraNode.position.x = -100
//        scheduleObjectCreation()
       
//        let wait = SKAction.wait(forDuration: 10)
//        let repeatAction = SKAction.repeatForever(SKAction.sequence([wait, SKAction.run {
//            self.scheduleObjectCreation()
//        }]))
//        self.run(repeatAction)
    }

    func scheduleObjectCreation() {
        print(objectsName.count)

        guard let object = self.objectsName.first else {
            return
        }

        self.createObjects(nameOfObject: object)
        self.areThereObjectAtScreen = true
        self.witchObject = object
        print("witch Object = \(self.witchObject)")

        if let indexToRemove = self.objectsName.firstIndex(of: object) {
            self.objectsName.remove(at: indexToRemove)
        }
    }


    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        _ = touch.location(in: self)
        _ = touch.previousLocation(in: self)
    }

    override func update(_ currentTime: TimeInterval) {
        moveObjects(withSpeed: CGFloat(sceneSpeed))
        removeObjectsOutOfBounds()
        
        if self.witchObject == "Anything" {
            witchObject = "obj in scene"
            
            let delayAction = SKAction.wait(forDuration: 10)
            let callFunctionAction = SKAction.run { [weak self] in
                self?.scheduleObjectCreation()
            }
                   
            self.run(SKAction.sequence([delayAction, callFunctionAction]))
        }
        
        //
        let screenWidth = CGFloat(self.view?.bounds.width ?? 1.0) - 550

        let x = objects.first?.position.x ?? CGFloat()
        let normalizedX = x / (screenWidth / 2) * sceneSpeed

        
        
        let redColor = max(0.0, 1.0 - normalizedX)
        let blueColor = max(0.0, 1.0 + normalizedX)

        objects.first?.color = SKColor(red: redColor, green: 0.0, blue: blueColor, alpha: 1.0)
        if sceneSpeed > 40{
            objects.first?.colorBlendFactor =  (1 * sceneSpeed) * 2 / 100
        }else{
            objects.first?.colorBlendFactor =  (1 * sceneSpeed) * 1 / 100

        }
        
//        print(cameraNode.position.x)
//        let x = objects.first?.position.x ?? CGFloat()
//        
//        if x > cameraNode.position.x{
//            let blueColor = x - 100
//            
//            objects.first?.color = SKColor(red: 0, green: 0.0, blue: blueColor, alpha: 1.0)
//        }else if x < cameraNode.position.x{
//            let redColor = x - 100
//            objects.first?.color = SKColor(red: -redColor, green: 0.0, blue: 0, alpha: 1.0)
//        }
//
//       
//        objects.first?.colorBlendFactor = 1 * sceneSpeed * 3 / 100
        
        //
            
    }

    func createObjects(nameOfObject: String) {
        canClearChat = false
        let object: SKSpriteNode = {
            let node = SKSpriteNode(imageNamed: nameOfObject)
            
            if nameOfObject == "jupiter" {
                node.size = CGSize(width: 650, height: 650)
            } else if nameOfObject == "earth" {
                node.size = CGSize(width: 200, height: 200)
            } else {
                node.size = CGSize(width: 600, height: 600)
            }
            
            let x = size.width * 1.2 + 100
            node.position = CGPoint(x: x, y: 0)
            return node
        }()
        
        objects.append(object)
        addChild(object)
        print(object.size)
    }


    func removeObjectsOutOfBounds() {
        for object in objects {
            let x = object.position.x
            let screenWidth = view?.bounds.width ?? 700 + 100
            if x < -screenWidth/2 {
                object.removeFromParent()

                if let indexToRemove = objects.firstIndex(of: object) {
                    objects.remove(at: indexToRemove)
                    areThereObjectAtScreen = false
                    witchObject = "Anything"
                    print("witch Object = \(self.witchObject)")
                    canClearChat = true
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
    @Binding var witchObject: String
    @Binding var canClearChat: Bool

    func makeUIView(context: Context) -> SKView {
        let skView = SKView()
        skView.isMultipleTouchEnabled = true
        skView.backgroundColor = .clear
        let sceneSize = CGSize(width: 700, height: 500)
        let gameScene = ObjectsView(sceneSpeed: $sceneSpeed, witchObject: $witchObject, canClearChat: $canClearChat)
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