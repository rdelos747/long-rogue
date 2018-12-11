//
//  log.swift
//  long rogue
//
//  Created by rafael de los santos on 12/3/18.
//  Copyright © 2018 rafael de los santos. All rights reserved.
//

import Foundation
import SpriteKit

class Log:SKSpriteNode {
    let outline:SKShapeNode
    let text0:SKLabelNode
    let text1:SKLabelNode
    let text2:SKLabelNode
    let title:SKLabelNode
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init( _ x:CGFloat, _ y:CGFloat, _ w:CGFloat, _ h:CGFloat) {
        let titleWidth:CGFloat = 40
        //let logLabelHeight = STATUS_LABEL_SIZE + 10
        let logLabelBottomMargin:CGFloat = 10
        let logLabelTopMargin:CGFloat = 10
        let logLabelHeight = (h - (logLabelBottomMargin + logLabelTopMargin)) / 3
        var outlinePoints = [
            CGPoint(x:5, y:h),
            CGPoint(x:0, y:h),
            CGPoint(x:0, y:0),
            CGPoint(x:w - 20, y:0),
            CGPoint(x:w - 20, y:h),
            CGPoint(x:5 + titleWidth, y:h)
        ]
        
        self.outline = SKShapeNode(points: &outlinePoints, count: outlinePoints.count)
        self.outline.fillColor = SKColor.clear
        self.outline.lineWidth = 2
        self.outline.strokeColor = hex(GRAY1)
        
        self.text0 = SKLabelNode(fontNamed: LABEL_FONT)
        self.text0.position = CGPoint(x:5, y:logLabelBottomMargin)
        self.text0.fontSize = STATUS_TITLE_SIZE
        self.text0.fontColor = hex(GRAY1)
        self.text0.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        self.text0.verticalAlignmentMode = SKLabelVerticalAlignmentMode.baseline
        self.text0.text = ""
        
        self.text1 = SKLabelNode(fontNamed: LABEL_FONT)
        self.text1.position = CGPoint(x:5, y:logLabelHeight + logLabelBottomMargin)
        self.text1.fontSize = STATUS_TITLE_SIZE
        self.text1.fontColor = hex(GRAY2)
        self.text1.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        self.text1.verticalAlignmentMode = SKLabelVerticalAlignmentMode.baseline
        self.text1.text = ""
        
        self.text2 = SKLabelNode(fontNamed: LABEL_FONT)
        self.text2.position = CGPoint(x:5, y:(logLabelHeight * 2) + logLabelBottomMargin)
        self.text2.fontSize = STATUS_TITLE_SIZE
        self.text2.fontColor = hex(GRAY3)
        self.text2.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        self.text2.verticalAlignmentMode = SKLabelVerticalAlignmentMode.baseline
        self.text2.text = ""
        
        self.title = SKLabelNode(fontNamed: LABEL_FONT)
        self.title.position = CGPoint(x:5 + (titleWidth / 2), y:h  - (STATUS_TITLE_SIZE / 2))
        self.title.fontSize = STATUS_TITLE_SIZE
        self.title.fontColor = hex(GRAY1)
        self.title.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        self.title.verticalAlignmentMode = SKLabelVerticalAlignmentMode.baseline
        self.title.text = "log"
        
        super.init(texture:nil, color:hex(HUD_COLOR), size:CGSize(width: w, height: h))
        self.anchorPoint = CGPoint(x:0, y:0)
        self.position = CGPoint(x:x, y:y)
        
        self.addChild(self.outline)
        self.addChild(self.text0)
        self.addChild(self.text1)
        self.addChild(self.text2)
        self.addChild(self.title)
    }
    
    func getText(_ text:String) {
        self.text2.text = self.text1.text
        self.text1.text = self.text0.text
        self.text0.text = text
    }
}
