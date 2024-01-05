//
//  File.swift
//
//
//  Created by Jairo Júnior on 01/01/24.
//

import SwiftUI
import SpriteKit

extension MainView{
    
    @ViewBuilder
    var shipView: some View {
        ZStack{
            SpriteView(scene: mainView.backGroundScene)
                .ignoresSafeArea()
                .navigationBarBackButtonHidden()
            
            if mainView.shipAppear == true{
                ObjectsSceneView(sceneSpeed: $mainView.shipSpeed, witchObject: $mainView.witchObject, canClearChat: $mainView.canClearChat)
                
            }
            ShipSceneView(sceneSpeed: $mainView.shipSpeed, shipAppear: $mainView.shipAppear, witchObject: $mainView.witchObject, shipState: $mainView.shipState, canClearChat: $mainView.canClearChat, isLightSpeed: $mainView.isLightSpeed)
            
            VStack{
                if mainView.shipAppear == false{
                    
                    Spacer()
                    
                    ZStack{
                        
                        Rectangle()
                            .foregroundStyle(.black)
                            .border(.white)
                            .frame(maxWidth: 750, maxHeight: 350)
                        
                        Text(chats.initialChat.rawValue)
//                            .font(.system(size: 40))
//                            .font(getFont(size: 30))
                            .font(mainView.customFont.getFont(size: 40))
                            .multilineTextAlignment(.center)
                        //                        .font(Font.custom(<#T##name: String##String#>, size: 40))
                            .foregroundStyle(Color(.texts))
                            .frame(maxWidth: 700, maxHeight: 300)
                    }
                    
                    Spacer()
                    
                    Button {
                        mainView.shipAppear = true
                        print(mainView.shipAppear)
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
                        if mainView.shipAppear == true && mainView.shipState == "Middle"{
                            Spacer()
                            
                            HStack{
                                
                                VStack{
                                    Text("Time Perseption")
                                        .colorInvert()
                                    
                                    Spacer()
                                    
                                    Slider(value: $mainView.shipSpeed, in: 2.0...50.0, step: 0.1)
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
        }
    }
}

