//
//  ScaneGameViewModel.swift
//  TextGame
//
//  Created by EVA RUSH on 09.07.2020.
//  Copyright © 2020 EVA RUSH. All rights reserved.
//

import UIKit


class ScaneGameViewModel: ScaneGameViewModelType {
    
    private var gameModel = ModelGame()
    
    var gameIsStarted = false
    var gameIsOver = false
    var isSpawnWalls = false
    var scorePoints = 0 {
        didSet {
            currentScorePoint?(scorePoints)
        }
    }
    var currentScorePoint: ((Int) -> ())?
    
    var isUpdateScane: Bool {
        return gameIsStarted && !gameIsOver
    }
    
    var birdSize: CGSize {
        return gameModel.birdSize
    }
    
    var topPetalEvaSize: CGSize {
        return gameModel.topPetalEvaSize
    }
    
    var petalEvaSize: CGSize {
        return gameModel.petalEva
    }
    
    func startGame() {
        gameIsOver = false
        gameIsStarted = true
        isSpawnWalls = true
    }
    
    func gameOver() {
        gameIsOver = true
        gameIsStarted = false
        isSpawnWalls = false
    }
}
    
