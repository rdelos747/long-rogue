//
//  room.swift
//  long rogue
//
//  Created by rafael de los santos on 8/18/18.
//  Copyright © 2018 rafael de los santos. All rights reserved.
//

/*
 ITEM CATEGORIES:
 0 NONE: ...
 1 FLOOR: forest floor, cave floor
 2 WALL: cave wall, tree,
 3 SHORT VEG: forest grass, cave grass,
 4 TALL VEG: forest bush, cave tall grass,
 5 SHALLOW LIQ: shallow water
 6 DEEP LIQ: deep water, lava (notice no shallow lava)
 
 IDEA:
 Based on room type, generate generic structures (liquid, veg, walls, etc),
 then 'flavor' them based on room type.
 Ex: if roomType == forest, all 6's become whatever number corresponds to
 'Deep water'
 
 NEED TO ADD:
 swamp type
 snow type??
 stream/ river structure
 
 
 
 OK OK OK OK
 ===========
 two conflicting methodologies to pick from:
 1.     (already partially started with env.swift) ... create room with values 1 - 6
        from above. Then pass those values to env.swift to convert them to their proper
        values (useing the CODES enum), and add any additional flavor there (mushrooms, etc).
        This feels like I'm doing the same task in two places when it should just be in
        one place...
 
 2.     Using the type drivers below, just create the actual structues in this file.
        Ex: GenerateBlob becomes GenerateTreeBlob or GenerateCaveBlob, and the actual
        values are added to the array. This is nice but will require a lot of code
        reuse... many functions will have the same logic but just have different values.
        Can maybe use CODES enum in the logic instead of straight ints?? Don't forget to
        delete env.swift if ur not using it anymore ;)
 
*/

import Foundation
import SpriteKit

let BLOB_W_PAD = 4
let BLOB_H_PAD = 4
let BLOB_MIN_H = 5
let BLOB_MIN_W = 5
let CELL_CHANCE = 30
let BIRTH = 3
let DEATH = 1
let CYCLES = 2

let MIN_BLOBS = 3
let MAX_EXTRA_BLOBS = 5
let EXTRA_BLOB_CHANCE = 20
let INITIAL_WATER_BLOB_CHANCE = 10

let GRASS_CHANCE = 20
let GRASS_CYCLES = 2
let GRASS_BIRTH = 3
let GRASS_DEATH = 1
let T_GRASS_CHANCE = 10
let T_GRASS_CYCLES = 2
let T_GRASS_BIRTH = 3
let T_GRASS_DEATH = 1

let SHALLOW_PUDDLE_CHANCE = 30
let DEEP_PUDDLE_CHANCE = 10
let MIN_PUDDLE_SIZE = 6
let MAX_PUDDLE_SIZE = 15
let PUDDLE_THRESHOLD = 0.8

let WATER_CHANCE = 30
let WATER_CYCLES = 4
let WATER_BIRTH = 3
let WATER_DEATH = 1
let D_WATER_CHANCE = 30
let D_WATER_CYCLES = 2
let D_WATER_BIRTH = 3
let D_WATER_DEATH = 1

let RED_MUSH_CHANCE = 10
let GREEN_MUSH_CHANCE = 10
let BLUE_MUSH_CHANCE = 10
let PURPLE_MUSH_CHANCE = 10
let MUSH_WIDTH = 3
let MUSH_CHANCE = 30
let MUSH_CYCLES = 2
let MUSH_BIRTH = 3
let MUSH_DEATH = 1

class Room {
    let width:Int
    let height:Int
    var tiles:[[CODES]]
    var itemLayer:[[Item?]]
    var enemyLayer:[[Enemy?]]
    
    init(_ width:Int, _ height:Int, _ option:String? = nil) {
        self.width = width
        self.height = height
        self.tiles = [[CODES]]()
        self.itemLayer = [[Item?]]()
        self.enemyLayer = [[Enemy?]]()
        
        for _ in 0..<self.height {
            var row = [CODES]()
            var row2 = [Item?]()
            var row3 = [Enemy?]()
            for _ in 0..<self.width {
                row.append(CODES.floor)
                row2.append(nil)
                row3.append(nil)
            }
            self.tiles.append(row)
            self.itemLayer.append(row2)
            self.enemyLayer.append(row3)
        }
        
        switch (option) {
        case "cave":
            self.createCave()
            break
        case "forest":
            self.createForest()
            break
        default:
            break
        }
    }
    
