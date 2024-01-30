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
    TextComponent(fontSize: 40, text: HudTexts.p1.rawValue, font: HudTexts.fontScene.rawValue)
}
