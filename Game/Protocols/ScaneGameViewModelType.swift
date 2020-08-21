//
//  ScaneGameViewModelType.swift
//  TextGame
//
//  Created by EVA RUSH on 22.08.2020.
//  Copyright © 2020 EVA RUSH. All rights reserved.
//

import UIKit

protocol ScaneGameViewModelType {
    var gameIsStarted: Bool {get set}
    var gameIsOver: Bool {get set}
    var isSpawnWalls: Bool {get set}
    var scorePoints: Int {get set}
    var birdSize: CGSize {get}
    var topPetalEvaSize: CGSize {get}
    var petalEvaSize: CGSize {get}
    var isUpdateScane: Bool {get}
    var currentScorePoint: ((Int) -> ())? {get set}
    func startGame()
    func gameOver()
}
