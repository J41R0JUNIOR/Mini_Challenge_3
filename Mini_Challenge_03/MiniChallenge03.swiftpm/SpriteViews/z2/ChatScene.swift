//
//  File.swift
//  
//
//  Created by Jairo Júnior on 14/01/24.
//

import SpriteKit
import SwiftUI

class ChatScene: SKScene {
    
    //variables to control the entire enviroment
    @Binding var sceneSpeed: Double
    @Binding var witchObject: String
    @Binding var canClearChat: Bool
    
    //variables to the chats cumming from the planets and objects
    var chat: SKLabelNode = SKLabelNode()
    let chatLabel = SKNode()
    var square = SKShapeNode()
    
    let cameraNode = SKCameraNode()
    var characterNode: SKSpriteNode?
    
    init(sceneSpeed: Binding<Double>, witchObject: Binding<String>, canClearChat: Binding<Bool>) {
        self._sceneSpeed = sceneSpeed
        self._witchObject = witchObject
        self._canClearChat = canClearChat
        
        super.init(size: .init(width: 1, height: 1))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func sceneDidLoad() {
        self.scaleMode = .fill
        self.backgroundColor = .clear
    }

    override func didMove(to view: SKView) {
        self.backgroundColor = .clear
        self.addChild(cameraNode)
        cameraNode.position = CGPoint(x: 0, y: 0)
        cameraNode.setScale(1.0)
        self.camera = cameraNode
    
    }
    
    override func update(_ currentTime: TimeInterval) {
        callChat()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        _ = touch.location(in: self)
        _ = touch.previousLocation(in: self)

    }
    
   
    func addChat(text: String) {
//        print(text)
        chat.text = text
//        chat.fontName = "Helvetica-Bold"
        chat.fontName = Texts.fontScene.rawValue
        chat.fontSize = 30
        chat.fontColor = UIColor(resource: .texts)
        chat.horizontalAlignmentMode = .center
        chat.verticalAlignmentMode = .center
        chat.numberOfLines = 0
        chat.preferredMaxLayoutWidth = size.width * 0.60
      
        square = SKShapeNode(rectOf: CGSize(width: chat.frame.width + 50, height: chat.frame.height + 50), cornerRadius: 1)
        square.strokeColor = SKColor.white
        square.lineWidth = 2.0
        square.fillColor = .black
        square.zPosition = -1
        
        chatLabel.position.x = cameraNode.position.x
        chatLabel.position.y = -(CGFloat(self.view?.bounds.size.height ?? 700) / 2) + ((chat.frame.height * 1.2) / 2)

        if chatLabel.parent == nil && chat.parent == nil && square.parent == nil{
            chatLabel.addChild(chat)
            chatLabel.addChild(square)
            addChild(chatLabel)
        }
    }

    func callChat(){
        if witchObject == "jupiter"{
            witchObject = "obj in scene"
            addChat(text: Texts.jupiter.rawValue)
            
        }
        else if witchObject == "earth"{
            witchObject = "obj in scene"
            addChat(text: Texts.earth.rawValue)
            
        }
        else if witchObject == "Anything"{
            chat.removeFromParent()
            square.removeFromParent()
            chatLabel.removeFromParent()
        }
        else if canClearChat == true{
            chat.removeFromParent()
            square.removeFromParent()
            chatLabel.removeFromParent()
        }
    }
}





struct ChatSceneView: UIViewRepresentable {
    @Binding var sceneSpeed: Double
    @Binding var witchObject: String
    @Binding var canClearChat: Bool

    
    func makeUIView(context: Context) -> SKView {
        let skView = SKView()
        skView.isMultipleTouchEnabled = true
        skView.backgroundColor = .clear
        let sceneSize = CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        let gameScene = ChatScene(sceneSpeed: $sceneSpeed, witchObject: $witchObject, canClearChat: $canClearChat)
        gameScene.size = sceneSize
        skView.presentScene(gameScene)

        // Save the reference to the scene
//        context.coordinator.scene = gameScene
        return skView
    }

    func updateUIView(_ uiView: SKView, context: Context) {
  
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }

    func updateUIView(_ uiView: ShipScene, context: Context) {
    
    }
    
    
}

