//
//  objects.swift
//  long rogue
//
//  Created by rafael de los santos on 10/1/18.
//  Copyright © 2018 rafael de los santos. All rights reserved.
//

/*
    OBJECTS are similar to TYPES (and CODES) but they represent things that can move or can be placed
    ontop of stuff. eg, an enemy or player can move, so it is an OBJECT. A mushroom cannot move or be placed,
    so it is
*/

import Foundation

var OBJECTS : [OBJ: [String: Any]] = [
    // general stuff
    OBJ.none: [
        "icon": "",
        "color": "000000"
    ],
    OBJ.player: [
        "icon": "@",
        "color": PLAYER_COLOR
    ]
]

func combineObjects() {
    OBJECTS.merge(MUSHROOMS) { (current, _) in current }
    OBJECTS.merge(WEAPONS) { (current, _) in current }
    //OBJECTS.merge(POTIONS) { (current, _) in current }
}


enum OBJ {
    case none // this should never be used except for initializing arrays... im just too lazy to get this working with nil :)
    case player
    case redMushroom
    case greenMushroom
    case blueMushroom
    case purpleMushroom
    case enemy0
    case sword
}
