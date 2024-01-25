//
//  File.swift
//  
//
//  Created by Jairo Júnior on 25/01/24.
//

import Foundation

enum SizesEnum {
    case jupiter
    case earth
    case defaultValue

    var size: CGSize {
        switch self {
        case .jupiter:
            return CGSize(width: 650, height: 650)
        case .earth:
            return CGSize(width: 200, height: 200)
            
        case .defaultValue:
            return CGSize(width: 500, height: 500)
        }
    }
}

