import SwiftUI
import SpriteKit

struct MainView: View {
    @StateObject var mainView = MainViewMVVM()
   
    var body: some View {
        ZStack {
            if mainView.shipState != "Outside"{
                MainSceneBuilder
                    .font(mainView.customFont.getFont(size: mainView.NormalFontSize))
                       
            }else if mainView.shipState == "Outside"{
                LightsSpeedChatSceneView()
                
            }
        }.background(.black)
         
            
    }
}
