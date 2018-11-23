//
//  path.swift
//  long rogue
//
//  Created by rafael de los santos on 8/21/18.
//  Copyright © 2018 rafael de los santos. All rights reserved.
//

import Foundation

class PathNode:Equatable {
    var g:Int
    var h:Int
    var f:Int
    let parent:PathNode?
    let position:(Int, Int)
    
    init(_ parent:PathNode?, _ position:(Int, Int)) {
        self.parent = parent
        self.position = position
        self.g = 0 // distance between self and start
        self.h = 0 // distance between self and end (heuristic?)
        self.f = 0 // total cost of node
    }
}

func ==(left:PathNode, right:PathNode) -> Bool {
    return left.position == right.position
}

func path(_ grid:[[Tile]], _ start:(Int, Int), _ end:(Int, Int)) -> [(Int, Int)] {
    let s = PathNode(nil, start)
    let e = PathNode(nil, end)
    
    var openList = [PathNode]()
    var closedList = [PathNode]()
    
    openList.append(s)
    
    while openList.count > 0 {
        
        // get current node
        var current = openList[0]
        var currentIndex = 0
        // loop through all open to find the closet
        for (index, item) in openList.enumerated() {
            if item.f < current.f {
                current = item
                currentIndex = index
            }
        }
        openList.remove(at: currentIndex)
        closedList.append(current)
        
        // if the end is found
        if current == e {
            var points = [(Int, Int)]()
            var next:PathNode? = current
            while next !== nil {
                points.append((next?.position)!)
                next = next?.parent
            }
            points.removeLast()
            return points
        }
        
        // get surrounding nodes
        var children = [PathNode]()
        let search = [
            (0, -1),
            (-1, 0),
            (0, 1),
            (1, 0)
        ]
        for point in search {
            let pos = (current.position.0 + point.0, current.position.1 + point.1)
            // make sure we are within bounds
            if pos.1 < 0 || pos.1 > grid[0].count - 1 || pos.0 < 0 || pos.0 > grid.count - 1 {
                continue
            }
            
            // make sure tile is walkable
            if grid[pos.0][pos.1].movable == false {
                continue
            }
            
            children.append(PathNode(current, pos))
        }
        
        childLoop:for child in children {
            // make sure child is not in closed list already
            for closedNode in closedList {
                if child == closedNode {
                    continue childLoop
                }
            }
            
            child.g = current.g + 1
            let pyth = (pow(Decimal(child.position.1 - e.position.1), 2) + pow(Decimal(child.position.0 - e.position.0),  2))
            child.h = Int(NSDecimalNumber(decimal:pyth))
            child.f = child.g + child.h
            
            // make sure child is not in open list already
            for openNode in openList {
                if child == openNode && child.g > openNode.g {
                    continue childLoop
                }
            }
            
            openList.append(child)
        }
    }
    return [(Int, Int)]()
}

func pathWithDiagonals(_ grid:[[Tile]], _ start:(Int, Int), _ end:(Int, Int)) -> [(Int, Int)] {
    let s = PathNode(nil, start)
    let e = PathNode(nil, end)
    
    var openList = [PathNode]()
    var closedList = [PathNode]()
    
    openList.append(s)
    
    while openList.count > 0 {
        
        // get current node
        var current = openList[0]
        var currentIndex = 0
        // loop through all open to find the closet
        for (index, item) in openList.enumerated() {
            if item.f < current.f {
                current = item
                currentIndex = index
            }
        }
        openList.remove(at: currentIndex)
        closedList.append(current)
        
        // if the end is found
        if current == e {
            var points = [(Int, Int)]()
            var next:PathNode? = current
            while next !== nil {
                points.append((next?.position)!)
                next = next?.parent
            }
            points.removeLast()
            return points
        }
        
        // get surrounding nodes
        var children = [PathNode]()
        let search = [
            (0, -1),
            (-1, 0),
            (0, 1),
            (1, 0),
            (-1, -1),
            (1, 1),
            (-1, 1),
            (1, -1)
        ]
        for point in search {
            let pos = (current.position.0 + point.0, current.position.1 + point.1)
            // make sure we are within bounds
            if pos.1 < 0 || pos.1 > grid[0].count - 1 || pos.0 < 0 || pos.0 > grid.count - 1 {
                continue
            }
            
            // make sure tile is walkable
            if grid[pos.0][pos.1].movable == false {
                continue
            }
            
            children.append(PathNode(current, pos))
        }
        
        childLoop:for child in children {
            // make sure child is not in closed list already
            for closedNode in closedList {
                if child == closedNode {
                    continue childLoop
                }
            }
            
            child.g = current.g + 1
            let pyth = (pow(Decimal(child.position.1 - e.position.1), 2) + pow(Decimal(child.position.0 - e.position.0),  2))
            child.h = Int(NSDecimalNumber(decimal:pyth))
            child.f = child.g + child.h
            
            // make sure child is not in open list already
            for openNode in openList {
                if child == openNode && child.g > openNode.g {
                    continue childLoop
                }
            }
            
            openList.append(child)
        }
    }
    return [(Int, Int)]()
}


/*
 need a function (not A*) to just get if the requested point is in direct line of origin
 */
