//
//  File.swift
//  
//
//  Created by Jairo Júnior on 23/01/24.
//

import SwiftUI

class LightSpeedMVVM: ObservableObject{
    @Published var mainView: MainViewMVVM
    @Published var index: Int = 0
    let text: [HudTexts] = [.p1,.e1,.p2,.e2]
    
    init(mainView: MainViewMVVM) {
        self.mainView = mainView
    }
    
    func button(){
        if index < text.count - 1{
            index += 1
        }else{
            mainView.shipState = "Inside"
            mainView.shipAppear = false
            mainView.isLightSpeed = false
            mainView.shipSpeed = 2.0
            mainView.accelerateShip(canAccelerate: false)
            
        }
    }
}
