//
//  FractalBranch.swift
//  Forest
//
//  Created by Sascha Kohlmann on 10.04.21.
//

import Foundation
import SpriteKit
import SwiftUI

class FractalBranch : SKShapeNode {
    
    private let originalLength : Float
    let length : Float
    let angle : Float
    let level : Int
    let template : FractalBranchTemplate
    var currentGrowSteps : Int = 0
    private var finished : Bool = false
    
    var growSteps : Int {
        get {
            if level == 0 {
                return self.template.growSteps
            }
            return self.template.growSteps / level
        }
    }
    
    var canGrow : Bool {
        get {
            return !self.finished || self.currentGrowSteps < self.growSteps
        }
    }
    
    private var growLength : Float {
        get {
            return (self.length / Float(self.growSteps)) * Float(self.currentGrowSteps)
        }
    }
    
    private var branchLength : Float {
        get {
            self.originalLength * self.template.sizeMultiplier
        }
    }
    
    var end : CGPoint {
        get {
            return CGPoint(x:0, y:CGFloat(length))
        }
    }
    
    init(name : String = "", startPosition : CGPoint, length : Float, angle : Float, level : Int, template : FractalBranchTemplate = FractalBranchTemplate()) {
        self.originalLength = length
        self.angle = angle * -1.0
        self.template = template
        self.level = level
        self.length = length + Float.random(in: template.branchLengthJitterLowBoundry...template.branchLengthJitterHightBoundry) * length
        super.init()
        self.position = startPosition
        self.zRotation = radians(CGFloat(self.angle))
        self.name = name + "." + level.description
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func grow() {
        var newBranch = false
        if canGrow {
            self.currentGrowSteps += 1
            let path = CGMutablePath()
            self.fillColor = self.template.color
            let l = growLength
            path.addLines(between: [CGPoint(x:0,y:0), CGPoint(x:0, y:Int(growLength))])
            self.path = path
            if l >= self.length {
                self.finished = true
                let branchPosition = end
                let leftBranch = FractalBranch(name : "branch.left", startPosition: branchPosition, length: branchLength, angle: branchAngle, level: self.level + 1)
                let rightBranch = FractalBranch(name : "branch.right", startPosition: branchPosition, length: branchLength, angle: branchAngle * -1, level: self.level + 1)
                addChild(leftBranch)
                addChild(rightBranch)
                newBranch.toggle()
            }
        }
        if !newBranch && !self.children.isEmpty {
            for e in self.children {
                if e is FractalBranch {
                    let branch = e as! FractalBranch
                    branch.grow()
                }
            }
        }
    }
    
    private var branchAngle : Float {
        get {
            var newAngle = self.template.nextBranchAngle + Float.random(in: template.branchLengthJitterLowBoundry...template.branchLengthJitterHightBoundry) * self.template.nextBranchAngle
            while newAngle < -360 || newAngle > 360 {
                if (newAngle < -360) {
                    newAngle += 360
                } else {
                    newAngle -= 360
                }
            }
            return newAngle
        }
    }
    
    func isFinished() -> Bool {
        return self.finished
    }
}


struct FractalBranchTemplate {
    var sizeMultiplier : Float = 0.67
    var nextBranchAngle : Float = 45.0
    var branchLengthJitterLowBoundry : Float = -0.2
    var branchLengthJitterHightBoundry : Float = 0.2
    var branchAngleJitterLowBoundry : Float = -0.3
    var branchAngleJitterHightBoundry : Float = 0.3
    var color : UIColor = .yellow
    var branchWeight : Float = 1
    var growSteps : Int = 20
    var firstLeafLevel = 1
}
