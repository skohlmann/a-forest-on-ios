//
//  FractalTree.swift
//  Forest
//
//  Created by Sascha Kohlmann on 10.04.21.
//

import Foundation
import CoreGraphics

class FractalTree {
    
    let root : CGPoint
    let name : String
    let maxTrunkLength : Float
    let angle : Float
    let maxLevel : Int
    let trunk : FractalBranch
    
    var currentLevel : Int
    var canGrow : Bool {
        get {
            var current : FractalBranch = self.trunk
            var level = 0
            while !current.children.isEmpty {
                let node = current.children[0]
                if node is FractalBranch {
                    level += 1
                    current = node as! FractalBranch
                } else {
                    break
                }
            }
            
            return level < self.maxLevel
        }
    }

    init(name : String = "tree", root : CGPoint, maxTrunkLength : Float = 150, angle : Float = 0, maxLevel : Int = 10) {
        self.root = root
        self.name = name
        self.maxTrunkLength = maxTrunkLength
        self.angle = angle
        self.maxLevel = maxLevel
        self.currentLevel = 0
        self.trunk = FractalBranch(name: "trunk", startPosition: self.root, length: self.maxTrunkLength, angle: self.angle, level: 0)
    }
    
    func growIfPossible() {
        if canGrow {
            self.trunk.grow()
        }
    }
}
