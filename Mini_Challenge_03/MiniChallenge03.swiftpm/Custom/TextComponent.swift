//
//  File.swift
//  
//
//  Created by Jairo Júnior on 16/01/24.
//

import Foundation
import SwiftUI

struct TextComponent: View{
    var fontSize: CGFloat
    var text: String
    var font: String
    
    var body: some View{
        ZStack{
            VStack{
               
                    //            Rectangle()
                    //                .foregroundStyle(.black)
                    //                .border(.white)
                    ////                .frame(maxWidth: 750, maxHeight: 350)
                    //                .padding()
                    
                    Text(text)
                        .font(Font.custom(font, size: fontSize))
                    //                            .font(.system(size: 40))
                    //                            .font(mainView.customFont.getFont(size: 40))
                        .multilineTextAlignment(.center)
                        .foregroundStyle(Color(.texts))
                    //                .frame(maxWidth: 700, maxHeight: 300)
                        .frame(maxWidth: 600)
                    
                
            }.padding()
        }.background(.black)
    }
}

#Preview {
    TextComponent(fontSize: 30, text: Texts.inicialLabel.rawValue, font: Texts.fontScene.rawValue)
}
