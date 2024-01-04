//
//  Character.swift
//  MiniChallenge03
//
//  Created by Jairo Júnior on 06/12/23.
//

import Foundation
import SpriteKit
import SwiftUI

class ChatScene: SKScene {
  
    var eistein: SKSpriteNode = {
        let object = SKSpriteNode(imageNamed: "einstein")
        object.size = CGSize(width: 100, height: 100)
        return object
    }()
    
    let cameraNode = SKCameraNode()

    override func didMove(to view: SKView) {
        backgroundColor = .clear
        eistein.position = CGPoint(x: 500, y: 0)
        addChild(eistein)
        self.addChild(cameraNode)
        cameraNode.position.x = eistein.position.x - 250
        cameraNode.position.y = eistein.position.y
        cameraNode.setScale(1.0)
        self.camera = cameraNode
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        _ = touch.location(in: self)
        _ = touch.previousLocation(in: self)
    }

    override func update(_ currentTime: TimeInterval) {
        
    }
}



struct CharacterView1: UIViewRepresentable {
   
    func makeUIView(context: Context) -> SKView {
        let skView = SKView()
        skView.isMultipleTouchEnabled = true
        skView.backgroundColor = .clear
        let sceneSize = CGSize(width: 700, height: 500)
        let gameScene = ChatScene()
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

    func updateUIView(_ uiView: CharacterView1, context: Context) {
    
    }
    
    
}

