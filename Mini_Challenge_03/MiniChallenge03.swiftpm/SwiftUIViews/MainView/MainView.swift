import SwiftUI
import SpriteKit

struct MainView: View {
    @StateObject var mainView = MainViewMVVM()
   
    var body: some View {
        ZStack {
            //descomenta isso, só comentei pra fazer a lightSpeedScene mais rápido, sem ter que ir até a velocidade máxima pra mudar de cena
            
            /*if mainView.shipState != "Outside"{
                MainSceneBuilder
                    .font(mainView.customFont.getFont(size: mainView.NormalFontSize))
                       
            }
            else*/ if mainView.shipState == "Outside"{
                withAnimation {
                    LightsSpeedSceneView()
                }
                
            }
        }.background(.black)
        //tem que tirar esse onAppear tbm heh
            .onAppear {
                mainView.shipState = "Outside"
            }
         
            
    }
}
