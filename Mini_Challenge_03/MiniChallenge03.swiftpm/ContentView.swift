import SwiftUI
import SpriteKit

struct ContentView: View {
    @State var speed: Double = 2.0
    
//    var scene: SKScene {
//        let scene = ShipScene()
//        scene.size = CGSize(width: 900, height: 800)
//        scene.scaleMode = .fill
//        return scene
//    }
    
    var backGroundScene: SKScene {
        let scene = BackGround(sceneSpeed: $speed)
        scene.size = CGSize(width: 900, height: 800)
        scene.scaleMode = .fill
        return scene
    }
    
    
    var body: some View {
        ZStack {
            
//            SpriteKitView3()
//            .ignoresSafeArea()
            SpriteView(scene: backGroundScene)
                .ignoresSafeArea()
                .navigationBarBackButtonHidden()
//            if speed < 49{
//                SpriteView(scene: backGroundScene)
//                    .ignoresSafeArea()
//                    .navigationBarBackButtonHidden()
//            }else{
//                SpriteView(scene: reversedBackGroundScene)
//                    .ignoresSafeArea()
//                    .navigationBarBackButtonHidden()
//            }
            
            SpriteKitView3(sceneSpeed: $speed)
            
            VStack{
                Spacer()
                HStack{
                    Spacer()
                    VStack{
                        Spacer()
                        Slider(value: $speed, in: 2.0...50.0, step: 0.1)
                            .frame(width: 300)
                            .rotationEffect(.degrees(-90))
                            .padding()
                        Spacer()
                    }
                }
            }
            
//            SpriteView(scene: scene)
//                            .frame(width: 900, height: 800)
//                .ignoresSafeArea()
//                .navigationBarBackButtonHidden()
            
        }.background(.black)
    }
}
