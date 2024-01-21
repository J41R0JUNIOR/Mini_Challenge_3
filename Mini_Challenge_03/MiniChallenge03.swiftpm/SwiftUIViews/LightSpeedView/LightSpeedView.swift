//
//  LightSpeedView.swift
//  MiniChallenge03
//
//  Created by Jairo Júnior on 17/01/24.
//

import SwiftUI

struct LightSpeedView: View {
    @StateObject var mainView: MainViewMVVM
    let text: [Texts] = [.p1,.e1,.p2,.e2]
    @State var index: Int = 0
    
    
    var body: some View {
        VStack{
            Spacer()
            HStack{
                
                let selectedText = text[index]
                withAnimation {
                    TextComponent(fontSize: Sizes.normal.rawValue, text: selectedText.rawValue, font: Texts.fontScene.rawValue).border(.white)
                }
                
                if selectedText.rawValue.contains("e"){
                    Image("einstein")
                }
                
            }.border(.red)
            
            Spacer()
            
            HStack{
                
                Spacer()
                
                Button(action: {
                    print("Calma calabreso")
                    if index < text.count - 1{
                        index += 1
                    }
                }, label: {
                    ZStack{
                        Circle()
                            .foregroundStyle(.white)
                            .frame(width: 100)
                        Text("next")
                    }
                })
            }.border(.red)
            
            
            
        }.border(.red)
        
    }
}
