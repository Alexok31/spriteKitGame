//
//  Random.swift
//  TextGame
//
//  Created by EVA RUSH on 07.07.2020.
//  Copyright © 2020 EVA RUSH. All rights reserved.
//

import UIKit

public extension CGFloat {
    
    static func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / Float(0xFFFFFFFF))
    }
    
    static func random(min: CGFloat, max: CGFloat) -> CGFloat {
        return CGFloat.random() * (max - min) + min
    }
}
