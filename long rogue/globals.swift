//
//  globals.swift
//  long rogue
//
//  Created by rafael de los santos on 8/18/18.
//  Copyright © 2018 rafael de los santos. All rights reserved.
//

import Foundation
import SpriteKit

// ///////////////////////////////
// V A R S
// /////////////////////////////////////////////////////////////
// SIZES
let XMAX =                              18
let YMAX =                              18
let TILE_LABEL_SIZE:CGFloat =           20

let LABEL_FONT =                        "Fleftex Mono"
let BTM_MARGIN:CGFloat =                150
let TOP_MARGIN:CGFloat =                40

// COLORS
let BK_COLOR =                          "000000"
let F_COLOR =                           "111111"
let HUD_COLOR =                         "000000"
// hud
let GRAY1 =                             "999999"
let GRAY2 =                             "777777"
let GRAY3 =                             "555555"
let RED =                               "ff0000"
let DARK_RED =                          "C1272D"
let GREEN =                             "00ff00"
let DARK_GREEN =                        "22B573"
let CYAN =                              "00ffff"
let DARK_CYAN =                         "29ABE2"

// ///////////////////////////////
// G L O B A L S
// /////////////////////////////////////////////////////////////
func hex(_ hex:String) -> UIColor {
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    
    if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
    }
    
    if ((cString.count) != 6) {
        return UIColor.gray
    }
    
    var rgbValue:UInt32 = 0
    Scanner(string: cString).scanHexInt32(&rgbValue)
    
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}

func chance() -> Int {
    return Int(arc4random_uniform(100))
}

func rand(_ min:Int, _ max:Int) -> Int {
    return Int(arc4random_uniform(UInt32(max) - UInt32(min)) + UInt32(min))
}

// ///////////////////////////////
// O V E R L O A D S
// /////////////////////////////////////////////////////////////
//func ==(left:Int, right:CODES) -> Bool {
//    return left == right.rawValue
//}
//
//func ==(left:CODES, right:Int) -> Bool {
//    return left.rawValue == right
//}
