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
    var show2 : Bool = false
    var i: Int = 0
    
  
    var einstein: SKSpriteNode = {
        let object = SKSpriteNode(imageNamed: "einstein")
//        object.size = CGSize(width: 100, height: 100)
        return object
    }()
    
    override func didMove(to view: SKView) {
        add()
    }
    
    func add(){
        //add and setting camera to the scene
        self.backgroundColor = .clear
        self.addChild(cameraNode)
        cameraNode.position = CGPoint(x: 0, y: 0)
        cameraNode.setScale(1.0)
        self.camera = cameraNode
        
        //add Einstein to the scene
        self.addChild(einstein)
    }
    
    func characterSetting(){
        if show2{
            let frame = (CGFloat(self.view?.bounds.size.width ?? 700)/2) * 0.5
            einstein.size = CGSize(width: frame, height: frame)
            
            if let view = self.view{
                einstein.position = CGPoint(x: (view.frame.width / 2) * 0.5 , y: 0)
            }
            einstein.isHidden = false

        }else{
            einstein.isHidden = true
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        show2.toggle()
    }

    override func update(_ currentTime: TimeInterval) {
       characterSetting()
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

