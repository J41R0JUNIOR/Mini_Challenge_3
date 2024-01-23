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
                    Text(text)
                        .font(Font.custom(font, size: fontSize))
                        .multilineTextAlignment(.center)
                        .foregroundStyle(Color(.texts))
//                        .frame(maxWidth: 600)
                
            }.padding()
        }.background(.black)
            .frame(maxWidth: 600)
    }
}

#Preview {
    TextComponent(fontSize: 40, text: Texts.p1.rawValue, font: Texts.fontScene.rawValue)
}
