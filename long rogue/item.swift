//
//  item.swift
//  long rogue
//
//  Created by rafael de los santos on 10/22/18.
//  Copyright © 2018 rafael de los santos. All rights reserved.
//

import Foundation

class Item {
    var name:String
    var type:OBJ
    var position:(Int, Int)
    var consumable:Bool
    
    init(_ newName:String, _ newType:OBJ) {
        self.name = newName
        self.type = newType
        self.position = (0, 0)
        self.consumable = OBJECTS[self.type]?["consumable"] as! Bool
    }
    
    func testprint() {
        print("goodbye", self.name)
    }
    
    // //////////////////////////////////////////////
    // MOVEMENT
    // //////////////////////////////////////////////
    
    func scrollUp() {
        self.position.0 -= 1
    }
    
    func setPosition(_ y:Int, _ x:Int) {
        self.position = (y, x)
    }
}
