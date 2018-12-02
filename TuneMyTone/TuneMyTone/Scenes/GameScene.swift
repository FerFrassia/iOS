//
//  GameScene.swift
//  TuneMyTone
//
//  Created by Fernando N. Frassia on 11/27/18.
//  Copyright © 2018 Fernando N. Frassia. All rights reserved.
//

import SpriteKit
import GameplayKit

protocol GameSceneDelegate {
    func estimatedFrequency() -> Double?
}

class GameScene: SKScene {
    
    private var tuneBall: SKSpriteNode?
    private var scoreNode: ScoreNode!
    var tunerDelegate: GameSceneDelegate?
    
    lazy var gameStarted: Bool = {
        return false
    }()
    
    var ballPositions = [CGPoint]()
    
    var score = 0
    
    // MARK: - DidMove
    override func didMove(to view: SKView) {
        layoutScene()
    }
    
    // MARK: - Update
    override func update(_ currentTime: TimeInterval) {
        if gameStarted {
            moveTuneBall()
            drawTrail()
        }
    }
    
    // MARK: - DidSimulatePhysics
    override func didSimulatePhysics() {
        if let tuneBall = tuneBall {
            ballPositions.insert(tuneBall.position, at: 0)
            if ballPositions.count > 15 {ballPositions.removeLast()}
        }
    }
    
    // MARK: - Trail
    func createTrailPath() -> CGPath? {
        guard ballPositions.count >= 2 else {return nil}
        
        let trail = CGMutablePath()
        trail.move(to: ballPositions.first!)
        var deltaX = CGFloat(10)
        for position in ballPositions {
            trail.addLine(to: CGPoint(x: position.x-deltaX, y: position.y))
            deltaX += 10
        }
        
        return trail
    }
    
    func drawTrail() {
        removeTrail()
        
        if let trail = self.createTrailPath() {
            let shapeNode = SKShapeNode()
            shapeNode.path = trail
            shapeNode.name = "Trail"
            shapeNode.strokeColor = .red
            shapeNode.lineWidth = 1.5
            shapeNode.zPosition = 1
            
            self.addChild(shapeNode)
        }
    }
    
    func removeTrail() {
        enumerateChildNodes(withName: "Trail") { (node, stop) in
            node.removeFromParent()
        }
    }
    
    // MARK: - Start
    func startGame() {
        tuneBall?.isHidden = false
        gameStarted = true
        addTuneBlocks()
    }
    
    func stopGame() {
        tuneBall?.isHidden = true
        gameStarted = false
        removeTrail()
        addScore()
    }
    
    //MARK: - Score
    func addScore() {
        scoreNode = ScoreNode()
        scoreNode.position = CGPoint(x: 0, y: frame.size.height/2)
        scoreNode.score = score
        
        addChild(scoreNode)
        scoreNode.run(SKAction.moveTo(y: 0, duration: 5))
    }
    
    // MARK: - DidMove Aux
    func layoutScene() {
        backgroundColor = .black
        physicsWorld.contactDelegate = self
        ballPositions = [CGPoint]()
        tuneBall = self.childNode(withName: "//TuneBall") as? SKSpriteNode
        tuneBall?.isHidden = true
    }
    
    // MARK: - Update Aux
    func addTuneBlocks() {
        let blockTexture = SKTexture(imageNamed: "TuneBlock")
        for i in 0..<Scales.CMajor.count {
            let note = Scales.CMajor[i]
            guard let yPosition = note.position() else {return}
            
            let blockSprite = SKSpriteNode(texture: blockTexture)
            blockSprite.color = .white
            blockSprite.colorBlendFactor = 0.5
            blockSprite.anchorPoint = CGPoint(x: 0, y: 0.5)
            blockSprite.size = CGSize(width: 20, height: 20)
            let x = frame.width/2 + CGFloat(i)*blockTexture.size().width
            let y = CGFloat(yPosition)
            blockSprite.position = CGPoint(x: x, y: y)
            
            let blockPhysicsBody = SKPhysicsBody(rectangleOf: blockTexture.size())
            blockPhysicsBody.contactTestBitMask = 0x00000001
            blockPhysicsBody.allowsRotation = false
            blockPhysicsBody.friction = 0
            blockPhysicsBody.linearDamping = 0
            blockPhysicsBody.angularDamping = 0
            blockPhysicsBody.usesPreciseCollisionDetection = true
            blockSprite.physicsBody = blockPhysicsBody
            
            addChild(blockSprite)
            
            let distanceToMoveX = frame.width + frame.width/2 + CGFloat(i+1)*blockTexture.size().width
            let moveLeft = SKAction.moveBy(x: -distanceToMoveX, y: 0, duration: Double(distanceToMoveX/100))
            blockSprite.run(moveLeft)
        }
    }
    
    func moveTuneBall() {
        if let delegate = tunerDelegate {
            let estimatedFrequency = delegate.estimatedFrequency()
            let newY = estimatedFrequency != nil ? estimatedFrequency! - 100 : 0
            
            if let tuneBall = self.tuneBall {
                tuneBall.physicsBody?.usesPreciseCollisionDetection = true
                tuneBall.run(SKAction.moveTo(y: frame.midY + CGFloat(newY), duration: 0.4))
            }
        }
    }
    
}

extension GameScene: SKPhysicsContactDelegate {
    
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.node == tuneBall || contact.bodyB.node == tuneBall {
            let blockSprite = contact.bodyA.node == tuneBall ? contact.bodyB.node : contact.bodyA.node
            if let block = blockSprite as? SKSpriteNode {
                block.color = .green
                score += 1
            }
        }
    }
    
    func didEnd(_ contact: SKPhysicsContact) {
        if contact.bodyA.node == tuneBall || contact.bodyB.node == tuneBall {
            let blockSprite = contact.bodyA.node == self.tuneBall ? contact.bodyB.node : contact.bodyA.node
            if let block = blockSprite as? SKSpriteNode {
                block.color = .white
            }
        }
    }
}
