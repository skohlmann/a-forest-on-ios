//
//  ForestApp.swift
//  Shared
//
//  Created by Sascha Kohlmann on 08.04.21.
//

import SwiftUI

@main
struct ForestApp: App {
    var body: some Scene {
        WindowGroup {
            ForestView()
        }
    }
}

extension CGVector {
    
    static func -(lhs : CGVector, rhs : CGVector) -> CGVector {
        return CGVector(dx: lhs.dx - rhs.dx, dy: lhs.dy - rhs.dy)
    }
    
    static func +(lhs : CGVector, rhs : CGVector) -> CGVector {
        return CGVector(dx: lhs.dx + rhs.dx, dy: lhs.dy + rhs.dy)
    }
    
    static func *(lhs : CGVector, rhs : CGFloat) -> CGVector {
        return CGVector(dx: lhs.dx * rhs, dy: lhs.dy * rhs)
    }

    static func *(lhs : CGVector, rhs : Float) -> CGVector {
        return lhs * CGFloat(rhs)
    }

    static func /(lhs : CGVector, rhs : CGFloat) -> CGVector {
        return CGVector(dx: lhs.dx / rhs, dy: lhs.dy / rhs)
    }

    static func /(lhs : CGVector, rhs : Float) -> CGVector {
        return lhs / CGFloat(rhs)
    }
    
    func angle(_ v : CGVector) -> Float {
        return 0.0
    }
    
    func distance(_ v : CGVector) -> Float {
        let dx = self.dx - v.dx
        let dy = self.dy - v.dy
        return Float(sqrt(dx * dx + dy * dy))
    }

    func magnitude() -> Float {
        return Float(sqrt(self.dx * self.dx + self.dy * self.dy))
    }
    
    func heading() -> Float {
        return Float(atan2(self.dy, self.dx))
    }
    
    func rotate(radians : CGFloat) -> CGVector {
        return CGVector(dx: self.dx * cos(radians) - self.dy * sin(radians), dy: self.dx * sin(radians) - self.dy * cos(radians))
    }
    
    func rotate(degrees : CGFloat) -> CGVector {
        return rotate(radians: radians(degrees))
    }
    
    // Angle in radians
    func angleBetween(_ v : CGVector) -> Float {
        // We get NaN if we pass in a zero vector which can cause problems
        // Zero seems like a reasonable angle between a (0,0,0) vector and something else
        if self.dx == 0 && self.dx == 0 {return 0.0}
        if self.dy == 0 && self.dy == 0 {return 0.0}
        
        let dot = Float(self.dx * v.dx + self.dy * v.dy)
        // This should be a number between -1 and 1, since it's "normalized"
        let amt = dot / (self.magnitude() * v.magnitude())
        
        // But if it's not due to rounding error, then we need to fix it
        // Otherwise if outside the range, acos() will return NaN
        if amt <= -1 {
            return .pi;
        } else if amt >= 1 {
            return 0;
        }
        return acos(amt);
    }
    
    func normalized() -> CGVector {
        let mag = magnitude()
        if mag != 0 && mag != 1 {
            return self / mag
        }
        
        return self
    }
    
    func dot(_ v : CGVector) -> Float {
        return Float(self.dx * v.dx + self.dy * v.dy)
    }
}

extension CGVector {
    func asPoint() -> CGPoint {
        return CGPoint(x:self.dx, y:self.dy)
    }
}

extension CGPoint {
    func asVector() -> CGVector {
        return CGVector(dx: self.x, dy: self.y)
    }
}

extension Float {
    func cgFloat() -> CGFloat {
        return CGFloat(self)
    }
}
