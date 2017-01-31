//
//  GameScene.swift
//  Spiders Spiders
//
//  Created by Shawn Haynes on 1/17/17.
//  Copyright © 2017 Shawn Haynes. All rights reserved.
//

import SpriteKit
import GameplayKit

var gameEnding: Bool = false
struct PhysicsCategory {
    static let None      : UInt32 = 0
    static let All       : UInt32 = UInt32.max
    static let Monster   : UInt32 = 0b1       // 1
    static let Projectile: UInt32 = 0b10      // 2
    static let Player: UInt32 = 0b101
}
func + (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x + right.x, y: left.y + right.y)
}

func - (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x - right.x, y: left.y - right.y)
}

func * (point: CGPoint, scalar: CGFloat) -> CGPoint {
    return CGPoint(x: point.x * scalar, y: point.y * scalar)
}

func / (point: CGPoint, scalar: CGFloat) -> CGPoint {
    return CGPoint(x: point.x / scalar, y: point.y / scalar)
}

#if !(arch(x86_64) || arch(arm64))
    func sqrt(a: CGFloat) -> CGFloat {
        return CGFloat(sqrtf(Float(a)))
    }
#endif

extension CGPoint {
    func length() -> CGFloat {
        return sqrt(x*x + y*y)
    }
    
    func normalized() -> CGPoint {
        return self / length()
    }
}



class GameScene: SKScene, SKPhysicsContactDelegate {
    
    // try button
   
    private var spinnyNode : SKShapeNode?
    
    let player = SKSpriteNode(imageNamed: "pman0")
    var myAction = SKAction()
    var n : SKShapeNode?
    