    // //////////////////////////
    // TYPE DRIVERS
    // //////////////////////////////////////////////////////////
    func createCave() {
        print("CREATING CAVE")
        self.getInitialWaterBlob()
        self.generateBlobs(type:CODES.caveWall, outline:true)
        self.addShallowPuddle()
        self.addDeepPuddle()
        self.addGrass()
        self.addMushrooms()
        self.addEnemies()
    }
    
    func createForest() {
        print("CREATING FOREST")
        self.generateBlobs(type:CODES.forestWall, outline:false)
        //self.addWater()
        self.addGrass()
    }
    
    // //////////////////////////
    // BLOB FUNCTIONS
    // //////////////////////////////////////////////////////////
    /*
     "General" Blob functions should be the first called in the room, and are used under the assumption that only
     floor/ none/ wall/ water tiles are present. Other tiles being present when making a blob of this type may
     render weird issues O.o
    */
    func getInitialWaterBlob() {
        if chance() < INITIAL_WATER_BLOB_CHANCE {
            print("   with water blob")
            self.addWaterBlob()
        }
    }
    func generateBlobs(type:CODES, outline:Bool) {
        for _ in 0..<MIN_BLOBS {
            self.generateBlob()
        }
        for _ in 0..<MAX_EXTRA_BLOBS {
            if chance() < EXTRA_BLOB_CHANCE {
                self.generateBlob()
            }
        }
        
        if outline {
            self.outlineBlob(type:type)
        } else {
            self.fillBlob(type:type)
        }
    }
    
    func generateBlob() {
        var numTries = 100
        generateWhile: while numTries > 0 {
            numTries -= 1
            let blobWidth = rand(BLOB_MIN_W, self.width - BLOB_W_PAD)
            let blobHeight = rand(BLOB_MIN_H, self.height - BLOB_H_PAD)
            let xOverflow = Int(floor(CGFloat(blobWidth) / 2))
            let randX = rand(0, self.width) - xOverflow
            let yPad = Int(floor(CGFloat(BLOB_H_PAD) / 2))
            let randY = rand(yPad, self.height - (blobHeight + yPad))
            
            let blob = cellAuto(CELL_CHANCE, blobHeight, blobWidth, DEATH, BIRTH, CYCLES)
            
            // check that space is valid
            for j in 0..<blobHeight {
                for i in 0..<blobWidth {
                    if (i + randX >= 0 && i + randX < self.width) {
                        if self.tiles[j + randY][i + randX] != CODES.floor || getSurrounding(j + randY, i + randX, self.height, self.width, self.tiles, CODES.none) > 0 {
                            continue generateWhile
                        }
                    }
                }
            }
            numTries = 0
            
            for j in 0..<blobHeight {
                for i in 0..<blobWidth {
                    if (i + randX >= 0 && i + randX < self.width) {
                        if blob[j][i] == 0 {
                            self.tiles[j + randY][i + randX] = CODES.floor
                        } else {
                            self.tiles[j + randY][i + randX] = CODES.none
                        }
                    }
                }
            }
        }
    }
    
    /*
     Water blobs are generated the same way as regular blobs, but are made of deepWater.
     After created, they are surrounded by a layer of shallow water that can touch other blobs
     */
    func addWaterBlob() {
        var numTries = 100
        generateWhile: while numTries > 0 {
            numTries -= 1
            let blobWidth = rand(BLOB_MIN_W, self.width - BLOB_W_PAD)
            let blobHeight = rand(BLOB_MIN_H, self.height - BLOB_H_PAD)
            let xOverflow = Int(floor(CGFloat(blobWidth) / 2))
            let randX = rand(0, self.width) - xOverflow
            let yPad = Int(floor(CGFloat(BLOB_H_PAD) / 2))
            let randY = rand(yPad, self.height - (blobHeight + yPad))
            
            let blob = cellAuto(CELL_CHANCE, blobHeight, blobWidth, DEATH, BIRTH, CYCLES)
            
            // check that space is valid
            for j in 0..<blobHeight {
                for i in 0..<blobWidth {
                    if (i + randX >= 0 && i + randX < self.width) {
                        if self.tiles[j + randY][i + randX] != CODES.floor || getSurrounding(j + randY, i + randX, self.height, self.width, self.tiles, CODES.floor) < 8 {
                            continue generateWhile
                        }
                    }
                }
            }
            numTries = 0
            
            for j in 0..<blobHeight {
                for i in 0..<blobWidth {
                    if (i + randX >= 0 && i + randX < self.width) {
                        if blob[j][i] == 0 {
                            self.tiles[j + randY][i + randX] = CODES.floor
                        } else {
                            self.tiles[j + randY][i + randX] = CODES.deepWater
                        }
                    }
                }
            }
            
            //surround with shallow water
            for j in 0..<self.height {
                for i in 0..<self.width {
                    if self.tiles[j][i] == CODES.floor && getSurrounding(j, i, self.height, self.width, self.tiles, CODES.deepWater) > 0 {
                        self.tiles[j][i] = CODES.water
                    }
                }
            }
        }
    }
    
