//
//  menu.swift
//  long rogue
//
//  Created by rafael de los santos on 12/9/18.
//  Copyright © 2018 rafael de los santos. All rights reserved.
//

import Foundation
import SpriteKit

class Menu:SKSpriteNode {
    let title:MenuTitle
    let status:PlayerStatus
    let bagTitle:BagTitle
    let bag:Bag
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(_ w:CGFloat, _ h:CGFloat) {
        let topPad:CGFloat = 50
        let sidePad:CGFloat = 20
        let titleHeight:CGFloat = 70
        let statusHeight:CGFloat = 100
        
        self.title = MenuTitle(
            sidePad,
            h - (topPad + titleHeight),
            w - (2 * sidePad),
            titleHeight
        )
        
        self.status = PlayerStatus(
            w/2,
            h - (topPad + titleHeight + (statusHeight / 2))
        )
        
        self.bagTitle = BagTitle(
            w/2,
            h - (topPad + (2 * titleHeight) + (statusHeight / 2)),
            w - (2 * sidePad),
            titleHeight
        )
        
        self.bag = Bag(w / 2, h - (topPad + (3 * titleHeight) + (statusHeight / 2)))
        
        super.init(texture:nil, color:hex(HUD_COLOR), size:CGSize(width: w, height: h))
        self.anchorPoint = CGPoint(x:0, y:0)
        self.position = CGPoint(x:0, y:0)
        self.alpha = 0.8
        self.isHidden = true
        
        self.addChild(self.title)
        self.addChild(self.status)
        self.addChild(self.bagTitle)
        self.addChild(self.bag)
    }
    
    func touch(_ location:CGPoint) {
        if let parent = self.parent as? GameScene {
            self.isHidden = true
            parent.closeMenu()
        }
    }
    
    func open() {
        self.isHidden = false
    }
}
