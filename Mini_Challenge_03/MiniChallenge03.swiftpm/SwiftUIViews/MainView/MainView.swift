import SwiftUI
import SpriteKit

struct MainView: View {
    @StateObject var mainView = MainViewMVVM()
   
    var body: some View {
        ZStack {

            /*if mainView.shipState != "Outside"{
                VStack{
                    Spacer()
                    MainSceneBuilder
                        .font(mainView.customFont.getFont(size: mainView.NormalFontSize))
                }
            }
            else*/ if mainView.shipState == "Outside"{
                withAnimation {
                    LightsSpeedSceneView()
                }
            }
        }.background(.black)
        .onAppear {
            mainView.shipState = "Outside"
        }
    }
}