    func outlineBlob(type:CODES) {
        var a = self.tiles
        for j in 0..<self.height {
            for i in 0..<self.width {
                if self.tiles[j][i] == CODES.none && getSurrounding(j, i, self.height, self.width, self.tiles, CODES.none) != 8 {
                    a[j][i] = type
                }
            }
        }
        self.tiles = a
        
        // not sure why switching the commented out code with the code below that broke things, but leaving it for reference
        // removeBadWalls
//        for j in 0..<self.height {
//            for i in 0..<self.width {
//                if self.tiles[j][i] == type && getSurrounding(j, i, self.height, self.width, self.tiles, CODES.floor) == 0 {
//                    self.tiles[j][i] = CODES.none
//                }
//            }
//        }
        
        let okTypes = [CODES.floor, CODES.water, CODES.deepWater]
        for j in 0..<self.height {
            for i in 0..<self.width {
                if self.tiles[j][i] == type && getSurrounding(j, i, self.height, self.width, self.tiles, okTypes) == 0 {
                    self.tiles[j][i] = CODES.none
                }
            }
        }
    }
    
    func fillBlob(type:CODES) {
        for j in 0..<self.height {
            for i in 0..<self.width {
                if self.tiles[j][i] == CODES.none {
                    self.tiles[j][i] = type
                }
            }
        }
    }
    
    // //////////////////////////
    // TERRAIN FUNCTIONS
    // //////////////////////////////////////////////////////////
    func addGrass() {
        let shallow = cellAuto(GRASS_CHANCE, self.height, self.width, GRASS_DEATH, GRASS_BIRTH, GRASS_CYCLES)
        let deep = cellAuto(T_GRASS_CHANCE, self.height, self.width, T_GRASS_DEATH, T_GRASS_BIRTH, T_GRASS_CYCLES)
        
        for j in 0..<self.height {
            for i in 0..<self.width {
                if self.tiles[j][i] == CODES.floor && shallow[j][i] == 1 {
                    if deep[j][i] == 1 {
                        self.tiles[j][i] = CODES.tallGrass
                    } else {
                        self.tiles[j][i] = CODES.grass
                    }
                }
            }
        }
    }
    
    /*
     Puddles are small blobs of water that can exist between regular blobs
    */
    func addShallowPuddle() {
        if chance() > SHALLOW_PUDDLE_CHANCE {
            return
        }
        
        print("   with shallow puddle")
        var numTries = 100
        generateWhile: while numTries > 0 {
            numTries -= 1
            let blobWidth = rand(MIN_PUDDLE_SIZE, MAX_PUDDLE_SIZE)
            let blobHeight = rand(MIN_PUDDLE_SIZE, MAX_PUDDLE_SIZE)
            let randX = rand(0, (self.width - 0) - blobWidth)
            let randY = rand(0, (self.height - 0) - blobHeight)
            
            let shallow = cellAuto(WATER_CHANCE, blobHeight, blobWidth, WATER_DEATH, WATER_BIRTH, WATER_CYCLES)
            
            var numWater = 0
            for j in 0..<blobHeight {
                for i in 0..<blobWidth {
                    if self.tiles[j + randY][i + randX] == CODES.floor{
                        numWater += 1
                    }
                }
            }
            if Double(numWater) < Double(blobWidth*blobHeight) * PUDDLE_THRESHOLD {
                continue generateWhile
            }
            
            numTries = 0
            
            for j in 0..<blobHeight {
                for i in 0..<blobWidth {
                    if self.tiles[j + randY][i + randX] == CODES.floor && shallow[j][i] == 1 {
                        self.tiles[j + randY][i + randX] = CODES.water
                    }
                }
            }
        }
    }
    
