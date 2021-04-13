//
//  Utils.swift
//  Forest
//
//  Created by Sascha Kohlmann on 09.04.21.
//

import Foundation
import CoreGraphics

let rad_to_deg : Double = 180.0 / .pi
let deg_to_rad : Double = .pi / 180.0

func radians(_ degrees : Double) -> Double {
    return degrees * deg_to_rad
}

func degrees(_ radians : Double) -> Double {
    return radians * rad_to_deg
}

func radians(_ degrees : Float) -> Float {
    return degrees * Float(deg_to_rad)
}

func degrees(_ radians : Float) -> Float {
    return radians * Float(rad_to_deg)
}

func radians(_ degrees : CGFloat) -> CGFloat {
    return degrees * CGFloat(deg_to_rad)
}

func degrees(_ radians : CGFloat) -> CGFloat {
    return radians * CGFloat(rad_to_deg)
}

func map(_ value : Float, vallow : Float = 0, valhi : Float = 1, tarlow : Float = 0, tarhi : Float) -> Float {
    assert(value >= vallow && value <= valhi, "value (\(value) not in range \(vallow) - \(valhi)")
    return tarlow + (tarhi - tarlow) * ((value - vallow) / (valhi - vallow))
}

func map(_ value : Double, vallow : Double = 0, valhi : Double = 1, tarlow : Double = 0, tarhi : Double) -> Double {
    assert(value >= vallow && value <= valhi, "value (\(value) not in range \(vallow) - \(valhi)")
    return tarlow + (tarhi - tarlow) * ((value - vallow) / (valhi - vallow))
}
