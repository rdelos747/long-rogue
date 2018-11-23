//
//  enemy.swift
//  long rogue
//
//  Created by rafael de los santos on 10/22/18.
//  Copyright © 2018 rafael de los santos. All rights reserved.
//

import Foundation

class Enemy {
    var name:String
    var type:OBJ
    var position:(Int, Int)
    var currentPath:[(Int, Int)]
    
    var level:Int
    var health:Int
    var maxHealth:Int
    var speed:Int //may not be necessisary since order of attack is dictated by the level update function
    var accuracy:Int
    var hitPower:Int
    
    init(_ newName:String, _ newType:OBJ) {
        self.name = newName
        self.type = newType
        self.position = (0, 0)
        self.currentPath = []
        
        self.level = 1
        self.maxHealth = OBJECTS[self.type]?["maxHealth"] as! Int
        self.health = self.maxHealth
        self.speed = OBJECTS[self.type]?["speed"] as! Int
        self.accuracy = OBJECTS[self.type]?["accuracy"] as! Int
        self.hitPower = OBJECTS[self.type]?["hitPower"] as! Int
        
    }
    
    func testprint() {
        print("goodbye", self.name)
    }
    
    // //////////////////////////////////////////////
    // MOVEMENT
    // //////////////////////////////////////////////
    
    func getMove() -> ((Int, Int), (Int, Int))? {
        if self.currentPath.count > 0 {
            //            let lastPosition = self.position
            //            self.position = currentPath.popLast()!
            //            return (lastPosition, self.position)
            return (self.position, currentPath.popLast()!)
        }
        return nil
    }
    
    func acknowledgeMove(_ point:(Int, Int)) {
        self.position = point
    }
    
    func updateMoves() {
        for i in 0..<self.currentPath.count {
            self.currentPath[i].0 -= 1
        }
        self.position.0 -= 1
    }
    
    func scrollUp() {
        self.position.0 -= 1
    }
    
    func setPosition(_ y:Int, _ x:Int) {
        self.position = (y, x)
    }
    
    // //////////////////////////////////////////////
    // ATTACKING
    // //////////////////////////////////////////////
    func shouldAttack(_ attackPath:[(Int, Int)]) -> Bool {
        // I want the whole path for when enemies can attack at range
        if attackPath.count == 1 {
            return true
        }
        return false
    }
    
    // getAttack() might not be needed, just calculate in the level
    func getAttack() -> Int {
        //should really check an effective range of the attack
        // but for now check adjacent
        let attackPower = self.level + self.hitPower
        //return (attackPower, self.accuracy)
        return 1
    }
    
    func getHit(_ hit:Int) {
        self.health -= hit
    }
}
