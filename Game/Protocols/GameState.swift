//
//  GameState.swift
//  TextGame
//
//  Created by EVA RUSH on 08.07.2020.
//  Copyright © 2020 EVA RUSH. All rights reserved.
//

import Foundation

protocol GameState {
    func numberOf(scorePoints: Int)
    var newRecord: (()->())? {get set}
    var newRecordScane: (()->())? {get set}
}
