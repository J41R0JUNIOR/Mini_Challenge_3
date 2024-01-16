import SpriteKit
import SwiftUI

class ObjectsScene: SKScene {
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
        
        super.init(size: CGSize())
        scaleMode = .resizeFill
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func didMove(to view: SKView) {
        view.showsFPS = true
        view.showsNodeCount = true
        self.backgroundColor = .clear
        self.addChild(cameraNode)
        cameraNode.position = CGPoint(x: 0, y: 0)
        cameraNode.setScale(1.0)
        self.camera = cameraNode
    }

    func scheduleObjectCreation() {
        guard let object = self.objectsName.first else {
            return
        }

        self.createObjects(nameOfObject: object)
        self.areThereObjectAtScreen = true
        self.witchObject = object

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
//        print(self.view?.scene?.children.count)
        
        moveObjects(withSpeed: CGFloat(sceneSpeed))
        removeObjectsOutOfBounds()
        changeColorsOfObjects()
        
        if self.witchObject == "Anything" {
            witchObject = "obj in scene"
            
            let delayAction = SKAction.wait(forDuration: 1)
            let callFunctionAction = SKAction.run { [weak self] in
                self?.scheduleObjectCreation()
            }
                   
            self.run(SKAction.sequence([delayAction, callFunctionAction]))
        }
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
            
            let x = /*size.width*/ (CGFloat(self.view?.bounds.size.width ?? 700)/2) + (CGFloat(node.size.width )/2)
            node.position = CGPoint(x: x, y: 0)
            return node
        }()
        
        objects.append(object)
        addChild(object)
    }

    func removeObjectsOutOfBounds() {
        for object in objects {
            let x = object.position.x
            let screenWidth = CGFloat(self.view?.bounds.size.width ?? 700)
            if x < -screenWidth/2 - (CGFloat(objects.first?.size.width ?? 650)/2) {
                object.removeFromParent()

                if let indexToRemove = objects.firstIndex(of: object) {
                    objects.remove(at: indexToRemove)
                    areThereObjectAtScreen = false
                    witchObject = "Anything"
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
    
    func changeColorsOfObjects(){
        let screenWidth = CGFloat(self.view?.bounds.width ?? 700) - 550

        let x = objects.first?.position.x ?? CGFloat()
        let normalizedX = x / (screenWidth / 2) * sceneSpeed - (x > 0 ? 2 : -2)
        
        
        let redColor = max(0.0, 1.0 - normalizedX)
        let blueColor = max(0.0, 1.0 + normalizedX)

        let viewW = (view?.bounds.size.width ?? CGFloat(200))
        
        
        objects.first?.color = SKColor(red: redColor, green: 0.0, blue: blueColor, alpha: 1.0)
        
            if let po = objects.first?.position.x{
                //porcentagem da tela de acordo com o objeto na tela
                let percentT = abs((po * 100) / (viewW/2) / 100)
                let percentV = abs(((sceneSpeed * 100) / 50) / 100)
                
                let value =  ((percentT + percentV) / 2)
            
                objects.first?.colorBlendFactor = /* (0.5 * sceneSpeed) * abs(x / 100)*/ value
            }
        
        let mult = 0.1
        
        if objects.first?.position.x ?? CGFloat() < viewW * mult && objects.first?.position.x ?? CGFloat() > -viewW * mult{
            objects.first?.colorBlendFactor = 0
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
        let gameScene = ObjectsScene(sceneSpeed: $sceneSpeed, witchObject: $witchObject, canClearChat: $canClearChat)
        gameScene.size = sceneSize
        skView.presentScene(gameScene)

        return skView
    }

    func updateUIView(_ uiView: SKView, context: Context) {
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }

    func updateUIView(_ uiView: ObjectsScene, context: Context) {
    }
}
