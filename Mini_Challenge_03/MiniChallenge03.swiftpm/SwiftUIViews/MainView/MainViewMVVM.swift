//
//  File.swift
//  
//
//  Created by Jairo Júnior on 08/12/23.
//

import Foundation
import SwiftUI
import SpriteKit


class MainViewMVVM: ObservableObject{
    @Published var shipSpeed: Double = 2.0
    @Published var shipAppear: Bool = false
    @Published var isLightSpeed: Bool = false
    @Published var witchObject: String = "Anything"
    @Published var shipState: String = "Inside"
    @Published var canClearChat: Bool = false
    @Published var customFont = CallFont()
    
    @Published var StartButtonProportion = CGFloat(160) / CGFloat(60)
    @Published var StartButtonWidth: CGFloat = 200

    var speedBinding: Binding<Double> {
        Binding(
            get: { self.shipSpeed },
            set: { newValue in
                self.shipSpeed = newValue
            }
        )
    }

    var shipAppearBinding: Binding<Bool> {
        Binding(
            get: { self.shipAppear },
            set: { newValue in
                self.shipAppear = newValue
            }
        )
    }
    
    var isLightSpeedBinding: Binding<Bool> {
        Binding(
            get: { self.isLightSpeed },
            set: { newValue in
                self.isLightSpeed = newValue
            }
        )
    }
    
    var witchObjectBinding: Binding<String> {
        Binding(
            get: { self.witchObject },
            set: { newValue in
                self.witchObject = newValue
            }
        )
    }
    
    var backGroundScene: SKScene {
        let scene = BackGroundScene(sceneSpeed: speedBinding)
//        scene.size = CGSize(width: 700, height: 500)
        scene.scaleMode = .fill
        return scene
    }
    
    var lightSpeed: SKScene {
        let scene = LightSpeedSceneScene(sceneSpeed: speedBinding)
//        scene.size = CGSize(width: 700, height: 500)
        scene.scaleMode = .fill
        return scene
    }
    
    var reverseBackGround: SKScene {
        let scene = ReverseBackGroundScene(sceneSpeed: speedBinding)
//        scene.size = CGSize(width: 700, height: 500)
        scene.scaleMode = .fill
        return scene
    }
}
