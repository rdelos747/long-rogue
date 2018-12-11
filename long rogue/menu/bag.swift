//
//  bag.swift
//  long rogue
//
//  Created by rafael de los santos on 12/10/18.
//  Copyright © 2018 rafael de los santos. All rights reserved.
//

import Foundation
import SpriteKit

class Bag:SKNode {
    let item:BagLabel
    let item2:BagLabel
    let item3:BagLabel
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(_ x:CGFloat, _ y:CGFloat) {
        self.item = BagLabel(0, 0)
        self.item2 = BagLabel(0, -30)
        self.item3 = BagLabel(0, -60)
        
        super.init()
        self.position = CGPoint(x:x, y:y)
        
        self.addChild(item)
        self.addChild(item2)
        self.addChild(item3)
        self.item2.updateVal()
        self.item3.updateVal2()
    }
}

class BagLabel:SKNode {
    let icon:SKLabelNode
    let title:SKLabelNode
    let lvl:SKLabelNode
    let midX:CGFloat
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(_ x:CGFloat, _ y:CGFloat) {
        self.midX = x
        
        self.icon = SKLabelNode(fontNamed: LABEL_FONT)
        self.icon.fontSize = STATUS_LABEL_SIZE
        self.icon.verticalAlignmentMode = SKLabelVerticalAlignmentMode.baseline
        self.icon.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        
        self.title = SKLabelNode(fontNamed: LABEL_FONT)
        self.title.fontSize = STATUS_LABEL_SIZE
        self.title.verticalAlignmentMode = SKLabelVerticalAlignmentMode.baseline
        self.title.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        
        self.lvl = SKLabelNode(fontNamed: LABEL_FONT)
        self.lvl.fontSize = STATUS_LABEL_SIZE
        self.lvl.verticalAlignmentMode = SKLabelVerticalAlignmentMode.baseline
        self.lvl.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        
        super.init()
        
        self.addChild(self.icon)
        self.addChild(self.title)
        self.addChild(self.lvl)
        
        self.position = CGPoint(x:self.midX, y:y)
        self.getEmptyVal()
    }
    
    func updateVal(/*_ item:Item */) {
        //do the text updates based on Item attributes
        //then
        self.icon.text = "/"
        self.icon.color = hex("ff0000")
        self.title.text = "item name"
        self.title.color = hex(WHITE)
        self.lvl.text = "<lvl 3>"
        self.lvl.color = hex(GRAY2)
        
        self.setWidth()
    }
    
    func updateVal2() {
        //TEST TEST TEST
        self.icon.text = "/"
        self.icon.fontColor = hex("ff0000")
        self.title.text = "item name"
        self.title.fontColor = hex(WHITE)
        self.lvl.text = ""
        self.lvl.fontColor = hex(GRAY2)
        
        self.setWidth()
    }
    
    func getEmptyVal() {
        self.icon.text = ""
        self.title.text = "-- empty slot --"
        self.title.fontColor = hex(GRAY2)
        self.lvl.text = ""
        
        self.setWidth()
    }
    
    func setWidth() {
        let padding:CGFloat = 5
        var iconPadding:CGFloat = 0
        var lvlPadding:CGFloat = 0
        if self.icon.text != "" {
            iconPadding = padding
        }
        if self.lvl.text != "" {
            lvlPadding = padding
        }
        self.icon.position = CGPoint(x:0, y:0)
        self.title.position = CGPoint(x: self.icon.frame.width + iconPadding, y:0)
        self.lvl.position = CGPoint(x:self.icon.frame.width + iconPadding + self.title.frame.width + lvlPadding, y:0)
        
        let totalWidth = self.icon.frame.width + iconPadding + self.title.frame.width + lvlPadding + self.lvl.frame.width
        self.position = CGPoint(x:self.midX - (totalWidth / 2), y:self.position.y)
    }
}
