//
//  GameScene.swift
//  NewGame
//
//  Created by 90303054 on 11/2/18.
//  Copyright © 2018 90303054. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    var touch: CGPoint? = nil
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    var dude = SKSpriteNode()
    var touching = false
    var tilemap : SKTileMapNode!
    override func didMove(to view: SKView) {
        dude = self.childNode(withName: "dude") as! SKSpriteNode
        tilemap = self.childNode(withName: "map") as! SKTileMapNode
    }
    
    func touchsetter(_ touches: Set<UITouch>){
        touch = touches.first?.location(in: self)
        updatePosition(for: dude, to: touch!, speed: 20.0)
        camera?.run(SKAction.move(to: dude.position, duration: 1.0))
    }
   
   
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchsetter(touches)
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchsetter(touches)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchsetter(touches)
    }
    
    
    
    
    func updatePosition(for sprite: SKSpriteNode,
                                    to target: CGPoint,
                                    speed: CGFloat) {
        let currentPosition = sprite.position
        let angle = CGFloat.pi + atan2(currentPosition.y - target.y,
                                       currentPosition.x - target.x)
        let rotateAction = SKAction.rotate(toAngle: angle + (CGFloat.pi*0.5),
                                           duration: 0)
        sprite.run(rotateAction)
        
        let velocityX = speed * cos(angle)
        let velocityY = speed * sin(angle)
        
        let newVelocity = CGVector(dx: velocityX, dy: velocityY)
        sprite.physicsBody?.velocity = newVelocity
        
    }

    
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
