import SwiftUI
import SpriteKit

struct MainView: View {
    @StateObject var mainView = MainViewMVVM()
   
    
    var body: some View {
        ZStack {
//            SpriteKitView3()
//            .ignoresSafeArea()
            
            if mainView.shipState != "Outside"{
             
                shipView
                       
            }else if mainView.shipState == "Outside"{

                ZStack{
//                    SpriteView(scene: lightSpeed)
//                        .ignoresSafeArea()
//                        .navigationBarBackButtonHidden()

//                    SpriteView(scene: reverseBackGround)
//                        .ignoresSafeArea()
//                        .navigationBarBackButtonHidden()

//                   SpriteKitBackGroundLightSpeed(sceneSpeed: $speed)
                    CharacterView1()
//                    ObjectsSceneView(sceneSpeed: $speed)
                }
            }
            
//            if speed < 49{
//                SpriteView(scene: backGroundScene)
//                    .ignoresSafeArea()
//                    .navigationBarBackButtonHidden()
//            }else{
//                SpriteView(scene: reversedBackGroundScene)
//                    .ignoresSafeArea()
//                    .navigationBarBackButtonHidden()
//            }
            
           
         
            
         
//            }
        }.background(.black)
    }
}
