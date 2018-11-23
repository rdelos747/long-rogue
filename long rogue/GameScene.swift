//
//  GameScene.swift
//  long rogue
//
//  Created by rafael de los santos on 8/18/18.
//  Copyright © 2018 rafael de los santos. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    var level:Level?
    var btmHd:BottomHud?
    var topHd:SKSpriteNode?
    
    override func didMove(to view: SKView) {
        self.backgroundColor = hex(HUD_COLOR)
        self.level = Level(self)
        //self.btmHd = SKSpriteNode(texture:nil, color:UIColor.clear, size:CGSize(width: w, height: h))
//        self.btmHd = SKSpriteNode(color: hex("#ffffff"), size: CGSize(width: BTM_MARGIN, height: BTM_MARGIN))
//        self.btmHd?.alpha = 0.5
//        self.btmHd?.position = CGPoint(x:50, y:0)
//        self.btmHd?.anchorPoint = CGPoint(x:0, y:0)
//        self.addChild(self.btmHd!)
        self.btmHd = BottomHud(0, 0, self.size.width, BTM_MARGIN)
        self.addChild(self.btmHd!)
        
//        self.topHd = SKSpriteNode(color: hex("#ffffff"), size: CGSize(width: TOP_MARGIN, height: TOP_MARGIN))
//        self.topHd?.alpha = 0.5
//        self.topHd?.position = CGPoint(x:50, y:self.size.height - TOP_MARGIN)
//        self.topHd?.anchorPoint = CGPoint(x:0, y:0)
//        self.addChild(self.topHd!)
        self.topHd = TopHud(0, self.size.height - TOP_MARGIN, self.size.width, TOP_MARGIN)
        self.addChild(self.topHd!)
    }
    
//    func touchDown(atPoint pos : CGPoint) {
//        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
//            n.position = pos
//            n.strokeColor = SKColor.green
//            self.addChild(n)
//        }
//    }
//
//    func touchMoved(toPoint pos : CGPoint) {
//        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
//            n.position = pos
//            n.strokeColor = SKColor.blue
//            self.addChild(n)
//        }
//    }
//
//    func touchUp(atPoint pos : CGPoint) {
//
//    }
//
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            self.level?.touch(t.location(in: self))
        }
    }
//
//    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
//    }
//
//    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
//    }
//
//    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
//    }
//
//
    override func update(_ currentTime: TimeInterval) {
        self.level?.update()
    }
    
    func showMessage(_ text:String) {
        self.btmHd?.getText(text)
    }
}
