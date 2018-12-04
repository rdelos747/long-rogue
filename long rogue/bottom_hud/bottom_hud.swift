//
//  bottom_hud.swift
//  long rogue
//
//  Created by rafael de los santos on 10/3/18.
//  Copyright © 2018 rafael de los santos. All rights reserved.
//

import Foundation
import SpriteKit

let STATUS_LABEL_SIZE:CGFloat = 14
let STATUS_TITLE_SIZE:CGFloat = 12

class BottomHud: SKSpriteNode {
    let logBox:Log
    let hpBox:StatusBox
    let shBox:StatusBox
    let pwBox:StatusBox
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(_ x:CGFloat, _ y:CGFloat, _ w:CGFloat, _ h:CGFloat) {
        let statusBoxWidth:CGFloat = w / 4
        let statusBoxMargin:CGFloat = 10
        let statusBoxHeight:CGFloat = 40
        let statusBoxBottom:CGFloat = 20
        
        let logBoxOffset:CGFloat = 10
        let logBoxHeight:CGFloat = h - (statusBoxBottom + statusBoxHeight + (logBoxOffset * 2))
        print(h)
        
        self.logBox = Log(
            10,
            statusBoxBottom + statusBoxHeight + logBoxOffset,
            w,
            logBoxHeight
        )
        
        self.hpBox = StatusBox(
            "hp",
            RED,
            DARK_RED,
            statusBoxMargin,
            statusBoxBottom,
            statusBoxWidth,
            statusBoxHeight
        )
        self.shBox = StatusBox(
            "sh",
            GREEN,
            DARK_GREEN,
            (statusBoxMargin * 2) + statusBoxWidth,
            statusBoxBottom,
            statusBoxWidth,
            statusBoxHeight
        )
        self.pwBox = StatusBox(
            "pw",
            CYAN,
            DARK_CYAN,
            (statusBoxMargin * 3) + (statusBoxWidth * 2),
            statusBoxBottom,
            statusBoxWidth,
            statusBoxHeight
        )
        
        //init self
        super.init(texture:nil, color:hex(HUD_COLOR), size:CGSize(width: w, height: h))
        self.anchorPoint = CGPoint(x:0, y:0)
        self.position = CGPoint(x:x * w, y:y)
        
        self.addChild(self.logBox)
        self.addChild(self.hpBox)
        self.addChild(self.shBox)
        self.addChild(self.pwBox)
    }
    
    func getText(_ text:String) {
        self.logBox.getText(text)
    }
    
}

