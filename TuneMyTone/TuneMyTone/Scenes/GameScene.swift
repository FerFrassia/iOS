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
    
    var tuneBall: SKSpriteNode!
    var tunerDelegate: GameSceneDelegate?
    lazy var gameStarted: Bool = {
        return false
    }()
    
    // MARK: - DidMove
    override func didMove(to view: SKView) {
        layoutScene()
        addSprites()
    }
    
    func layoutScene() {
        backgroundColor = .black
    }
    
    func addSprites() {
        addTuneBall()
    }
    
    func addTuneBall() {
        tuneBall = SKSpriteNode(imageNamed: "TuneBall")
        tuneBall.size = CGSize(width: 30, height: 30)
        tuneBall.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(tuneBall)
    }
    
    func addTuneBlocks() {
        let blockTexture = SKTexture(imageNamed: "TuneBlock")
        for i in 0..<Scales.CMajor.count {
            let note = Scales.CMajor[i]
            guard let yPosition = note.position() else {return}
            
            let blockSprite = SKSpriteNode(texture: blockTexture)
            blockSprite.anchorPoint = CGPoint(x: 0, y: 0.5)
            blockSprite.size = CGSize(width: 20, height: 20)
            blockSprite.position = CGPoint(x: frame.width + CGFloat(i)*blockTexture.size().width,
                                           y: CGFloat(yPosition))
            addChild(blockSprite)
            
            let distanceToMoveX = frame.width + CGFloat(i+1)*blockTexture.size().width
            let moveLeft = SKAction.moveBy(x: -distanceToMoveX, y: 0, duration: Double(distanceToMoveX/100))
            blockSprite.run(moveLeft)
        }
    }
    
    // MARK: - Update
    override func update(_ currentTime: TimeInterval) {
        if gameStarted {
            moveTuneBall()
        }
    }
    
    func moveTuneBall() {
        if let delegate = tunerDelegate {
            let estimatedFrequency = delegate.estimatedFrequency()
            let newY = estimatedFrequency != nil ? estimatedFrequency! - 100 : 0
            print("newY: \(newY)")
            tuneBall.run(SKAction.moveTo(y: frame.midY + CGFloat(newY), duration: 0.4))
        }
    }
    
    // MARK: - Start
    func startGame() {
        gameStarted = true
        addTuneBlocks()
    }
    
    func stopGame() {
        gameStarted = false
    }
    

    
}
