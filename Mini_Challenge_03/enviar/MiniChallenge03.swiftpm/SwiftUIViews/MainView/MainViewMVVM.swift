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
    
    var minSpeed: Double = 2.0
    var maxWidth = 700
    var maxHeight = 500
    
    var maxSpeed: Double = 50
    var maxSpeedInScene:Double = 290000
    var speedOfLight: Double = 299792
    
    @Published var accelerationTimer: Timer?
    @Published var breakTimer: Timer?

    
    
    func accelerateShip(canAccelerate: Bool) {
        if canAccelerate {
            accelerationTimer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { [weak self] _ in
                guard let self = self else { return }

                if self.shipSpeed < self.maxSpeed {
                    self.shipSpeed += 0.1
                }
            }
        } else {
            accelerationTimer?.invalidate()
            accelerationTimer = nil
        }
    }
    
    func breakShip(canBreak: Bool) {
        if canBreak {
            breakTimer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { [weak self] _ in
                guard let self = self else { return }

                if self.shipSpeed > self.minSpeed {
                    self.shipSpeed -= 0.3
                    accelerateShip(canAccelerate: false)
                }
            }
        } else {
            breakTimer?.invalidate()
            breakTimer = nil
        }
    }



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
        scene.size = CGSize(width: maxWidth, height: maxHeight)
        scene.scaleMode = .fill
        return scene
    }
    
     func calculateRealSpeed(_ speed: Double) -> Int {
         let realSpeed = Int((speed * speedOfLight / maxSpeed) * 0.9)
         
        return realSpeed
    }
    
    func speedFormatted(speed: Double) -> Int {
        let x =  ((speed * 300) / maxSpeed) * 0.9
        
        return Int(x)
    }
    
//    var date: Date =  Date()
//    
//    func calculateTimeDifference(speed: Double, currentTime: Date) -> Date {
//        let relativisticFactor = 1 / sqrt(1 - (pow(speed, 2) / pow(maxSpeedInScene, 2)))
//        let dilatedTimeInterval = currentTime.timeIntervalSinceReferenceDate * relativisticFactor
//        
//        let dilatedDate = Date(timeIntervalSinceReferenceDate: dilatedTimeInterval)
//
//        return dilatedDate
//    }
}

#Preview(body: {
    MainView() as any View
})