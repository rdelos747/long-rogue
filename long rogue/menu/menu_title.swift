//
//  menu_title.swift
//  long rogue
//
//  Created by rafael de los santos on 12/10/18.
//  Copyright © 2018 rafael de los santos. All rights reserved.
//

import Foundation
import SpriteKit

class MenuTitle:SKSpriteNode {
    let outline:SKShapeNode
    let text:SKLabelNode
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(_ x:CGFloat, _ y:CGFloat, _ w:CGFloat, _ h:CGFloat) {
        var outlinePoints = [
            CGPoint(x:0, y:h),
            CGPoint(x:0, y:0),
            CGPoint(x:w, y:0),
            CGPoint(x:w, y:h),
            CGPoint(x:0, y:h)
        ]
        
        self.outline = SKShapeNode(points: &outlinePoints, count: outlinePoints.count)
        self.outline.fillColor = SKColor.clear
        self.outline.lineWidth = 3
        self.outline.strokeColor = hex(GRAY1)
        
        self.text = SKLabelNode(fontNamed: LABEL_FONT)
        self.text.position = CGPoint(x:w / 2, y:(h / 2))
        self.text.fontSize = LARGE_LABEL_SIZE
        self.text.fontColor = hex(GRAY1)
        self.text.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        self.text.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        self.text.text = "MENU"
        
        super.init(texture:nil, color:hex(HUD_COLOR), size:CGSize(width: w, height: h))
        self.anchorPoint = CGPoint(x:0, y:0)
        self.position = CGPoint(x:x, y:y)
        
        self.addChild(self.outline)
        self.addChild(self.text)
    }
}