    override func didMove(to view: SKView) {
       
        
        physicsWorld.gravity = CGVector.zero
        physicsWorld.contactDelegate = self
        
        player.position = CGPoint(x: size.width * 0.1, y: size.height * 0.2)
        player.xScale = -1.0
        player.physicsBody = SKPhysicsBody(rectangleOf: player.size)
        player.physicsBody?.isDynamic = true
        player.physicsBody?.categoryBitMask = PhysicsCategory.Player
        player.physicsBody?.contactTestBitMask = PhysicsCategory.Monster
        player.physicsBody?.collisionBitMask = PhysicsCategory.None
        player.physicsBody?.usesPreciseCollisionDetection = true
        
        
        // 4
        addChild(player)
        // Create shape node to use during mouse interaction
        let w = (self.size.width + self.size.height) * 0.04
        self.spinnyNode = SKShapeNode.init(rectOf: CGSize.init(width: w, height: w), cornerRadius: w * 0.3)
        
        if let spinnyNode = self.spinnyNode {
            spinnyNode.lineWidth = 2.5
            
            spinnyNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(M_PI), duration: 1)))
            spinnyNode.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
                                              SKAction.fadeOut(withDuration: 0.5),
                                              SKAction.removeFromParent()]))
        }
        myAction =    SKAction.repeatForever(SKAction.sequence([
            SKAction.run(addMonster),
            SKAction.wait(forDuration: 1.0)
            ]))
        run(myAction)
        
        
        //        run(SKAction.repeatForever(
        //            SKAction.sequence([
        //                SKAction.run(addMonster),
        //                SKAction.wait(forDuration: 1.0)
        //                ])
        //        ))
        
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        
        
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        //       if let n = self.spinnyNode?.copy() as! SKShapeNode? {
        //           n.position = pos
        //           n.strokeColor = SKColor.blue
        //           self.addChild(n)
        ////        }
    }
    
    func touchUp(atPoint pos : CGPoint) {
        /*  if let n = self.spinnyNode?.copy() as! SKShapeNode? {
         n.position = player.position
         n.strokeColor = SKColor.red
         let offset = pos - n.position
         if (offset.x > 0){return}
         self.addChild(n)
         let direction = offset.normalized()
         let shootAmount = direction * 1000
         let realDest = shootAmount + n.position
         let actionMove = SKAction.move(to: realDest, duration: 2.0)
         let actionMoveDone = SKAction.removeFromParent()
         n.run(SKAction.sequence([actionMove, actionMoveDone]))        } */
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //label action removed, deleted action.sks
        
        
        for t in touches { self.touchDown(atPoint: t.location(in: self))
            
            
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self))
            
            if gameEnding != true{
                if let n = self.spinnyNode?.copy() as! SKShapeNode? {
                    n.position.x = player.position.x + 36
                    n.position.y = player.position.y
                    n.strokeColor = SKColor.red
                    let offset = t.location(in: self) - n.position
                    //if (offset.x > 0){return}
                    let w = (self.size.width + self.size.height) * 0.04
                    n.physicsBody = SKPhysicsBody(circleOfRadius: w)
                    n.physicsBody?.isDynamic = true
                    n.physicsBody?.categoryBitMask = PhysicsCategory.Projectile
                    n.physicsBody?.contactTestBitMask = PhysicsCategory.Monster
                    n.physicsBody?.collisionBitMask = PhysicsCategory.None
                    n.physicsBody?.usesPreciseCollisionDetection = true
                    self.addChild(n)
                    let direction = offset.normalized()
                    let shootAmount = direction * 1500
                    let realDest = shootAmount + n.position
                    let actionMove = SKAction.move(to: realDest, duration: 2.0)
                    let actionMoveDone = SKAction.removeFromParent()
                    n.run(SKAction.sequence([actionMove, actionMoveDone]))
                }
            }}
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        
        
        for t in touches { self.touchUp(atPoint: t.location(in: self))
            
            
            //            if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            //                n.position = player.position
            //                n.strokeColor = SKColor.red
            //                let offset = t.location(in: self) - n.position
            //                if (offset.x > 0){return}
            //                self.addChild(n)
            //                let direction = offset.normalized()
            //                let shootAmount = direction * 1000
            //                let realDest = shootAmount + n.position
            //                let actionMove = SKAction.move(to: realDest, duration: 2.0)
            //                let actionMoveDone = SKAction.removeFromParent()
            //                n.run(SKAction.sequence([actionMove, actionMoveDone]))
            //            }
            
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        if gameEnding == true {
            self.enumerateChildNodes(withName:"*"){
                node, stop in
                if node.name == "Spider"{
                    node.removeFromParent()
                }
            }
        }
    }
    //    func checkTouch(location:CGPoint) {
    //
    //        self.enumerateChildNodes(withName: "*") {
    //            node, stop in
    //
    //            if node.name == "PlayAgain"{
    //
    //            }
    //
    //        }
    //    }
    
    
    
    
    
    func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    
    func random(min: CGFloat, max: CGFloat) -> CGFloat {
        return random() * (max - min) + min
    }
    
    func addMonster() {
        
        // Create sprite
        let monster = SKSpriteNode(imageNamed: "sprite_0")
        monster.name = "Spider"
        monster.physicsBody = SKPhysicsBody(rectangleOf: monster.size) // 1
        monster.physicsBody?.isDynamic = true // 2
        monster.physicsBody?.categoryBitMask = PhysicsCategory.Monster // 3
        monster.physicsBody?.contactTestBitMask = PhysicsCategory.Projectile// 4
        monster.physicsBody?.collisionBitMask = PhysicsCategory.None // 5        // Determine where to spawn the monster along the Y axis
        let actualY = random(min: monster.size.height/2, max: size.height - monster.size.height/2)
        
        // Position the monster slightly off-screen along the right edge,
        // and along a random position along the Y axis as calculated above
        monster.position = CGPoint(x: size.width + monster.size.width/2, y: actualY)
        
        // Add the monster to the scene
        addChild(monster)
        
        // Determine speed of the monster
        let actualDuration = random(min: CGFloat(2.0), max: CGFloat(4.0))
        
        // Create the actions
        let actionMove = SKAction.move(to: CGPoint(x: -monster.size.width/2, y: actualY), duration: TimeInterval(actualDuration))
        let actionMoveDone = SKAction.removeFromParent()
        monster.run(SKAction.sequence([actionMove, actionMoveDone]))
        
        
        
    }
    func projectileDidCollideWithMonster(projectile: SKShapeNode, monster: SKSpriteNode) {
        // print("Hit")
        projectile.removeFromParent()
        monster.removeFromParent()
        updateScore()
    }
    func monsterDidCollideWithPlayer(player: SKSpriteNode, monster: SKSpriteNode) {
        // print("player Hit")
        
        if let node = self.childNode(withName: "Health") as! SKLabelNode? {
            // Set up your sprite here
            let getHealth = node.text
            var healthInt: Int! = (getHealth as NSString?)?.integerValue
            healthInt = healthInt - 1
            if healthInt < 3 {
                
                node.fontColor = UIColor.red
            }
            if healthInt <= 0 {
                gameEnding = true
                MiniGameViewController.instance?.parentFunction()
                self.removeAllActions()
                self.removeAllChildren()
                gameEnding = false
//                if let gameOver = self.childNode(withName: "GameOver"){
//                    gameOver.isHidden = false
//                }
//                if let playAgain = self.childNode(withName: "PlayAgain"){
//                    playAgain.isHidden = false
//                }
                //let viewFromNib: UIView? = Bundle.main.loadNibNamed("gameOver",
                //                                                    owner: nil,
                //                                                  options: nil)?.first as! UIView?
                // let scene = viewFromNib
                // let transition = SKTransition.moveIn(with: SKTransitionDirection.right, duration: 1)
                // self.view?.addSubview(viewFromNib!)
                
            }
            node.text = "\(healthInt!)"
            
        }
        
        
        
    }
    
    
    func updateScore() {
        if let node = self.childNode(withName: "score") as! SKLabelNode? {
            // Set up your sprite here
            let getScore = node.text
            var scoreInt: Int! = (getScore as NSString?)?.integerValue
            scoreInt = scoreInt + 1
            node.text = "\(scoreInt!)"
        }
        
    }
    func didBegin(_ contact: SKPhysicsContact) {
        
        // 1
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        // 2
        if ((firstBody.categoryBitMask & PhysicsCategory.Monster != 0) &&
            (secondBody.categoryBitMask & PhysicsCategory.Projectile != 0)) {
            if let monster = firstBody.node as? SKSpriteNode, let
                n = secondBody.node as? SKShapeNode {
                projectileDidCollideWithMonster(projectile: n, monster: monster)
            }
        }
        if ((firstBody.categoryBitMask & PhysicsCategory.Monster != 0) &&
            (secondBody.categoryBitMask & PhysicsCategory.Player != 0)) {
            if let monster = firstBody.node as? SKSpriteNode, let
                n = secondBody.node as? SKSpriteNode {
                monsterDidCollideWithPlayer(player: n, monster: monster)
            }
        }
        
    }
}
