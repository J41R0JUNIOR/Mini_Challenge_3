//
//  File.swift
//  
//
//  Created by Jairo Júnior on 14/01/24.
//

import Foundation

public enum Texts: String{
    //custom font
    case fontScene = "NFPixels-Regular"
    
    //strings mainView
    case inicialLabel = "Essa cena tem o objetivo de simular visualmente alguns efeitos que ocorreriam caso viajássemos próximos a velocidade da luz."
    case lightSpeedButton = "LightSpeed"
    case upLeft = "Time Perception"
    case upRight = "Speed"
    
    //shipSpeed
    case up = "Gas"
    case down = "Break"
    
    //objects
    case jupiter = "A luz demora em média 0,4s para dar a volta completa em Júpiter, isso significa que em um segundo ela dá duas voltas em torno do planeta."
    case earth = "A luz demora em média 0,04s para dar a volta completa na Terra, isso significa que em um segundo ela dá 23 voltas em torno do planeta."
    
    
    //chats
    case p1 = "pilot: What happend?"
    case e1 = "scientist: You've crossed the light speed"
    
    case p2 = "pilot: What does it mean?"
    case e2 = "scientist: That the play is about to begin"
}

enum Sizes: CGFloat{
    case great = 40
    case normal = 20
    case small = 10
}
