//
//  tile.swift
//  long rogue
//
//  Created by rafael de los santos on 8/18/18.
//  Copyright © 2018 rafael de los santos. All rights reserved.
//

import Foundation
import SpriteKit

class Tile: SKSpriteNode {
    var label:SKLabelNode
    var type:CODES
    var labelSaveColor:String
    //var backgroundColor:String
    var movable:Bool
    var tileWidth:CGFloat
    var tileHeight:CGFloat
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(_ j:Int, _ i:Int, _ w:CGFloat, _ h:CGFloat, _ isHidden:Bool) {
        self.type = CODES.none
        self.label = SKLabelNode(fontNamed: LABEL_FONT)
        self.labelSaveColor = ""
        //self.backgroundColor = "" //might not need this
        self.tileWidth = w
        self.tileHeight = h
        self.movable = false
        
        super.init(texture:nil, color:UIColor.clear, size:CGSize(width: w, height: h))
        self.anchorPoint = CGPoint(x:0, y:0)
        self.position = CGPoint(x:CGFloat(i) * w, y:(CGFloat(j) * h) + BTM_MARGIN)
        
        self.label.text = " "
        self.label.fontSize = TILE_LABEL_SIZE
        self.label.fontColor = hex("#000000")
        self.label.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        self.label.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        self.label.position = CGPoint(x: w / 2, y: h / 2)
        self.addChild(self.label)
        
        if (isHidden) {
           self.label.isHidden = true
            self.isHidden = true
        }
    }
    
    func updateType(_ newType:CODES) {
        self.type = newType
        self.label.text = TYPES[newType]?["icon"] as? String
        
        let colors = TYPES[newType]?["color"] as? [String]
        let colorToSave = colors![rand(0, (colors?.count)!)]
        self.label.fontColor = hex(colorToSave)
        self.labelSaveColor = colorToSave // save the color for when object moves off
        
        let bkColors = TYPES[newType]?["background"] as? [String]
        self.color = hex(bkColors![rand(0, (bkColors?.count)!)])
        
        self.movable = (TYPES[newType]?["movable"] as? Bool)!
    }
    
    func scrollUp() {
        self.position.y -= self.tileHeight
        self.toggleShow()
    }
    
    func scrollDown() {
       self.position.y += self.tileHeight
        self.toggleShow()
    }
    
    func setObject(_ object:OBJ) {
        self.label.text = OBJECTS[object]?["icon"] as! String
        self.label.fontColor = hex((OBJECTS[object]?["color"])! as! String)
    }
    
    func unsetObject() {
        self.label.text = TYPES[self.type]?["icon"] as? String
        self.label.fontColor = hex(labelSaveColor)
    }
    
    func toggleShow() {
        if self.position.y >= BTM_MARGIN && self.position.y + self.tileHeight <= (self.parent?.scene?.size.height)! - TOP_MARGIN {
            self.isHidden = false
        } else {
            self.isHidden = true
        }
    }
}
