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
            
            if mainView.shipAppear{
                HStack{
                    Spacer()
                    VStack{
                        Text("aaa").colorInvert()
                        Spacer()
                    }
                    Spacer()
                }
                ObjectsSceneView(sceneSpeed: $mainView.shipSpeed, witchObject: $mainView.witchObject, canClearChat: $mainView.canClearChat)
                
                ShipSceneView(sceneSpeed: $mainView.shipSpeed, shipAppear: $mainView.shipAppear, witchObject: $mainView.witchObject, shipState: $mainView.shipState, canClearChat: $mainView.canClearChat, isLightSpeed: $mainView.isLightSpeed)
            }
            
            VStack{
                if !mainView.shipAppear{
                    
                    Spacer()
                    
                    ZStack{
                        
                        Rectangle()
                            .foregroundStyle(.black)
                            .border(.white)
                            .frame(maxWidth: 750, maxHeight: 350)
                        
                        Text(Chats.inicialLabel.rawValue)
                            .font(Font.custom(Chats.fontScene.rawValue, size: mainView.BigFontSize))
//                            .font(.system(size: 40))
//                            .font(mainView.customFont.getFont(size: 40))
                            .multilineTextAlignment(.center)
                            .foregroundStyle(Color(.texts))
                            .frame(maxWidth: 700, maxHeight: 300)
                    }
                    Spacer()
                    
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
                        if mainView.shipAppear == true && mainView.shipState == "Middle"{
                            Spacer()
                            
                            HStack{
                                VStack{
                                    Text(Chats.upLeft.rawValue)
                                        .font(Font.custom(Chats.fontScene.rawValue, size: mainView.NormalFontSize))
                                        .colorInvert()
                                    
                                    
                                    Spacer()
                                    
                                    Slider(value: $mainView.shipSpeed, in: 2.0...mainView.maxSpeed, step: 0.1)
                                        .frame(width: 300)
                                        .rotationEffect(.degrees(90))
                                        .padding()
                                        .tint(.clear)
                                    
                                    Spacer()
                                }
                                
                                Spacer()
                                
                                VStack{
                                    if mainView.shipSpeed == mainView.maxSpeed{
                                        Button {
                                            mainView.isLightSpeed.toggle()
                                            
                                        } label:{
                                            Text(Chats.lightSpeedButton.rawValue)
                                                .font(Font.custom(Chats.fontScene.rawValue, size: mainView.NormalFontSize))
                                        }
                                    }else{
                                        Text(" ")
                                            .font(Font.custom(Chats.fontScene.rawValue, size: mainView.NormalFontSize))
                                        
                                    }
                                    
                                    Text("\(Chats.upRight.rawValue) \n \(mainView.calculateRealSpeed(mainView.shipSpeed)) km/s")
                                        .font(Font.custom(Chats.fontScene.rawValue, size: mainView.NormalFontSize))
                                        .colorInvert()
                                    
                                    Spacer()
                                    
                                    Slider(value: $mainView.shipSpeed, in: 2.0...mainView.maxSpeed, step: 0.1)
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

