//
//  ScaneGame.swift
//  TextGame
//
//  Created by EVA RUSH on 02.07.2020.
//  Copyright © 2020 EVA RUSH. All rights reserved.
//

import SpriteKit

class ScaneGame: SKScene {
    
    var evaBird: EvaBirdNode!
    var wallPair: WallPairNode!
    
    var gameOverLabel: SKLabelNode!
    var pointsNodeLabel: SKLabelNode!

    var gameStatDelegate: GameState?
    var viewModel: ScaneGameViewModelType?
    
    override func didMove(to view: SKView) {
        viewModel = ScaneGameViewModel()
        physicsWorld.gravity = CGVector( dx: 0.0, dy: -2.7 )
        physicsWorld.contactDelegate = self
        initializateNode()
        viewModel?.currentScorePoint = { [weak self] score in
            self?.pointsNodeLabel.text = "\(score)"
        }
        
    }
    
    func initializateNode() {
        viewModel?.startGame()
        
        for i in 0..<2 {
            createBackground(index: CGFloat(i))
            floorBackground(index: CGFloat(i))
        }
        createEvaBirdNode()
        createPointsNode()
        
        let ground = SKNode()
        ground.position = CGPoint(x: 0, y: -self.size.height / 2.0)
        ground.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.frame.size.width, height: 30))
        ground.physicsBody?.isDynamic = false
        ground.physicsBody?.categoryBitMask = PhysicsCatagory.Ground
        ground.zPosition = 1
        self.addChild(ground)
    }
    
    func startSpawnWalls() {
        guard viewModel?.isSpawnWalls ?? false else {return}
        let spawn = SKAction.run(createWalls)
        let delay = SKAction.wait(forDuration: TimeInterval(2.0))
        let spawnThenDelay = SKAction.sequence([spawn, delay])
        let spawnThenDelayForever = SKAction.repeatForever(spawnThenDelay)
        self.run(spawnThenDelayForever)
        viewModel?.isSpawnWalls = false
    }
    
    func createBackground(index: CGFloat) {
        let background = SKSpriteNode(imageNamed: "background")
        background.zPosition = -5
        background.size = CGSize(width: self.frame.width, height: self.frame.height)
        background.position = CGPoint(x: index * self.frame.width, y: 0)
        background.name = "background"
        self.addChild(background)
    }
    
    func floorBackground(index: CGFloat) {
        let floor = SKSpriteNode(imageNamed: "floor")
        floor.zPosition = -3
        floor.size = CGSize(width: self.frame.width, height: 30)
        floor.position = CGPoint(x: index * self.frame.width, y: -self.size.height / 2.0 + 10)
        floor.name = "floor"
        self.addChild(floor)
    }
    
    func createWalls() {
        guard let viewModel = viewModel else {return}
        wallPair = WallPairNode(viewSize: self.size, birdSize: viewModel.birdSize, petalEva: viewModel.petalEvaSize)
        self.addChild(wallPair)
    }
    
    func createEvaBirdNode() {
        guard let viewModel = viewModel else {return}
        let birdSize = viewModel.birdSize
        let topPetalEvaSize = viewModel.topPetalEvaSize
        let petalEvaSize = viewModel.petalEvaSize
        evaBird = EvaBirdNode(birdSize: birdSize, topPetalEvaSize: topPetalEvaSize, petalEva: petalEvaSize)
        evaBird.position = CGPoint(x: -self.frame.width / 4, y: 0)
        self.addChild(evaBird)
    }
    
    func createPointsNode() {
        pointsNodeLabel = SKLabelNode(fontNamed: "Chalkduster")
        pointsNodeLabel.fontSize = 40
        pointsNodeLabel.fontColor = .orange
        pointsNodeLabel.text = "\(viewModel?.scorePoints ?? 0)"
        pointsNodeLabel.horizontalAlignmentMode = .center
        pointsNodeLabel.position = CGPoint(x: 0,  y: self.frame.height / 3)
        pointsNodeLabel.zPosition = 12
        viewModel?.scorePoints = 0
        addChild(pointsNodeLabel)
    }
    
    func createGameOverNode() {
        gameOverLabel = SKLabelNode(fontNamed: "Chalkduster")
        gameOverLabel.fontSize = 20
        gameOverLabel.fontColor = .gray
        gameOverLabel.text = "Game Over"
        gameOverLabel.horizontalAlignmentMode = .center
        gameOverLabel.position = CGPoint(x: 20, y: 0)
        gameOverLabel.zPosition = 30
        addChild(gameOverLabel)
    }
    
    func showFireworks() {
        addFireworks(color: .green, x: size.width / 4, y: size.height / 4)
        addFireworks(color: .green, x: -size.width / 4, y: size.height / 4)
        addFireworks(color: .orange, x: size.width / 4, y: -size.height / 4)
        addFireworks(color: .orange, x: -size.width / 4, y: -size.height / 4)
    }
    
    func addFireworks(color :UIColor, x: CGFloat, y: CGFloat) {
        let fier = SKEmitterNode(fileNamed: "sparck")!
        fier.zPosition = 21
        fier.particleColorSequence = nil
        fier.particleColorBlendFactor = 1
        fier.particleColor = color
        fier.position = CGPoint(x: x, y: y)
        addChild(fier)
    }
    
    func stopGame() {
        speed = 1
        viewModel?.gameOver()
        evaBird.offNodeDynamic()
        createGameOverNode()
        removeAllActions()
        gameStatDelegate?.numberOf(scorePoints: viewModel?.scorePoints ?? 0)
    }
    
    func restart() {
        self.removeAllChildren()
        self.removeAllActions()
        self.initializateNode()
    }
    
    func newRecordScane() {
        gameStatDelegate?.newRecordScane = { [weak self] in
            self?.showFireworks()
        }
    }
    
    override func update(_ currentTime: CFTimeInterval) {
        guard viewModel?.isUpdateScane ?? false else {return}
        enumerateChildNodes(withName: "*", using: ({
            (node, error) in
            
            if node.name == "floor" || node.name == "background" {
                let bg = node as! SKSpriteNode
                
                bg.position = CGPoint(x: bg.position.x - 1.7, y: bg.position.y)
                
                if bg.position.x <= -bg.size.width {
                    bg.position.x = bg.position.x + bg.size.width * 2
                }
            }
        }))
    }
}

extension ScaneGame: SKPhysicsContactDelegate {
    
    func didBegin(_ contact: SKPhysicsContact) {
        let firstBody = contact.bodyA
        let secondBody = contact.bodyB
        if firstBody.categoryBitMask == PhysicsCatagory.EvaBird &&
            secondBody.categoryBitMask == PhysicsCatagory.Wall || firstBody.categoryBitMask == PhysicsCatagory.Wall &&
            secondBody.categoryBitMask == PhysicsCatagory.EvaBird || firstBody.categoryBitMask == PhysicsCatagory.EvaBird &&
            secondBody.categoryBitMask == PhysicsCatagory.Ground || firstBody.categoryBitMask == PhysicsCatagory.Ground &&
            secondBody.categoryBitMask == PhysicsCatagory.EvaBird {
            
            enumerateChildNodes(withName: "wallPair", using: ({
                (node, error) in
                node.speed = 0
                self.stopGame()
            }))
        }
        
        if firstBody.node?.name == "Coin" {
            viewModel?.scorePoints += 1
            self.speed += 0.02
            firstBody.node?.removeFromParent()
        }
        
        if secondBody.node?.name == "Coin" {
            viewModel?.scorePoints += 1
            self.speed += 0.02
            secondBody.node?.removeFromParent()
        }
    }
}


