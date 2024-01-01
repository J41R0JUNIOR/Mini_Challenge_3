import SpriteKit
import SwiftUI

enum chats: String{
    case jupiter = "A luz demora em média 0,4s para dar a volta completa em Júpiter, isso significa que em um segundo ela dá duas voltas em torno do planeta e em um minuto 23 voltas"
    case earth = "A luz demora em média 0,04s para dar a volta completa na Terra, isso significa que em um segundo ela dá 23 voltas em torno do planeta e em um minuto 1211 voltas"
}

class MainScene: SKScene {
    @Binding var sceneSpeed: Double
    @Binding var shipAppear: Bool
    @Binding var witchObject: String
    @Binding var shipState: String
    @Binding var canClearChat: Bool
    @Binding var isLightSpeed: Bool


    init(sceneSpeed: Binding<Double>, shipAppear: Binding<Bool>, witchObject: Binding<String>, isShipInView: Binding<String>, canClearChat: Binding<Bool>, isLightSpeed: Binding<Bool>) {
        self._sceneSpeed = sceneSpeed
        self._shipAppear = shipAppear
        self._witchObject = witchObject
        self._canClearChat = canClearChat
        self._isLightSpeed = isLightSpeed
        self._shipState = isShipInView
        
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
    
    let fireTexturesG = [SKTexture(imageNamed: "f1g"),
                        SKTexture(imageNamed: "f2g"),
                        SKTexture(imageNamed: "f3g"),
                        SKTexture(imageNamed: "f4g"),
                        SKTexture(imageNamed: "f5g")]
    
    let fireTexturesGG = [SKTexture(imageNamed: "f1gg"),
                        SKTexture(imageNamed: "f2gg"),
                        SKTexture(imageNamed: "f3gg"),
                        SKTexture(imageNamed: "f4gg"),
                        SKTexture(imageNamed: "f5gg")]
    
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
        
//        ship.position = CGPoint(x: view.frame.midX, y: view.frame.midY)
        self.addChild(cameraNode)
        cameraNode.position = CGPoint(x: 0, y: 0)
        cameraNode.setScale(1.0)
        self.camera = cameraNode
    
        ship.zPosition = 1
        addChild(ship)
        ship.position = CGPoint(x: -750 , y: 0)
//        print(ship.position)
      
                
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
    
    func addChat(text: String){
        print("foi em")
        print(text)
        chat.text = text
//        chat.fontSize = 15
        chat.fontColor = UIColor(resource: .texts)
        chat.horizontalAlignmentMode = .center
        chat.verticalAlignmentMode = .top
        chat.numberOfLines = 0
        chat.preferredMaxLayoutWidth = size.width - 40
        
        if chat.parent == nil{
            addChild(chat)
        }
        chat.position.x = cameraNode.position.x
        chat.position.y = cameraNode.position.y - 180
        
        
    }
    
    var chat: SKLabelNode = SKLabelNode()

    
    func callChat(){
        if witchObject == "jupiter"{
            witchObject = "obj in scene"
            addChat(text: chats.jupiter.rawValue)
            
        }
        else if witchObject == "earth"{
            witchObject = "obj in scene"
            addChat(text: chats.earth.rawValue)
            
        }
        else if witchObject == "Anything"{
            chat.removeFromParent()
        }
        else if canClearChat == true{
            chat.removeFromParent()
        }
    }
    override func update(_ currentTime: TimeInterval) {
//        print(sceneSpeed)
        // Supondo que chats seja um enum e witchObject seja uma string
//
        callChat()
//
        
        
        if shipAppear == true{
            moveShip(withSpeed: sceneSpeed)
        }
        
        if sceneSpeed >= 50{
            if fireNode.action(forKey: "moveFireGG") == nil {
                let moveFireGG = SKAction.repeatForever(.animate(with: fireTexturesGG, timePerFrame: 0.1))
                fireNode.removeAction(forKey: "moveFire")
                fireNode.removeAction(forKey: "moveFireG")
                fireNode.run(moveFireGG, withKey: "moveFireGG")
            }
        } else if sceneSpeed >= 30 {
            if fireNode.action(forKey: "moveFireG") == nil {
                let moveFireG = SKAction.repeatForever(.animate(with: fireTexturesG, timePerFrame: 0.15))
                fireNode.removeAction(forKey: "moveFire")
                fireNode.removeAction(forKey: "moveFireGG")
                fireNode.run(moveFireG, withKey: "moveFireG")
            }
        } else if sceneSpeed <= 49{
            if fireNode.action(forKey: "moveFire") == nil {
                let moveFire = SKAction.repeatForever(.animate(with: fireTextures, timePerFrame: 0.2))
                fireNode.removeAction(forKey: "moveFireG")
                fireNode.removeAction(forKey: "moveFireGG")
                fireNode.run(moveFire, withKey: "moveFire")
            }
        }
    }
    
    func moveShip(withSpeed speed: CGFloat) {
        
        if !isLightSpeed{
            if (ship.position.x < 0) {
                if ship.action(forKey: "movingInside") == nil {
                    //               let speedFactor = sceneSpeed > speedToGoBack ? -1 : 1
                    let speedFactor = 1
                    let moveAction = SKAction.moveBy(x: 10 * speed * CGFloat(speedFactor), y: 0, duration: 0.1)
                    ship.run(moveAction, withKey: "movingInside")
                    fireNode.run(moveAction, withKey: "movingInside")
                }
            }else{
                ship.removeAction(forKey: "movingInside")
                fireNode.removeAction(forKey: "movingInside")
                shipState = "Mid"
            }
        }else if let widthLength = view?.bounds.width {
                if ship.position.x < widthLength{
                    if ship.action(forKey: "movingOutside") == nil {
                        //               let speedFactor = sceneSpeed > speedToGoBack ? -1 : 1
                        let speedFactor = 1
                        let moveAction = SKAction.moveBy(x: 10 * /*speed **/ CGFloat(speedFactor), y: 0, duration: 0.1)
                        ship.run(moveAction, withKey: "movingOutside")
                        fireNode.run(moveAction, withKey: "movingOutside")
                    }
                }
                else{
//                    ship.action(forKey: "Outside")
                    shipState = "Outside"
                }
//                else{
//                    ship.removeFromParent()
//                    fireNode.removeFromParent()
//                }
            }
        
    }
    
    
}





struct ShipSceneView: UIViewRepresentable {
    @Binding var sceneSpeed: Double
    @Binding var shipAppear: Bool
    @Binding var witchObject: String
    @Binding var shipState: String
    @Binding var canClearChat: Bool
    @Binding var isLightSpeed: Bool

    
    func makeUIView(context: Context) -> SKView {
        let skView = SKView()
        skView.isMultipleTouchEnabled = true
        skView.backgroundColor = .clear
        let sceneSize = CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        let gameScene = MainScene( sceneSpeed: $sceneSpeed, shipAppear: $shipAppear, witchObject: $witchObject, isShipInView: $shipState, canClearChat: $canClearChat, isLightSpeed: $isLightSpeed)
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

    func updateUIView(_ uiView: MainScene, context: Context) {
    
    }
    
    
}
