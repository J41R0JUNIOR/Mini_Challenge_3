import SwiftUI
import SpriteKit

struct MainView: View {
    @StateObject var mainView = MainViewMVVM()
   
    
    var body: some View {
        ZStack {
//            SpriteKitView3()
//            .ignoresSafeArea()
            
            if mainView.shipState != "Outside"{
             
                    
                    SpriteView(scene: mainView.backGroundScene)
                        .ignoresSafeArea()
                        .navigationBarBackButtonHidden()
                    
                    if mainView.shipAppear == true{
                        ObjectsSceneView(sceneSpeed: $mainView.shipSpeed, witchObject: $mainView.witchObject, canClearChat: $mainView.canClearChat)
                    }
                    ShipSceneView(sceneSpeed: $mainView.shipSpeed, shipAppear: $mainView.shipAppear, witchObject: $mainView.witchObject, shipState: $mainView.shipState, canClearChat: $mainView.canClearChat, isLightSpeed: $mainView.isLightSpeed)
                    
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
                    
                    VStack{
                        Spacer()
                        HStack{
                            Spacer()
                            VStack{
                              
        //                        if !mainView.isLightSpeed{
                                   
                                    
                                    if mainView.shipAppear == true{
                                       
                                        
                                        Spacer()
                                        
                                        HStack{
                                            
                                            VStack{
                                                Text("Time Perseption")
                                                    .colorInvert()
                                                
                                                Spacer()
                                                //módulo ( velocidade - 50)
                                                
        //                                        Slider(value: Binding(get: {
        //                                            abs(mainView.shipSpeed - 50)
        //                                        }, set: {
        //                                            mainView.shipSpeed = $0}),
        //                                               in: 2.0...50.0, step: 0.1)
        //                                            .frame(width: 300)
        //                                            .rotationEffect(.degrees(-90))
        //                                            .padding()
        //                                            .tint(.clear)
                                                
                                                Slider(value: $mainView.shipSpeed, in: 2.0...60.0, step: 0.1)
                                                    .frame(width: 300)
                                                    .rotationEffect(.degrees(90))
                                                    .padding()
                                                    .tint(.clear)
                                                
                                                Spacer()
                                            }
                                            
                                            Spacer()
                                            
                                            VStack{
                                                if mainView.shipSpeed == 50{
                                                    Button {
                                                        mainView.isLightSpeed.toggle()
                                                    } label:{
                                                        Text("LightSpeed")
                                                    }
                                                }else{
                                                    Text(" ")
                                                }
                                                
                                                Text("ship speed \n \(mainView.shipSpeed)")
                                                    .colorInvert()
                                                
                                                Spacer()
                                                
                                                Slider(value: $mainView.shipSpeed, in: 2.0...50.0, step: 0.1)
                                                    .frame(width: 300)
                                                    .rotationEffect(.degrees(-90))
                                                    .padding()
                                                
                                                Spacer()
                                            }
                                        }
                                    }
                                }
                                Spacer()
                            }
                        }
                
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
