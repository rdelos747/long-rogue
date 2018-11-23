//
//  player.swift
//  long rogue
//
//  Created by rafael de los santos on 8/22/18.
//  Copyright © 2018 rafael de los santos. All rights reserved.
//

import Foundation

class Player {
    var position:(Int, Int)
    var currentPath:[(Int, Int)]
    var bag:[Item]
    var weapon:Item?
    
    var level:Int
    var maxHealth:Int
    var health:Int
    var accuracy:Int
    var baseHit:Int //hit power when player has no weapon/ item to attack with
    
    init(_ j:Int, _ i:Int) {
        self.position = (j, i)
        self.currentPath = []
        self.bag = []
        self.weapon = nil
        
        self.level = 1
        self.maxHealth = 10
        self.health = maxHealth
        self.accuracy = 50
        self.baseHit = 5
        
    }
    
    // //////////////////////////////////////////////
    // MOVEMENT
    // //////////////////////////////////////////////
    
    func getMove() -> ((Int, Int), (Int, Int))? {
        if self.currentPath.count > 0 {
            return (self.position, currentPath.popLast()!)
        }
        return nil
    }
    
    func acknowledgeMove(_ point:(Int, Int)) {
        self.position = point
    }
    
    /*
     this needs to happen because array indexes get shifted when
     new tiles are generated. a possible solution is just to
     store the deltas (eg: [-1, 0] or [0, 1] etc..), and only
     update self.position
     */
    func updateMoves() {
        for i in 0..<self.currentPath.count {
            self.currentPath[i].0 -= 1
        }
        self.position.0 -= 1
    }
    
    func haltPlayer() {
        self.currentPath = []
    }
    
    func clearAllButNext() {
        if self.currentPath.count > 1 {
            var newMoves:[(Int, Int)] = []
            newMoves.append(self.currentPath.popLast()!)
            self.currentPath = newMoves
        }
    }
    
    // //////////////////////////////////////////////
    // ATTACK
    // //////////////////////////////////////////////
    func shouldAttack(_ attackPath:[(Int, Int)]) -> Bool {
        // I want the whole path for when player can attack at range
        if attackPath.count == 1 {
            return true
        }
        // should check for status effects here
        print("enemy out of range")
        return false
    }
    
    func getAttack() -> Int {
        //should really check an effective range of the attack
        // but for now check adjacent
        
        return 1
    }
    
    // //////////////////////////////////////////////
    // ITEMS
    // //////////////////////////////////////////////
    func canPickUp(_ item:Item) -> Bool {
        //figure out if player can pick up item
        return true
    }
    
    func pickUpItem(_ item:Item) -> String {
        if item.consumable {
            // do item function
            return "consumed"
        } else {
            // add to bag
            return "added"
        }
    }
    
    // //////////////////////////////////////////////
    // ENEMIES
    // //////////////////////////////////////////////
    func getHit(_ hit:Int) {
        self.health -= hit
        print("plauyer health now", self.health)
    }
}
