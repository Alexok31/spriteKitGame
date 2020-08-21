//
//  EvaBirdNode.swift
//  TextGame
//
//  Created by EVA RUSH on 08.07.2020.
//  Copyright © 2020 EVA RUSH. All rights reserved.
//

import SpriteKit

class EvaBirdNode: SKNode {
    
    var evaLogo: SKSpriteNode!
    var topPetalEva: SKSpriteNode!
    
    
    private var angle: CGFloat = 0
    var birdSize: CGSize
    var topPetalEvaSize: CGSize
    var petalEvaSize: CGSize
    
    init(birdSize: CGSize, topPetalEvaSize: CGSize, petalEva: CGSize) {
        self.birdSize = birdSize
        self.topPetalEvaSize = topPetalEvaSize
        self.petalEvaSize = petalEva
        super.init()
        configure()
    }
    
    private func configure() {
        
        createEvaLogo()
        createPetalEva()
        
        self.addChild(topPetalEva)
        self.addChild(evaLogo)
    }
    
    var fier: SKEmitterNode {
        let node = SKEmitterNode(fileNamed: "Fier")!
        node.zPosition = -1
        node.position = CGPoint(x: 0, y: 0)
        return node
    }
    
    private func createEvaLogo() {
        evaLogo = SKSpriteNode(imageNamed: "evaBird")
        evaLogo.size = birdSize
        evaLogo.position = CGPoint(x: 0, y: 0)
        evaLogo.physicsBody = SKPhysicsBody(circleOfRadius: evaLogo.frame.height / 2)
        evaLogo.physicsBody?.categoryBitMask = PhysicsCatagory.EvaBird
        evaLogo.physicsBody?.collisionBitMask = PhysicsCatagory.Ground | PhysicsCatagory.Wall
        evaLogo.physicsBody?.contactTestBitMask = PhysicsCatagory.Ground | PhysicsCatagory.Wall | PhysicsCatagory.Score
        evaLogo.physicsBody?.affectedByGravity = false
        evaLogo.physicsBody?.isDynamic = true
        evaLogo.physicsBody?.allowsRotation =  false
        evaLogo.zPosition = 2
        evaLogo.physicsBody?.mass = 0.05
        evaLogo.addChild(fier)
    }
    
    private func createPetalEva() {
        topPetalEva = SKSpriteNode()
        topPetalEva.name = "topPetalEva"
        topPetalEva.color = .clear
        topPetalEva.size = topPetalEvaSize
        topPetalEva.position = CGPoint(x: -self.frame.width / 4, y: 0)
        topPetalEva.zPosition = 2
        
        let petalEva = SKSpriteNode(imageNamed: "evaPetal")
        petalEva.size = petalEvaSize
        petalEva.position = CGPoint(x: 3, y: topPetalEva.size.height / 2 + petalEva.size.height / 2 + 3)
        petalEva.zPosition = 2
        
        topPetalEva.physicsBody = SKPhysicsBody(rectangleOf: petalEva.size, center: petalEva.position)
        topPetalEva.physicsBody?.categoryBitMask = PhysicsCatagory.EvaBird
        topPetalEva.physicsBody?.collisionBitMask = PhysicsCatagory.Ground | PhysicsCatagory.Wall
        topPetalEva.physicsBody?.contactTestBitMask = PhysicsCatagory.Ground | PhysicsCatagory.Wall | PhysicsCatagory.Score
        topPetalEva.physicsBody?.affectedByGravity = false
        topPetalEva.physicsBody?.isDynamic = true
        topPetalEva.physicsBody?.mass = 0.05
        topPetalEva.addChild(petalEva)
    }
    
    func pushUpNode() {
        evaLogo?.physicsBody?.affectedByGravity = true
        evaLogo?.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        evaLogo?.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 10))
        
        topPetalEva?.physicsBody?.affectedByGravity = true
        topPetalEva?.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        topPetalEva?.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 10))
        rotateTopPetalEva()
    }
    
    private func rotateTopPetalEva() {
        angle += -.pi * 2
        let rotateAction = SKAction.rotate(toAngle: angle, duration: 0.5)
        topPetalEva?.run(rotateAction, completion: {
            self.angle += .pi * 2
        })
    }
    
    func offNodeDynamic() {
        evaLogo.physicsBody?.isDynamic = false
        evaLogo.physicsBody?.pinned = true
        topPetalEva.physicsBody?.isDynamic = false
        topPetalEva.physicsBody?.pinned = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
