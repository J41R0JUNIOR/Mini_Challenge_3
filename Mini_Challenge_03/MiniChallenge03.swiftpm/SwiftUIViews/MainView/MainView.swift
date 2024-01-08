import SwiftUI
import SpriteKit

struct MainView: View {
    @StateObject var mainView = MainViewMVVM()
   
    var body: some View {
        ZStack {
            if mainView.shipState != "Outside"{
                shipView
                    .font(mainView.customFont.getFont(size: mainView.NormalFontSize))
                       
            }else if mainView.shipState == "Outside"{
                CharacterView1()
                
            }
        }.background(.black)
            
    }
}
