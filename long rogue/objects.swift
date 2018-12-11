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

let OBJECTS = [
    // ///////////////////////////
    // GENERAL
    // //////////////////////////////////////
    OBJ.none: [
        "icon": "",
        "color": "000000"
    ],
    OBJ.player: [
        "icon": "@",
        "color": PLAYER_COLOR
    ],
    // ///////////////////////////
    // MUSHROOMS
    // //////////////////////////////////////
    OBJ.redMushroom: [
        "icon": "*",
        "color": "ff0000",
        "consumable": true
    ],
    OBJ.blueMushroom: [
        "icon": "*",
        "color": "0000ff",
        "consumable": true
    ],
    OBJ.greenMushroom: [
        "icon": "*",
        "color": "00ff00",
        "consumable": true
    ],
    OBJ.purpleMushroom: [
        "icon": "*",
        "color": "8506A9",
        "consumable": true
    ],
    // ///////////////////////////
    // ENEMIES
    // //////////////////////////////////////
    OBJ.enemy0: [
        "icon": "i",
        "color": "ff0000",
        "maxHealth": 10,
        "speed": 50,
        "accuracy": 50,
        "hitPower": 1
    ]
]

enum OBJ {
    case none // this should never be used except for initializing arrays... im just too lazy to get this working with nil :)
    case player
    case redMushroom
    case greenMushroom
    case blueMushroom
    case purpleMushroom
    case enemy0
}
