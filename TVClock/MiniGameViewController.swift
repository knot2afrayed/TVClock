//
//  MiniGameViewController.swift
//  TVClock
//
//  Created by Shawn Haynes on 1/27/17.
//  Copyright © 2017 Shawn Haynes. All rights reserved.
//


import UIKit
import SpriteKit
import GameplayKit

class MiniGameViewController: UIViewController {
    @IBOutlet var StartButton: UIButton!
    
    @IBOutlet var gameOver: UILabel!
    
    @IBOutlet var pMan: UIImageView!
    static var instance:MiniGameViewController?
    override func awakeFromNib() {
        type(of: self).instance = self
    }
    
    func parentFunction() {
        StartButton.isHidden = false
        if gameOver.isHidden == true {
            gameOver.isHidden = false
        }
        if pMan.isHidden == true {
            pMan.isHidden = false
        }
    }
    

    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
}
    
    @IBAction func PushStart(_ sender: Any) {
        if gameOver.isHidden == false {
            gameOver.isHidden = true
        }
        if pMan.isHidden == false {
            pMan.isHidden = true
        }
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFit
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            //  view.showsFPS = true
            //  view.showsNodeCount = true
           StartButton.isHidden = true
            var preferredFocusEnvironments : [UIFocusEnvironment]{
                return [view as UIView]
            }
            
        }
       
    }
    
}
