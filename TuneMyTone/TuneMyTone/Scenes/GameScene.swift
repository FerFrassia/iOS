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
    lazy var active: Bool = {
        return false
    }()
    
    // MARK: - didMove
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
    
    // MARK: - update
    override func update(_ currentTime: TimeInterval) {
        if active {
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
        active = true
    }
    
    func stopGame() {
        active = false
    }
    

    
}
