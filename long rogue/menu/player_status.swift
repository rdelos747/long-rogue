//
//  player_status.swift
//  long rogue
//
//  Created by rafael de los santos on 12/10/18.
//  Copyright © 2018 rafael de los santos. All rights reserved.
//

import Foundation
import SpriteKit

class PlayerStatus:SKNode {
    let player:SKLabelNode
    let hp:StatusLabel
    let sh:StatusLabel
    let pw:StatusLabel
    let sl:StatusLabel
    let ag:StatusLabel
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(_ x:CGFloat, _ y:CGFloat) {
        let padding:CGFloat = 30
        let leftSpacing:CGFloat = 20
        let rightSpacing:CGFloat = 10
        
        self.player = SKLabelNode(fontNamed: LABEL_FONT)
        self.player.position = CGPoint(x:0, y:(0))
        self.player.fontSize = LARGE_LABEL_SIZE
        self.player.fontColor = hex(PLAYER_COLOR)
        self.player.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        self.player.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        self.player.text = "@"
        
        self.hp = StatusLabel(0 - padding, leftSpacing, "right", RED, "100")
        self.sh = StatusLabel(0 - padding, 0, "right", GREEN, "100")
        self.pw = StatusLabel(0 - padding, 0 - leftSpacing, "right", CYAN, "100")
        self.sl = StatusLabel(padding, rightSpacing, "left", PURPLE, "099")
        self.ag = StatusLabel(padding, 0 - rightSpacing, "left", ORANGE, "099")
        
        self.hp.updateVal(10)
        self.sh.updateVal(10)
        self.pw.updateVal(10)
        self.sl.updateVal(10)
        self.ag.updateVal(10)
        
        super.init()
        self.position = CGPoint(x:x, y:y)
        self.addChild(self.player)
        self.addChild(self.hp)
        self.addChild(self.sh)
        self.addChild(self.pw)
        self.addChild(self.sl)
        self.addChild(self.ag)
    }
}

class StatusLabel:SKNode {
    let value:SKLabelNode
    let type:SKLabelNode
    let align:String
    let maxValue:String
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(_ x:CGFloat, _ y: CGFloat, _ align:String, _ typeColor:String, _ maxValue:String) {
        let padding:CGFloat = 5
        self.value = SKLabelNode(fontNamed: LABEL_FONT)
        self.value.fontSize = STATUS_LABEL_SIZE
        self.value.fontColor = hex(GRAY1)
        self.value.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        
        self.type = SKLabelNode(fontNamed: LABEL_FONT)
        self.type.fontSize = STATUS_LABEL_SIZE
        self.type.fontColor = hex(typeColor)
        self.type.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        
        self.value.text = "000/000:"
        self.type.text = "hp"
        self.align = align
        self.maxValue = maxValue
        if align == "right" {
            self.value.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.right
            self.type.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.right
            self.type.position = CGPoint(x:0, y:0)
            self.value.position = CGPoint(x:0 - (self.type.frame.width + padding), y:0)
        }
        else if align == "left" {
            self.value.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
            self.type.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
            self.type.position = CGPoint(x:0, y:0)
            self.value.position = CGPoint(x:self.type.frame.width + padding, y:0)
        }
        
        super.init()
        self.position = CGPoint(x:x, y:y)
        
        self.addChild(self.value)
        self.addChild(self.type)
    }
    
    func updateVal(_ val:Int) {
        var sVal = String(val)
        if sVal.count < 3 {
            sVal = "0" + sVal
        }
        
        if self.align == "right" {
            self.value.text = sVal + "/" + maxValue + ":"
        }
        else if self.align == "left" {
            self.value.text = ":" + sVal + "/" + maxValue
        }
    }
}
