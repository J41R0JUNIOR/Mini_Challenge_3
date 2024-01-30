import Foundation

public enum HudTexts: String{
    //custom font
    case fontScene = "NFPixels-Regular"
    
    //strings mainView
    case inicialLabel = "This scene is designed to visually simulate exaggerated effects that would take place if we traveled near the speed of light, all for the purpose of entertainment."
    case lightSpeedButton = "LightSpeed"
    case upLeft = "Time Perception"
    case upRight = "Speed"
    
    //shipSpeed
    case up = "Gas"
    case down = "Break"
    
    //TimeScaleCounter
    case upTimeScale = "Normal"
    case downTimeScale = "∞"
    
    
    //objectsView
    case jupiter = "Light takes an average of 1.4s to go around Jupiter completely, this means that in one second it goes around the planet 0.6 times."
    case earth = "Light takes an average of 0.13s to go around the Earth completely, this means that in one second it goes around the planet 7 times."
    
    
    //chatsView
    
    case p1 = "pilot: What happend?"
    case e1 = "scientist: You've crossed the light speed"
    
    case p2 = "pilot: What does it mean?"
    case e2 = "scientist: That the play is about to begin"
}

enum HudTextSizes: CGFloat{
    case great = 40
    case normal = 20
    case small = 10
}
