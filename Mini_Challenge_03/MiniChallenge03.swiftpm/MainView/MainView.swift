import SwiftUI
import SpriteKit

struct MainView: View {
    @StateObject var mainView = MainViewMVVM()
   
    
    var body: some View {
        ZStack {
//            SpriteKitView3()
//            .ignoresSafeArea()
            if !mainView.isLightSpeed{
                SpriteView(scene: mainView.backGroundScene)
                    .ignoresSafeArea()
                    .navigationBarBackButtonHidden()
                
                if mainView.shipAppear == true{
                    ObjectsSceneView(sceneSpeed: $mainView.shipSpeed, witchObject: $mainView.witchObject, canClearChat: $mainView.canClearChat)
                }
                ShipSceneView(sceneSpeed: $mainView.shipSpeed, shipAppear: $mainView.shipAppear, witchObject: $mainView.witchObject, canClearChat: $mainView.canClearChat)
                VStack{
                    Spacer()
                    if mainView.shipAppear == false{
                        
                        
                        
                        Button {
                            mainView.shipAppear = true
                        } label: {
                            Image("startButtonBlack")
                                .resizable()
                                .frame(width: mainView.StartButtonWidth, height: mainView.StartButtonWidth / mainView.StartButtonProportion)
                        }
                    }
                }

            }else if mainView.isLightSpeed {
                ZStack{
//                    SpriteView(scene: lightSpeed)
//                        .ignoresSafeArea()
//                        .navigationBarBackButtonHidden()
                    
//                    SpriteView(scene: reverseBackGround)
//                        .ignoresSafeArea()
//                        .navigationBarBackButtonHidden()
                    
//                    SpriteKitBackGroundLightSpeed(sceneSpeed: $speed)
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
            
           
         
            
            VStack{
                Spacer()
                HStack{
                    Spacer()
                    VStack{
                        if mainView.shipSpeed == 50{
                            if !mainView.isLightSpeed{
                                Button {
                                    mainView.isLightSpeed.toggle()
                                } label:{
                                    Text("LightSpeed")
                                }
                            }
                        }
                        Spacer()
                        if !mainView.isLightSpeed{
                            if mainView.shipAppear == true{
                                Slider(value: $mainView.shipSpeed, in: 2.0...50.0, step: 0.1)
                                    .frame(width: 300)
                                    .rotationEffect(.degrees(-90))
                                    .padding()
                            }
                        }
                        Spacer()
                    }
                }
            }
        }.background(.black)
    }
}
