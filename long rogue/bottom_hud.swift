//
//  bottom_hud.swift
//  long rogue
//
//  Created by rafael de los santos on 10/3/18.
//  Copyright © 2018 rafael de los santos. All rights reserved.
//

import Foundation
import SpriteKit

class BottomHud: SKSpriteNode {
    let topPad:CGFloat
    let bottomPad:CGFloat = 5
    let historyStart:CGFloat
    let historyLabelHeight:CGFloat
    
    let statusStartY:CGFloat
    let statusStartX:CGFloat
    let midColStartX:CGFloat
    let statusPad:CGFloat
    let statusLabelHeight:CGFloat
    let statusSectionWidth:CGFloat
    let statusSectionHeight:CGFloat
    
    let text1:SKLabelNode
    let text2:SKLabelNode
    let text3:SKLabelNode
    // player attributes
    let hp:SKLabelNode //health
    let pw:SKLabelNode //power (mana)
    let sh:SKLabelNode //shield (armor)
    let wep:SKLabelNode //equipped weapon
    // boxes
    let statusBox:SKShapeNode
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(_ x:CGFloat, _ y:CGFloat, _ w:CGFloat, _ h:CGFloat) {
        //status section
        self.statusLabelHeight = STATUS_LABEL_SIZE + 3
        self.statusSectionWidth = 100
        self.statusSectionHeight = self.statusLabelHeight * 3
        self.statusStartY = 20
        self.statusStartX = 10
        self.midColStartX = 120
        self.statusPad = 2
        
        self.statusBox = SKShapeNode(rectOf:CGSize(width:self.statusSectionWidth, height:self.statusSectionHeight))
        self.statusBox.position = CGPoint(x:self.statusStartX + (self.statusSectionWidth / 2), y:statusStartY + (self.statusSectionHeight / 2))
        self.statusBox.fillColor = SKColor.clear
        self.statusBox.lineWidth = 2
        self.statusBox.strokeColor = hex("ffffff")
        
        self.hp = SKLabelNode(fontNamed: LABEL_FONT)
        self.hp.position = CGPoint(x:self.statusStartX + self.statusPad, y:(self.statusStartY + self.statusPad) + (self.statusLabelHeight * 2))
        self.hp.fontSize = STATUS_LABEL_SIZE
        self.hp.fontColor = hex("ffffff")
        self.hp.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        self.hp.verticalAlignmentMode = SKLabelVerticalAlignmentMode.baseline
        self.hp.text = "hp:10/10"
        
        self.sh = SKLabelNode(fontNamed: LABEL_FONT)
        self.sh.position = CGPoint(x:self.statusStartX + self.statusPad, y:(self.statusStartY + self.statusPad) + self.statusLabelHeight)
        self.sh.fontSize = STATUS_LABEL_SIZE
        self.sh.fontColor = hex("ffffff")
        self.sh.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        self.sh.verticalAlignmentMode = SKLabelVerticalAlignmentMode.baseline
        self.sh.text = "sh:100/100"
        
        self.pw = SKLabelNode(fontNamed: LABEL_FONT)
        self.pw.position = CGPoint(x:self.statusStartX + self.statusPad, y:(self.statusStartY + self.statusPad))
        self.pw.fontSize = STATUS_LABEL_SIZE
        self.pw.fontColor = hex("ffffff")
        self.pw.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        self.pw.verticalAlignmentMode = SKLabelVerticalAlignmentMode.baseline
        self.pw.text = "pw:10/10"
        
        self.wep = SKLabelNode(fontNamed: LABEL_FONT)
        self.wep.position = CGPoint(x:self.midColStartX + self.statusPad, y:(self.statusStartY + self.statusPad) + (self.statusLabelHeight * 2))
        self.wep.fontSize = STATUS_LABEL_SIZE
        self.wep.fontColor = hex("ffffff")
        self.wep.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        self.wep.verticalAlignmentMode = SKLabelVerticalAlignmentMode.baseline
        self.wep.text = "wp:none equipped"
        
        //history section
        self.topPad = 5
        self.historyLabelHeight = HISTORY_LABEL_SIZE + 3
        self.historyStart = BTM_MARGIN - ((3 * self.historyLabelHeight) + topPad)
        
        self.text1 = SKLabelNode(fontNamed: LABEL_FONT)
        self.text1.position = CGPoint(x:10, y:historyStart)
        self.text1.fontSize = HISTORY_LABEL_SIZE
        self.text1.fontColor = hex("ffffff")
        self.text1.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        self.text1.verticalAlignmentMode = SKLabelVerticalAlignmentMode.baseline
        self.text1.text = ""
        
        self.text2 = SKLabelNode(fontNamed: LABEL_FONT)
        self.text2.position = CGPoint(x:10, y:historyStart + self.historyLabelHeight)
        self.text2.fontSize = HISTORY_LABEL_SIZE
        self.text2.fontColor = hex("ffffff")
        self.text2.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        self.text2.verticalAlignmentMode = SKLabelVerticalAlignmentMode.baseline
        self.text2.text = ""
        
        self.text3 = SKLabelNode(fontNamed: LABEL_FONT)
        self.text3.position = CGPoint(x:10, y:historyStart + (self.historyLabelHeight * 2))
        self.text3.fontSize = HISTORY_LABEL_SIZE
        self.text3.fontColor = hex("ffffff")
        self.text3.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        self.text3.verticalAlignmentMode = SKLabelVerticalAlignmentMode.baseline
        self.text3.text = ""
        
        //init self
        super.init(texture:nil, color:hex(HUD_COLOR), size:CGSize(width: w, height: h))
        self.anchorPoint = CGPoint(x:0, y:0)
        self.position = CGPoint(x:x * w, y:y)
        
        self.addChild(self.statusBox)
        self.addChild(self.hp)
        self.addChild(self.sh)
        self.addChild(self.pw)
        self.addChild(self.wep)
        self.addChild(self.text1)
        self.addChild(self.text2)
        self.addChild(self.text3)
    }
    
    func getText(_ text:String) {
        self.text3.text = self.text2.text
        self.text2.text = self.text1.text
        self.text1.text = text
    }
    
}