    func addDeepPuddle() {
        if chance() > DEEP_PUDDLE_CHANCE {
            return
        }
        
        print("   with deep puddle")
        var numTries = 100
        generateWhile: while numTries > 0 {
            numTries -= 1
            let blobWidth = rand(MIN_PUDDLE_SIZE, MAX_PUDDLE_SIZE)
            let blobHeight = rand(MIN_PUDDLE_SIZE, MAX_PUDDLE_SIZE)
            let randX = rand(0, (self.width - 0) - blobWidth)
            let randY = rand(0, (self.height - 0) - blobHeight)
            
            let shallow = cellAuto(WATER_CHANCE, blobHeight, blobWidth, WATER_DEATH, WATER_BIRTH, WATER_CYCLES)
            
            var numWater = 0
            for j in 0..<blobHeight {
                for i in 0..<blobWidth {
                    if self.tiles[j + randY][i + randX] == CODES.floor{
                        numWater += 1
                    }
                }
            }
            if Double(numWater) < Double(blobWidth*blobHeight) * 0.7 {
                continue generateWhile
            }
            
            numTries = 0
            
            for j in 0..<blobHeight {
                for i in 0..<blobWidth {
                    if self.tiles[j + randY][i + randX] == CODES.floor && shallow[j][i] == 1 {
                        self.tiles[j + randY][i + randX] = CODES.water
                    }
                }
            }
            for j in 0..<blobHeight {
                for i in 0..<blobWidth {
                    if randY + j > 0 && randY + j < self.height - 1 {
                        if self.tiles[randY + j][randX + i] == CODES.water && getSurrounding(j + randY, i + randX, self.height, self.width, self.tiles, CODES.floor) == 0 {
                            self.tiles[j + randY][i + randX] = CODES.deepWater
                        }
                    }
                }
            }
        }
    }
    
    /*
     Mushrooms appear around walls, so we only place the shallow layer when it intersects a wall.
     Also, not sure what to do with "mushroom floors" rn, so just sticking with placing just the
     actual mushrooms for now...
     */
    func addMushrooms() {
        if chance() < RED_MUSH_CHANCE {
            print("   with red mushroom")
            self.addMushroomPatch(CODES.redMushroomFloor, OBJ.redMushroom, "red mushroom")
        }
        if chance() < BLUE_MUSH_CHANCE {
            print("   with blue mushroom")
            self.addMushroomPatch(CODES.blueMushroomFloor, OBJ.blueMushroom, "blue mushroom")
        }
        if chance() < GREEN_MUSH_CHANCE {
            print("   with green mushroom")
            self.addMushroomPatch(CODES.greenMushroomFloor, OBJ.greenMushroom, "green mushroom")
        }
        if chance() < PURPLE_MUSH_CHANCE {
            print("   with purple mushroom")
            self.addMushroomPatch(CODES.purpleMushroomFloor, OBJ.purpleMushroom, "purple mushroom")
        }
    }
    
    func addMushroomPatch(_ type:CODES, _ object:OBJ, _ name:String) {
        var numTries = 100
        mushWhile:while numTries > 0 {
            numTries -= 1
            let randX = rand(0, (self.width - 0) - MUSH_WIDTH)
            let randY = rand(0, (self.height - 0) - MUSH_WIDTH)
            
            let shallow = cellAuto(WATER_CHANCE, MUSH_WIDTH, MUSH_WIDTH, MUSH_DEATH, MUSH_BIRTH, MUSH_CYCLES)
            var canMush = false
            let okTypes = [CODES.caveWall, CODES.forestWall]
            for j in 0..<MUSH_WIDTH {
                for i in 0..<MUSH_WIDTH {
                    if shallow[j][i] == 1 && getSurrounding(j + randY, i + randX, self.height, self.width, self.tiles, okTypes) > 0 {
                        canMush = true
                    }
                }
            }
            if canMush {
                numTries = 0
                for j in 0..<MUSH_WIDTH {
                    for i in 0..<MUSH_WIDTH {
                        if self.tiles[j + randY][i + randX] == CODES.floor && shallow[j][i] == 1 {
                            self.tiles[j + randY][i + randX] = type
                            let mushroom = Item(name, object)
                            self.itemLayer[j + randY][i + randX] = mushroom
                        }
                    }
                }
            }
        }
    }
    
    func addEnemies() {
        var search = true
        while search {
            let randX = rand(0, self.width - 1)
            let randY = rand(0, self.height - 1)
            
            if self.tiles[randY][randX] == CODES.floor {
                let enemy = Enemy("test enemy", OBJ.enemy0)
                self.enemyLayer[randY][randX] = enemy
                search = false
            }
        }
    }
}
