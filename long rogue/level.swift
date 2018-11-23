//
//  level.swift
//  long rogue
//
//  Created by rafael de los santos on 8/18/18.
//  Copyright © 2018 rafael de los santos. All rights reserved.
//

import Foundation
import SpriteKit

/*
 STRATEGY:
 have a 2d array of ints (from Room class) that gets generated
 every time a player moves 1 room.height length
 
 ok so swift sucks at generating nodes. Have a finite amount of
 sprite nodes, and when the level scrolls up pop off the front
 and add that row to the back of self.tiles, use room[0] to set
 the vals
 
 ROOM/ LEVEL GENERATION STRATEGY:
 Level keeps track of number of rooms passed (also number of steps,
 just for fun?). Level type changes when that number hits certain
 points (ex, room 11 is start of caves, room 21 is start of
 something else). Pass the 'room type' into the room object. When
 the room object is done creating the structure, it should pass
 its tiles to an Env object that creates the environment based on
 the 'room type'. Since this all happens before the tiles are
 updated, this will just be an array of Ints.
 
 something like:
    Room.swift
        self.tiles = Env(self.tiles)
 
    should env be a class or just a neat function??
*/

let RENDER_DELAY = 5
let ROOM_TYPES = [
    "forest",
    "swamp",
    "cave"
]

class Level {
    var scene:GameScene;
    var tiles:[[Tile]] = [[Tile]]()
    var room:Room?
    var roomItems:[Item] = [Item]()
    var roomEnemies:[Enemy] = [Enemy]()
    var width:Int
    var height:Int
    var tileWidth:CGFloat
    var tileHeight:CGFloat
    var currentY:Int
    var player:Player
    var touched:Bool
    var touchPoint:(Int, Int)
    var currentDelay:Int
    
    var currentRoom:Int
    var currentRoomType:String
    var steps:Int
    var maxStep:Int
    
    // /////////////////////////////////
    // INIT
    // /////////////////////////////////
    
    init(_ scene:GameScene) {
        self.scene = scene
        self.tileWidth = scene.size.width / CGFloat(XMAX)
        self.tileHeight = floor((scene.size.height - (TOP_MARGIN + BTM_MARGIN)) / CGFloat(YMAX))
        self.width = XMAX//Int(floor(scene.size.width / self.tileWidth))
        self.height = YMAX//Int(floor(scene.size.height /  self.tileHeight))
        self.currentY = 0
        self.player = Player(self.height / 4, self.width / 2)
        self.touched = false
        self.touchPoint = (0,0)
        self.currentDelay = 0
        self.currentRoom = 1
        self.currentRoomType = "cave"
        self.steps = self.height / 4
        self.maxStep = self.steps
        
        self.generateFirstRooms()
        
        self.tiles[self.player.position.0][self.player.position.1].setObject(OBJ.player)
    }
    
    // /////////////////////////////////
    // ROOM
    // /////////////////////////////////
    
