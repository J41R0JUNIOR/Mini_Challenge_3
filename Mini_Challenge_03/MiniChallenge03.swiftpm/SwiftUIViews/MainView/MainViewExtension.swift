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
            SpriteView(scene: mainView.backGroundScene)
                .ignoresSafeArea()
                .navigationBarBackButtonHidden()
            
            
            if !mainView.shipAppear{
                VStack{
                    Spacer()
                    
                    TextComponent(fontSize: HudTextSizes.great.rawValue, text: HudTexts.inicialLabel.rawValue, font: HudTexts.fontScene.rawValue).border(.white)
                    
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
                
                ShipSceneView(sceneSpeed: $mainView.shipSpeed, shipAppear: $mainView.shipAppear, shipState: $mainView.shipState, isLightSpeed: $mainView.isLightSpeed)
                
                if mainView.shipState == "Middle"{
                    
                    VStack{
                        HStack{
                            VStack{
                                Text(HudTexts.upLeft.rawValue)
                                    .font(Font.custom(HudTexts.fontScene.rawValue, size: HudTextSizes.normal.rawValue))
                                    .foregroundStyle(.white)
                                
                                Text("\n\(HudTexts.upTimeScale.rawValue)")
                                    .font(Font.custom(HudTexts.fontScene.rawValue, size: HudTextSizes.normal.rawValue))
                                    .foregroundStyle(.white)
                                ZStack{
                                    let h: CGFloat = 200
                                    let w: CGFloat = 25
                                    let x = ((200 * mainView.shipSpeed) / 50) - 4
                                    
                                    TimeScaleCounter(y: x - 4)
                                        .frame(width: w * 0.87 , height: h * 0.98)
                                        .foregroundColor(.red)
                                        .border(.white, width: 3)
                                }
                                Text(HudTexts.downTimeScale.rawValue)
                                    .font(.system(size: 30))
                                    .foregroundStyle(.white)
                                
                                Spacer()
                            }
                            
                            Spacer()
                            
                            VStack{
                                ZStack{
                                    let h: CGFloat = 100
                                    let w: CGFloat = 100
                                    
                                    SpeedCounter(startAngle: .degrees(0), endAngle: .degrees(300), clockWise: false)
                                        .stroke(.gray, style: StrokeStyle(lineWidth: 10.5, lineCap: .round, lineJoin: .round))
                                        .frame(width: w, height: h)
                                    
                                    SpeedCounter(startAngle: .degrees(0), endAngle: .degrees(Double(mainView.speedFormatted(speed: mainView.shipSpeed))), clockWise: false)
                                        .stroke(.linearGradient(colors: [Color(.color1), Color(.color2)], startPoint: .leading, endPoint: .trailing), style: StrokeStyle(lineWidth: 10.5, lineCap: .round, lineJoin: .round))
                                        .frame(width: w, height: h)
                                    
                                    VStack{
                                        Text("\(mainView.calculateRealSpeed(mainView.shipSpeed))")
                                            .font(Font.custom(HudTexts.fontScene.rawValue, size: HudTextSizes.normal.rawValue))
                                            .colorInvert()
                                    }
                                }
                                Text(HudTexts.upRight.rawValue)
                                
                                Spacer()
                                
                                if mainView.shipSpeed >= mainView.maxSpeed{
                                    Button {
                                        mainView.isLightSpeed.toggle()
                                    } label:{
                                        Text(HudTexts.lightSpeedButton.rawValue)
                                            .font(Font.custom(HudTexts.fontScene.rawValue, size: HudTextSizes.normal.rawValue))
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
                                Text(HudTexts.down.rawValue)
                                    .font(Font.custom(HudTexts.fontScene.rawValue, size: HudTextSizes.normal.rawValue))
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
                                Text(HudTexts.up.rawValue)
                                    .font(Font.custom(HudTexts.fontScene.rawValue, size: HudTextSizes.normal.rawValue))
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
                    VStack{
                        Spacer()
                        HStack{
                            if mainView.witchObject != "Anything"{
                                let text: [String: HudTexts] = ["earth": .earth, "jupiter": .jupiter]
                                
                                if let selectedText = text[mainView.witchObject]{
                                    withAnimation {
                                        TextComponent(fontSize: HudTextSizes.normal.rawValue, text: selectedText.rawValue, font: HudTexts.fontScene.rawValue).border(.white)
                                    }
                                }
                                Text(mainView.witchObject)
                            }
                        }
                    }
                }
            }
        }
    }
}
