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
    var MainSceneBuilder: some View {
        ZStack{
            //backGround of the scene
            SpriteView(scene: mainView.backGroundScene)
                .ignoresSafeArea()
                .navigationBarBackButtonHidden()
            
            if !mainView.shipAppear{
                VStack{
                    Spacer()
                    
                    ZStack{
                        
                        Rectangle()
                            .foregroundStyle(.black)
                            .border(.white)
                            .frame(maxWidth: 750, maxHeight: 350)
                        
                        Text(Texts.inicialLabel.rawValue)
                            .font(Font.custom(Texts.fontScene.rawValue, size: mainView.BigFontSize))
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
            } else {
                ObjectsSceneView(sceneSpeed: $mainView.shipSpeed, witchObject: $mainView.witchObject, canClearChat: $mainView.canClearChat)
                
                ChatSceneView(sceneSpeed: $mainView.shipSpeed, witchObject: $mainView.witchObject, canClearChat: $mainView.canClearChat)
                
                ShipSceneView(sceneSpeed: $mainView.shipSpeed, shipAppear: $mainView.shipAppear, witchObject: $mainView.witchObject, shipState: $mainView.shipState, canClearChat: $mainView.canClearChat, isLightSpeed: $mainView.isLightSpeed)
                
                if mainView.shipState == "Middle"{
                    
                    VStack{
                        HStack{
                            VStack{
                                //                                    Spacer()
                                Text(Texts.upLeft.rawValue)
                                    .font(Font.custom(Texts.fontScene.rawValue, size: mainView.NormalFontSize))
                                    .colorInvert()
                                
                                
                                //                                    Spacer()
                                
                                //                                    Slider(value: $mainView.shipSpeed, in: 2.0...mainView.maxSpeed, step: 0.1)
                                //                                        .frame(width: 300)
                                //                                        .rotationEffect(.degrees(90))
                                ////                                        .padding()
                                //                                        .tint(.clear)
                                
                                Text("\nNormal")
                                    .font(Font.custom(Texts.fontScene.rawValue, size: mainView.NormalFontSize))
                                    .foregroundStyle(.white)
                                ZStack{
                                    let h: CGFloat = 200
                                    let w: CGFloat = 25
                                    
                                    let x = ((200 * mainView.shipSpeed) / 50) - 4
                                    
                                    
                                    Rec(y: 0)
                                        .frame(width: w, height: h)
                                        .foregroundColor(.clear)
                                        .border(.white, width: 3)
                                    
                                    Rec(y: x)
                                        .frame(width: w * 0.87 , height: h * 0.98)
                                        .foregroundColor(.red)
                                }
                                Text("∞")
                                    .font(.system(size: 30))
                                    .foregroundStyle(.white)
                                
                                Spacer()
                                
                            }
                            
                            Spacer()
                            
                            VStack{
                                Text("Hora atual: \(Date().formatted(date: .omitted, time: .complete))").colorInvert()
                                Text("Hora da nave: ").colorInvert()
                                Text("Diferenca: \(mainView.date.formatted(date: .omitted, time: .complete))").colorInvert()
                                Spacer()
                            }
                            
                            Spacer()
                            
                            VStack{
                                ZStack{
                                    SpeedCounter(startAngle: .degrees(0), endAngle: .degrees(300), clockWise: false)
                                        .stroke(.gray, style: StrokeStyle(lineWidth: 10.5, lineCap: .round, lineJoin: .round))
                                        .frame(width: 100, height: 100)
                                    
                                    SpeedCounter(startAngle: .degrees(0), endAngle: .degrees(Double(mainView.calculateShowSpeed(speed: mainView.shipSpeed))), clockWise: false)
                                        .stroke(.linearGradient(colors: [/*Color(.color1), */Color(.color2), Color(.color3)], startPoint: .leading, endPoint: .trailing), style: StrokeStyle(lineWidth: 10.5, lineCap: .round, lineJoin: .round))
                                        .frame(width: 100, height: 100)
                                    
                                    VStack{
                                        Text("\(mainView.calculateRealSpeed(mainView.shipSpeed))")
                                            .font(Font.custom(Texts.fontScene.rawValue, size: mainView.NormalFontSize))
                                            .colorInvert()
                                    }
                                }
                                Text(Texts.upRight.rawValue)
                                
                                Spacer()
                                
                                //                                    Slider(value: $mainView.shipSpeed, in: 2.0...mainView.maxSpeed, step: 0.1)
                                //                                        .frame(width: 300)
                                //                                        .rotationEffect(.degrees(-90))
                                //                                        .padding()
                                
                                
                                if mainView.shipSpeed >= mainView.maxSpeed{
                                    Button {
                                        mainView.isLightSpeed.toggle()
                                    } label:{
                                        Text(Texts.lightSpeedButton.rawValue)
                                            .font(Font.custom(Texts.fontScene.rawValue, size: mainView.NormalFontSize))
                                    }
                                }else{
                                    Text(" ")
                                    
                                    
                                }
                                
                                
                                Spacer()
                            }
                        }
                    }.padding()
                    
                    VStack{
                        HStack{
                            Button(action: {
                                
                            }, label: {
                                Text("Frear")
                                    .font(Font.custom(Texts.fontScene.rawValue, size: mainView.NormalFontSize))
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
                            
                            
                            Button(action: {
                                
                            }, label: {
                                Text("Acelerar")
                                    .font(Font.custom(Texts.fontScene.rawValue, size: mainView.NormalFontSize))
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
                            
                        }
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
