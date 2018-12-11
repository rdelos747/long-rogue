//
//  bag_title.swift
//  long rogue
//
//  Created by rafael de los santos on 12/10/18.
//  Copyright © 2018 rafael de los santos. All rights reserved.
//

import Foundation
import SpriteKit

class BagTitle:SKNode {
    let leftBar:SKShapeNode
    let rightBar:SKShapeNode
    let title:SKLabelNode
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(_ x:CGFloat, _ y:CGFloat, _ w:CGFloat, _ h:CGFloat) {
        let padding:CGFloat = 60
        var barPoints = [
            CGPoint(x:0, y:0),
            CGPoint(x:(w / 2) - padding, y:0)
        ]
        
        self.leftBar = SKShapeNode(points: &barPoints, count: barPoints.count)
        self.leftBar.fillColor = SKColor.clear
        self.leftBar.lineWidth = 3
        self.leftBar.strokeColor = hex(GRAY1)
        self.leftBar.position = CGPoint(x:0 - (w / 2), y:0)
        
        self.rightBar = SKShapeNode(points: &barPoints, count: barPoints.count)
        self.rightBar.fillColor = SKColor.clear
        self.rightBar.lineWidth = 3
        self.rightBar.strokeColor = hex(GRAY1)
        self.rightBar.position = CGPoint(x:padding, y:0)
        
        self.title = SKLabelNode(fontNamed: LABEL_FONT)
        self.title.position = CGPoint(x:0, y:0)
        self.title.fontSize = LARGE_LABEL_SIZE
        self.title.fontColor = hex(GRAY1)
        self.title.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        self.title.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        self.title.text = "bag"
        
        super.init()
        self.position = CGPoint(x:x, y:y)
        
        self.addChild(leftBar)
        self.addChild(rightBar)
        self.addChild(title)
    }
}
