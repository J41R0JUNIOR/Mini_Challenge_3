//
//  LightSpeedView.swift
//  MiniChallenge03
//
//  Created by Jairo Júnior on 17/01/24.
//

import SwiftUI

struct LightSpeedView: View {
    @StateObject var mainView: MainViewMVVM
    @StateObject var lightSpeed : LightSpeedMVVM
    
    init(mainView: MainViewMVVM) {
            self._mainView = StateObject(wrappedValue: mainView)
            self._lightSpeed = StateObject(wrappedValue: LightSpeedMVVM(mainView: mainView))
        }
    
    var body: some View {
        VStack{
            Spacer()
            HStack{
                
                let selectedText = lightSpeed.text[lightSpeed.index]
                withAnimation {
                    TextComponent(fontSize: Sizes.normal.rawValue, text: selectedText.rawValue, font: Texts.fontScene.rawValue).border(.white)
                }
                
                if selectedText.rawValue.contains("scientist:"){
                    Image("einstein")
                }
            }
            Spacer()
            HStack{
                Spacer()
                Button(action: {
                    lightSpeed.button()
                }, label: {
                    ZStack{
                        Rectangle()
                            .frame(width: 100, height: 30)
                            .foregroundStyle(.clear)
                            .border(.white)
//                        Circle()
//                            .foregroundStyle(.white)
//                            .frame(width: 100)
                        Text("next")
                            .font(Font.custom(Texts.fontScene.rawValue, size: Sizes.normal.rawValue))
                            .foregroundStyle(.white)
                    }
                })
            }
        }
        
    }
}
