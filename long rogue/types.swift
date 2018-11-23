//
//  types.swift
//  long rogue
//
//  Created by rafael de los santos on 8/18/18.
//  Copyright © 2018 rafael de los santos. All rights reserved.
//

import Foundation

let TYPES = [
    // ///////////////////////////
    // GENERAL
    // //////////////////////////////////////
    CODES.test: [
        "icon": " ",
        "color": ["ffffff"],
        "background": ["ff0000"],
        "movable": false
    ],
    CODES.none: [
        "icon": " ",
        "color": [BK_COLOR],
        "background": [BK_COLOR],
        "movable": false
    ],
    CODES.floor: [
        "icon": ".",
        "color":[
            "666666",
            "444444",
            "222222"
        ],
        "background": [F_COLOR],
        "movable": true
    ],
    CODES.door: [
        "icon": "+",
        "color": ["0000ff"],
        "background": ["666666"],
        "movable": true
    ],
    CODES.grass:  [
        "icon": ",",
        "color": ["00ff00"],
        "background": [F_COLOR],
        "movable": true
    ],
    CODES.tallGrass:  [
        "icon": "~",
        "color": ["00ff00"],
        "background": [F_COLOR],
        "movable": true
    ],
    CODES.water:  [
        "icon": ".",
        "color": ["0E0E52"],
        "background": [
            "1A1A59",
            "1E1E64"
        ],
        "movable": true
    ],
    CODES.deepWater:  [
        "icon": "~",
        "color": ["23294E"],
        "background": [
            "060E3D",
            "071352"
        ],
        "movable": true
    ],
    // ///////////////////////////
    // CAVE
    // //////////////////////////////////////
    CODES.caveWall: [
        "icon": "#",
        "color": ["000000"],
        "background": [
            "321345",
            "241130",
            "431061"
        ],
        "movable": false
    ],
    // ///////////////////////////
    // FOREST
    // //////////////////////////////////////
    CODES.forestWall: [
        "icon": "#",
        "color": ["000000"],
        "background": [
            "00ff00",
            "00bb00",
            "009900"
        ],
        "movable": false
    ],
    // ///////////////////////////
    // MUSHROOMS
    // //////////////////////////////////////
    CODES.redMushroomFloor: [
        "icon": ".",
        "color": ["ff0000"],
        "background": ["220000"],
        "movable": true
    ],
    CODES.blueMushroomFloor: [
        "icon": ".",
        "color": ["0000ff"],
        "background": ["000022"],
        "movable": true
    ],
    CODES.greenMushroomFloor: [
        "icon": ".",
        "color": ["00ff00"],
        "background": ["002200"],
        "movable": true
    ],
    CODES.purpleMushroomFloor: [
        "icon": ".",
        "color": ["8506A9"],
        "background": ["1A0D1D"],
        "movable": true
    ],
]

enum CODES {
    case test
    case player
    case none
    case floor
    case door
    case caveWall
    case forestWall
    case grass
    case tallGrass
    case water
    case deepWater
    //case blueMushroom
    case blueMushroomFloor
    //case redMushroom
    case redMushroomFloor
    //case greenMushroom
    case greenMushroomFloor
    case purpleMushroomFloor
}
