//
//  File.swift
//
//
//  Created by Jairo Júnior on 01/01/24.
//

import SwiftUI
import SpriteKit
import UIKit

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
                        Text("Hora atual: \(Date().formatted(date: .omitted, time: .complete))").colorInvert()
                        Text("Hora da nave: ").colorInvert()
                        Text("Diferenca: \(mainView.date.formatted(date: .omitted, time: .complete))").colorInvert()
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
                                    
//                                    Slider(value: $mainView.shipSpeed, in: 2.0...mainView.maxSpeed, step: 0.1)
//                                        .frame(width: 300)
//                                        .rotationEffect(.degrees(90))
////                                        .padding()
//                                        .tint(.clear)
                                    
                                    Button(action: {
                                        
                                    }, label: {
                                        Text("Frear")
                                            .font(Font.custom(Chats.fontScene.rawValue, size: mainView.NormalFontSize))
                                            .foregroundStyle(.white)
                                    }).padding()
                                    .onLongPressGesture(minimumDuration: 1) {
                                        mainView.breakShip(canBreak: true)
                                    } onPressingChanged: { inProgress in
                                        
                                        mainView.breakShip(canBreak: false)
                                        
                                        if inProgress {
                                            mainView.breakShip(canBreak: true)
                                        }else{
                                            mainView.breakShip(canBreak: false)
                                        }
                                    }.padding()
                                    
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
                                    ZStack{
                                        SpeedCounter(startAngle: .degrees(0), endAngle: .degrees(300), clockWise: false)
                                            .stroke(.gray, style: StrokeStyle(lineWidth: 10.5, lineCap: .round, lineJoin: .round))
                                            .frame(width: 100, height: 100)
                                        
                                        SpeedCounter(startAngle: .degrees(0), endAngle: .degrees(Double(mainView.calculateShowSpeed(speed: mainView.shipSpeed))), clockWise: false)
                                            .stroke(.linearGradient(colors: [/*Color(.color1), */Color(.color2), Color(.color3)], startPoint: .leading, endPoint: .trailing), style: StrokeStyle(lineWidth: 10.5, lineCap: .round, lineJoin: .round))
                                            .frame(width: 100, height: 100)
                                        
                                        VStack{
                                            Text("\(mainView.calculateRealSpeed(mainView.shipSpeed))")
                                                .font(Font.custom(Chats.fontScene.rawValue, size: mainView.NormalFontSize))
                                                .colorInvert()
                                            
                                        }
                                    }
                                    Text(Chats.upRight.rawValue)
                                    
                                    Spacer()
                                    
//                                    Slider(value: $mainView.shipSpeed, in: 2.0...mainView.maxSpeed, step: 0.1)
//                                        .frame(width: 300)
//                                        .rotationEffect(.degrees(-90))
//                                        .padding()
                                    
                                    Button(action: {
                                        
                                    }, label: {
                                        Text("Acelerar")
                                            .font(Font.custom(Chats.fontScene.rawValue, size: mainView.NormalFontSize))
                                            .foregroundStyle(.white)
                                    }).padding()
                                    .onLongPressGesture(minimumDuration: 1) {
                                        mainView.accelerateShip(canAccelerate: true)
                                    } onPressingChanged: { inProgress in
                                        
                                        mainView.accelerateShip(canAccelerate: false)
                                        
                                        if inProgress {
                                            mainView.accelerateShip(canAccelerate: true)
                                        }else{
                                            
                                            mainView.accelerateShip(canAccelerate: false)
                                        }
                                    }.padding()
                                    
                                    Spacer()
                                }
                            }.padding()
                        }
                        Spacer()
                    }
                }
            }
        }.onAppear {
            Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
                let timeDifference = mainView.calculateTimeDifference(speed: Double(mainView.calculateRealSpeed(mainView.shipSpeed)), currentTime: Date())
                mainView.date = timeDifference
            }
        }

    }
}
