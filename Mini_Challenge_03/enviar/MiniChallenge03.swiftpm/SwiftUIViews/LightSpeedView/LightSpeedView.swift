import SwiftUI

struct LightSpeedView: View {
    @StateObject var mainView: MainViewMVVM
    @StateObject var lightSpeed : LightSpeedMVVM
    
    init(mainView: MainViewMVVM) {
            self._mainView = StateObject(wrappedValue: mainView)
            self._lightSpeed = StateObject(wrappedValue: LightSpeedMVVM(mainView: mainView))
        }
    
    var body: some View {
        VStack{
            Spacer()
            HStack{
                
                let selectedText = lightSpeed.text[lightSpeed.index]
                withAnimation {
                    TextComponent(fontSize: HudTextSizes.normal.rawValue, text: selectedText.rawValue, font: HudTexts.fontScene.rawValue).border(.white)
                }
                
                if selectedText.rawValue.contains("scientist:"){
                    Image(ObjectsEnum.scientist.rawValue)
                }
            }
            Spacer()
            HStack{
                Spacer()
                Button(action: {
                    lightSpeed.button()
                }, label: {
                    ZStack{
                        Rectangle()
                            .frame(width: 100, height: 30)
                            .foregroundStyle(.clear)
                            .border(.white)
                        Text("next")
                            .font(Font.custom(HudTexts.fontScene.rawValue, size: HudTextSizes.normal.rawValue))
                            .foregroundStyle(.white)
                    }
                })
            }
        }
        
    }
}