    func generateFirstRooms() {
        //self.room = Room(self.width, self.height, "firstRoom")
        self.room = Room(self.width, self.height, nil)
        // get initial tiles (only on level creation does the entire
        // room need to be added to self.tiles)
        for j in 0..<self.height {
            var row = [Tile]()
            for i in 0..<self.width {
                let t = Tile(j, i, self.tileWidth, self.tileHeight, false)
                t.updateType((self.room?.tiles[j][i])!)
                // if the object layer of the room has an object, add it!
                if self.room?.itemLayer[j][i] != nil {
                    let currentItem = (self.room?.itemLayer[j][i])!
                    currentItem.setPosition(j, i)
                    self.roomItems.append(currentItem)
                    t.setObject(currentItem.type)
                }
                // if the enemy layer of the room has an enemy, add it!
                if self.room?.enemyLayer[j][i] != nil {
                    let currentEnemy = (self.room?.enemyLayer[j][i])!
                    currentEnemy.setPosition(j, i)
                    self.roomEnemies.append(currentEnemy)
                    t.setObject(currentEnemy.type)
                }

                row.append(t)
                self.scene.addChild(t)
                t.toggleShow()
            }
            self.tiles.append(row)
        }
        
        self.room = Room(self.width, self.height, self.currentRoomType)
        for j in 0..<self.height {
            var row = [Tile]()
            for i in 0..<self.width {
                let t = Tile(j + self.height, i, self.tileWidth, self.tileHeight, false)
                t.updateType((self.room?.tiles[j][i])!)
                // if the object layer of the room has an object, add it!
                if self.room?.itemLayer[j][i] != nil {
                    let currentItem = (self.room?.itemLayer[j][i])!
                    currentItem.setPosition(j + self.height, i)
                    self.roomItems.append(currentItem)
                    t.setObject(currentItem.type)
                }
                // if the enemy layer of the room has an enemy, add it!
                if self.room?.enemyLayer[j][i] != nil {
                    let currentEnemy = (self.room?.enemyLayer[j][i])!
                    currentEnemy.setPosition(j + self.height, i)
                    self.roomEnemies.append(currentEnemy)
                    t.setObject(currentEnemy.type)
                }
                row.append(t)
                self.scene.addChild(t)
                t.toggleShow()
            }
            self.tiles.append(row)
        }
        self.room?.tiles.removeAll()
    }
    
    func getNewRoom() {
        // TODO:
        // switch self.currentRoom
        //      use this to figure out which room we are in.
        //      ex: if on room 10 we set self.currentRoomType
        //      to equal "cave?", then all subsequent rooms will
        //      be of that of that type until we change
        //      self.currentRoomType
        self.room = Room(self.width, self.height, self.currentRoomType)
        //self.addObjects()
    }
    
    // /////////////////////////////////
    // MOVEMENT
    // /////////////////////////////////
    
    func scrollUp() {
        if self.currentY < self.height {
            self.currentY += 1
        } else {
            self.player.updateMoves()
            if (self.room?.tiles.count)! < 1 {
                print("out of tiles in room")
                self.getNewRoom()
            }
            let row = self.tiles[0]
            self.tiles.removeFirst()
            self.tiles.append(row)
            
            // delete object that move below screen
            for (index, item) in self.roomItems.enumerated().reversed() {
                item.scrollUp()
                if item.position.0 < 0 {
                    item.testprint()
                    self.roomItems.remove(at: index)
                }
            }
            // delete enemies that move below screen
            for (index, enemy) in self.roomEnemies.enumerated().reversed() {
                enemy.scrollUp()
                if enemy.position.0 < 0 {
                    enemy.testprint()
                    self.roomEnemies.remove(at: index)
                }
            }
            
            for i in 0..<self.width {
                row[i].position.y = CGFloat(CGFloat(self.height) * self.tileHeight) + BTM_MARGIN
                row[i].updateType((self.room?.tiles[0][i])!)
                if self.room?.itemLayer[0][i] != nil {
                    let currentItem = (self.room?.itemLayer[0][i])!
                    currentItem.setPosition((self.height * 2) - 1, i)
                    self.roomItems.append(currentItem)
                    row[i].setObject(currentItem.type)
                }
                if self.room?.enemyLayer[0][i] != nil {
                    let currentEnemy = (self.room?.enemyLayer[0][i])!
                    currentEnemy.setPosition((self.height * 2) - 1, i)
                    self.roomEnemies.append(currentEnemy)
                    row[i].setObject(currentEnemy.type)
                }
            }
            self.room?.tiles.removeFirst()
            self.room?.itemLayer.removeFirst()
            self.room?.enemyLayer.removeFirst()
        }
        
        for r in self.tiles {
            for t in r {
                t.scrollUp()
            }
        }
    }
    
    func scrollDown() {
        if self.currentY > 0 {
            self.currentY -= 1
            for r in self.tiles {
                for t in r {
                    t.scrollDown()
                }
            }
        }
    }
    
