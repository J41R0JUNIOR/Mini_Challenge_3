import SwiftUI
import SpriteKit

struct MainView: View {
    @StateObject var mainView = MainViewMVVM()
   
    
    var body: some View {
        ZStack {
            if mainView.shipState != "Outside"{
                shipView
                       
            }else if mainView.shipState == "Outside"{
                ZStack{
                    CharacterView1()
                }
            }
        }.background(.black)
        
    }
}
