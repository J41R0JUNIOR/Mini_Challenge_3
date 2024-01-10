//
//  File.swift
//  
//
//  Created by Jairo Júnior on 09/01/24.
//

import SwiftUI

struct SpeedCounter : Shape{
    
    var startAngle: Angle
    var endAngle: Angle
    var clockWise: Bool
    
    func path(in rect: CGRect) -> Path {
        let rotationAdjustment = Angle.degrees(240)
        let modifiedStartAngle = startAngle - rotationAdjustment
        let modifiedEndAngle = endAngle - rotationAdjustment
        var path = Path()
        
        path.addArc(center: .init(x: rect.midX, y: rect.midY), radius: rect.width / 2, startAngle: modifiedStartAngle, endAngle: modifiedEndAngle, clockwise: clockWise)
        
        return path
    }
}