    func movePlayerAndScreen(_ current:(Int, Int), _ next:(Int, Int)) {
        self.player.acknowledgeMove(next)
        self.tiles[current.0][current.1].unsetObject()
        self.tiles[next.0][next.1].setObject(OBJ.player)
        if current.0 < next.0 {
            self.steps += 1
            if self.maxStep < self.steps {
                self.maxStep = steps
            }
            if self.steps % self.height == 0 && self.steps == self.maxStep {
                self.currentRoom += 1
            }
            if next.0 >= self.height / 2 {
                self.scrollUp()
            }
        } else if current.0 > next.0 {
            self.steps -= 1
            if (next.0 + 1) >= self.height / 2 { // this feels hacky, I didn't need to do this before adding the btm margin :/
                self.scrollDown()
            }
        }
    }
    
    // /////////////////////////////////
    // UPDATE
    // /////////////////////////////////
    
    func touch(_ location:CGPoint) {
        let pointOnScreen = floor((location.y - BTM_MARGIN) / self.tileHeight)
        if pointOnScreen < 0 || pointOnScreen > CGFloat(self.height - 1) {
            return
        }
        self.touchPoint.0 = Int(pointOnScreen) + self.currentY
        self.touchPoint.1 = Int(floor(location.x / self.tileWidth))
        self.touched = true
    }
    
    func findPath(_ start:(Int, Int), _ end:(Int, Int)) {
        self.player.currentPath = path(self.tiles, start, end)
    }
    
    func update() {
        // //////////////////////////
        // STEP 0:
        // PROCESS TOUCH
        // //////////////////////////
        if self.touched {
            self.touched = false
            
            var playerDidSingleAction = false
            
            // determine what to do if player touched item.
            //
            // this is idealy if player can interact with an item from far away,
            // but maybe this is not needed, since player now will just walk to
            // the item and pick it up when they are next to it
            let (itemIndex, item) = self.itemAtPoint(self.touchPoint)
            if item != nil {
                // see if player is in range to interact
                
            }
            
            // determine what to do if player touched enemy
            let (enemyIndex, enemy) = self.enemyAtPoint(self.touchPoint)
            if enemy != nil {
                let attackPath = pathWithDiagonals(self.tiles, self.player.position, enemy!.position)
                if self.player.shouldAttack(attackPath) {
                    playerDidSingleAction = true
                    self.playerAttackEnemy(enemyIndex!, enemy!)
                }
            }
            
            if playerDidSingleAction {
                _ = self.updateEnemies(self.player.position)
                self.player.haltPlayer()
            } else {
                if self.tiles[self.touchPoint.0][self.touchPoint.1].movable {
                    self.findPath(self.player.position, self.touchPoint)
                } else {
                    print("cant walk there")
                }
            }
        }
        
        // //////////////////////////
        // STEP 1:
        // If touch was not a single action
        // //////////////////////////
        
        if self.currentDelay == 0 {
            if let (current, next) = player.getMove() {
                var movePlayer = true
                
                // STEP A: figure out if player can move.
                // player cannot move if:
                //      - player runs into enemy on direct path (if so will try to attack)
                //      - player runs into interactable object
                //      - other cases?
                if self.attackEnemyOnPath(next) {
                    print("enemy was attacked?")
                    movePlayer = false
                }
                else if self.isItemOnNextPoint(next) {
                    print("item exists on next space")
                    let (index, item) = self.itemAtPoint(next)
                    if self.player.canPickUp(item!) {
                        let action = self.player.pickUpItem(item!)
                        if action == "consumed" {
                            let s = "You consumed a " + item!.name
                            self.scene.showMessage(s)
                        }
                        else if action == "added" {
                            let s = "You got a " + item!.name
                            self.scene.showMessage(s)
                        }
                        self.removeItemFromLevel(index!, item!)
                        self.player.haltPlayer()
                        
                    } else {
                        print("player did not get", item!.name)
                        // print some message saying why player cannot pick up item,
                        // maybe their bag is full or something...
                        // maybe player.canPickUpItem should return some message
                        movePlayer = false
                    }
                }
                
                // STEP B: if player can move, do so
                //     This happens before enemy update to let player try to escape
                if movePlayer {
                    self.movePlayerAndScreen(current, next)
                } else {
                    self.player.haltPlayer()
                }
                
                // STEP C: update enemies.
                // returns true if player is attacked
                if self.updateEnemies(self.player.position) {
                    self.player.haltPlayer()
                }
                
                self.currentDelay = RENDER_DELAY
            }
        } else {
            self.currentDelay -= 1
        }
    }
    
