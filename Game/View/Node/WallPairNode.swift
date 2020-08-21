//
//  WallPair.swift
//  TextGame
//
//  Created by EVA RUSH on 08.07.2020.
//  Copyright © 2020 EVA RUSH. All rights reserved.
//

import SpriteKit

class WallPairNode: SKNode {
    
    var movePipesAndRemove: SKAction!
    var viewSize: CGSize
    var birdSize: CGSize
    var petalEva: CGSize
    
    init(viewSize: CGSize, birdSize: CGSize, petalEva: CGSize) {
        self.viewSize = viewSize
        self.birdSize = birdSize
        self.petalEva = petalEva
        super.init()
        createWallsMovementActions()
        configure()
    }
    
    private func configure() {
        name = "wallPair"
        zPosition = -4
        addChild(topWall)
        addChild(bottomWall)
        addChild(scoreNode)
    }
    
    private func createWallsMovementActions() {
        let distanceToMove = CGFloat(2.0 * viewSize.width)
        let movePipes = SKAction.moveBy(x: -distanceToMove, y: 0.0, duration:TimeInterval(0.01 * distanceToMove))
        let removePipes = SKAction.removeFromParent()
        movePipesAndRemove = SKAction.sequence([movePipes, removePipes])
        randomPosition()
    }
    
    private func randomPosition() {
        let randomPosition = CGFloat.random(min: (-viewSize.height / 2) + viewSize.height / 3, max: (viewSize.height / 2) - viewSize.height / 3)
        position.y = position.y +  randomPosition
        run(movePipesAndRemove)
    }
    
    private var topWall: SKSpriteNode {
        let node = SKSpriteNode(imageNamed: "PipeUp")
        node.size = CGSize(width: 30, height: viewSize.height)
        node.position = CGPoint(x: viewSize.width / 2 + 30, y: node.frame.height / 2 + birdSize.height + petalEva.height * 2)
        node.physicsBody = SKPhysicsBody(rectangleOf: node.size)
        node.physicsBody?.categoryBitMask = PhysicsCatagory.Wall
        node.physicsBody?.collisionBitMask = PhysicsCatagory.EvaBird
        node.physicsBody?.contactTestBitMask = PhysicsCatagory.EvaBird
        node.physicsBody?.isDynamic = false
        node.physicsBody?.affectedByGravity = false
        return node
    }
    
    private var bottomWall: SKSpriteNode {
        let node = SKSpriteNode(imageNamed: "PipeDown")
        node.size = CGSize(width: 30, height: viewSize.height)
        node.position = CGPoint(x: viewSize.width / 2 + 30, y: -node.frame.height / 2 - birdSize.height - petalEva.height * 2)
        node.physicsBody = SKPhysicsBody(rectangleOf: node.size)
        node.physicsBody?.categoryBitMask = PhysicsCatagory.Wall
        node.physicsBody?.collisionBitMask = PhysicsCatagory.EvaBird
        node.physicsBody?.contactTestBitMask = PhysicsCatagory.EvaBird
        node.physicsBody?.isDynamic = false
        node.physicsBody?.affectedByGravity = false
        return node
    }
    
    var scoreNode: SKSpriteNode {
        let node = SKSpriteNode(imageNamed: "Coin")
        node.name = "Coin"
        node.size = CGSize(width: 20, height: 20)
        node.position = CGPoint(x: viewSize.width / 2 + 30, y: 0)
        node.physicsBody = SKPhysicsBody(rectangleOf: node.size)
        node.physicsBody?.affectedByGravity = false
        node.physicsBody?.isDynamic = false
        node.physicsBody?.categoryBitMask = PhysicsCatagory.Score
        node.physicsBody?.collisionBitMask = 0
        node.physicsBody?.contactTestBitMask = PhysicsCatagory.EvaBird
        node.color = SKColor.blue
        return node
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
