//
//  Character.swift
//  MiniChallenge03
//
//  Created by Jairo Júnior on 06/12/23.
//

import Foundation
import SpriteKit
import SwiftUI

class LightSpeedScene: SKScene {
    let cameraNode = SKCameraNode()
  
    var einstein: SKSpriteNode = {
        let object = SKSpriteNode(imageNamed: "einstein")
//        object.size = CGSize(width: 100, height: 100)
        return object
    }()
    
    override func didMove(to view: SKView) {
        self.backgroundColor = .clear
        self.addChild(cameraNode)
        cameraNode.position = CGPoint(x: 0, y: 0)
        cameraNode.setScale(1.0)
        self.camera = cameraNode
        self.addChild(einstein)
        add()
    }
    
    func add(){
        
        let x = (CGFloat(self.view?.bounds.size.width ?? 700)/2)

        print(x)
        einstein.size = CGSize(width: 100 + x, height: 100 + x)
        
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        _ = touch.location(in: self)
        _ = touch.previousLocation(in: self)
    }

    override func update(_ currentTime: TimeInterval) {
        
    }
}



struct LightsSpeedSceneView: UIViewRepresentable {
   
    func makeUIView(context: Context) -> SKView {
        let skView = SKView()
        skView.isMultipleTouchEnabled = true
        skView.backgroundColor = .clear
        let sceneSize = CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        let gameScene = LightSpeedScene()
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

    func updateUIView(_ uiView: LightsSpeedSceneView, context: Context) {
    
    }
}

