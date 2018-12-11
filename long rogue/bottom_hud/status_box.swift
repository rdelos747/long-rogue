//
//  status_box.swift
//  long rogue
//
//  Created by rafael de los santos on 12/3/18.
//  Copyright © 2018 rafael de los santos. All rights reserved.
//

import Foundation
import SpriteKit

class StatusBox:SKSpriteNode {
    let outline:SKShapeNode
    let text:SKLabelNode
    let title:SKLabelNode
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(_ t: String, _ c1:String, _ c2:String, _ x:CGFloat, _ y:CGFloat, _ w:CGFloat, _ h:CGFloat) {
        let titleWidth:CGFloat = 40
        var outlinePoints = [
            CGPoint(x:5, y:h),
            CGPoint(x:0, y:h),
            CGPoint(x:0, y:0),
            CGPoint(x:w, y:0),
            CGPoint(x:w, y:h),
            CGPoint(x:5 + titleWidth, y:h)
        ]
        
        self.outline = SKShapeNode(points: &outlinePoints, count: outlinePoints.count)
        self.outline.fillColor = SKColor.clear
        self.outline.lineWidth = 2
        self.outline.strokeColor = hex(GRAY1)
        
        self.text = SKLabelNode(fontNamed: LABEL_FONT)
        self.text.position = CGPoint(x:w / 2, y:(h / 2) - (STATUS_LABEL_SIZE / 2))
        self.text.fontSize = STATUS_LABEL_SIZE
        self.text.fontColor = hex(c1)
        self.text.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        self.text.verticalAlignmentMode = SKLabelVerticalAlignmentMode.baseline
        self.text.text = "100/100"
        
        self.title = SKLabelNode(fontNamed: LABEL_FONT)
        self.title.position = CGPoint(x:5 + (titleWidth / 2), y:h  - (STATUS_TITLE_SIZE / 2))
        self.title.fontSize = STATUS_TITLE_SIZE
        self.title.fontColor = hex(c2)
        self.title.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        self.title.verticalAlignmentMode = SKLabelVerticalAlignmentMode.baseline
        self.title.text = t
        
        super.init(texture:nil, color:hex(HUD_COLOR), size:CGSize(width: w, height: h))
        self.anchorPoint = CGPoint(x:0, y:0)
        self.position = CGPoint(x:x, y:y)
        
        self.addChild(self.outline)
        self.addChild(self.text)
        self.addChild(self.title)
    }
}
