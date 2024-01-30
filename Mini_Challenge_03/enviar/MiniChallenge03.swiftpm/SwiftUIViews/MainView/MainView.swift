import SwiftUI
import SpriteKit

struct MainView: View {
    @StateObject var mainView = MainViewMVVM()
   
    var body: some View {
        ZStack {
            Rectangle().foregroundStyle(.black)
            if mainView.shipState != "Outside"{
                VStack{
                    Spacer()
                    MainSceneBuilder
                        .font(mainView.customFont.getFont(size: HudTextSizes.normal.rawValue))
                }
            }
            else if mainView.shipState == "Outside"{
                withAnimation {
                    LightsSpeedSceneView()
                }
                LightSpeedView(mainView: mainView)
            }
        }.background(.black)
    }
}
