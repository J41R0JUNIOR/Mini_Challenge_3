import SwiftUI
import SceneKit
import SpriteKit

struct ContentView: View {
//    @State var scene: SCNScene? = .init(named: "nave.scn")
    var body: some View {
        VStack {
            
//                GameView()
                SpriteKitView()
//                SpriteKitView3()
                .ignoresSafeArea()
            
//                SceneScene3(/*scene: $scene*/)
//                    .frame(width: 350, height: 350)
           
            
               
           
        }.background(.black)
    }
}