    func updateEnemies(_ playerPoint:(Int, Int)) -> Bool {
        // update all objects (just enemies will acknowledge,
        // but I guess this could be used for passive objects as well??)
        var haltPlayer = false
        for (_, enemy) in self.roomEnemies.enumerated().reversed() {
            
            //move player, then try to attack
            enemy.currentPath = path(self.tiles, enemy.position, self.player.position)
            if let (enemyCurrent, enemyNext) = enemy.getMove() {
                if enemyNext != playerPoint {
                    enemy.acknowledgeMove(enemyNext)
                    self.tiles[enemyCurrent.0][enemyCurrent.1].unsetObject()
                    self.tiles[enemyNext.0][enemyNext.1].setObject(enemy.type)
                }
            }
            let attackPath = pathWithDiagonals(self.tiles, enemy.position, playerPoint)
            if enemy.shouldAttack(attackPath) {
                haltPlayer = true
                self.enemyAttackPlayer(enemy)
            }
        }
        return haltPlayer
    }
    
    func itemAtPoint(_ point:(Int, Int)) -> (Int?, Item?) {
        for (index, item) in self.roomItems.enumerated().reversed() {
            if item.position == point {
                return (index, item)
            }
        }
        return (nil, nil)
    }
    
    func enemyAtPoint(_ point:(Int, Int)) -> (Int?, Enemy?) {
        for (index, enemy) in self.roomEnemies.enumerated().reversed() {
            if enemy.position == point {
                return (index, enemy)
            }
        }
        return (nil, nil)
    }
    
    func removeItemFromLevel(_ index:Int, _ item:Item) {
        self.tiles[item.position.0][item.position.1].unsetObject()
        self.roomItems.remove(at: index)
    }
    
    func removeEnemyFromLevel(_ index:Int, _ enemy:Enemy) {
        self.tiles[enemy.position.0][enemy.position.1].unsetObject()
        self.roomEnemies.remove(at: index)
    }
    
    func attackEnemyOnPath(_ point:(Int, Int)) -> Bool {
        for (index, enemy) in self.roomEnemies.enumerated().reversed() {
            if enemy.position == point {
                if self.player.shouldAttack([(1,1)]) {
                    self.playerAttackEnemy(index, enemy)
                }
                return true
            }
        }
        return false
    }
    
    func isItemOnNextPoint(_ point:(Int, Int)) -> Bool {
        for (index, item) in self.roomItems.enumerated().reversed() {
            if item.position == point {
                return true
            }
        }
        return false
    }
    
    func playerAttackEnemy(_ index:Int, _ enemy:Enemy) {
        var playerAttack = self.player.baseHit
        
        // get attack from weapon
        if self.player.weapon != nil {
            // get power and accuracy from weapon
        }
        
        // roll to hit
        if chance() < self.player.accuracy {
            enemy.getHit(playerAttack)
            
            // if enemy died, remove it
            if enemy.health < 1 {
                self.removeEnemyFromLevel(index, enemy)
                let s = "You killed " + enemy.name
                scene.showMessage(s)
            } else {
                let s = "You attacked " + enemy.name
                scene.showMessage(s)
            }
            
        } else {
            let s = "You missed " + enemy.name
            scene.showMessage(s)
        }
    }
    
    func enemyAttackPlayer(_ enemy:Enemy) {
        let enemyAttack = enemy.level + enemy.hitPower
        if chance() < enemy.accuracy {
            self.player.getHit(enemyAttack)
            let s = enemy.name + " attacked you"
            scene.showMessage(s)
        } else {
            let s = enemy.name + " missed you"
            scene.showMessage(s)
        }
    }
}
