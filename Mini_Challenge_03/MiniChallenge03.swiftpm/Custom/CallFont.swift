
import Foundation
import SwiftUI

//class Custom {
//    func getFont(size: CGFloat) -> Font {
//        let cfURL = Bundle.main.url( forResource: "NFPixels-Regular", withExtension: "ttf")! as CFURL
//        CTFontManagerRegisterFontsForURL(cfURL,CTFontManagerScope.process,nil)
//        let font = Font.custom("NFPixels-Regular", size: size)
//        return font
//    }
//}

struct CallFont {
    func getFont(size: CGFloat) -> Font? {
        if let cfURL = Bundle.main.url(forResource: "NFPixels-Regular", withExtension: "ttf") as CFURL?,
           CTFontManagerRegisterFontsForURL(cfURL, CTFontManagerScope.process, nil) {
            return Font.custom("NFPixels-Regular", size: size)
        } else {
            return nil
        }
    }
}

