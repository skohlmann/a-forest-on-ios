//
//  ForestView.swift
//  Forest
//
//  Created by Sascha Kohlmann on 10.04.21.
//

import Foundation
import SwiftUI
import SpriteKit

let width = CGFloat(600)
let height = CGFloat(800)

class ForestScene : SKScene {

    private var trees : Array<FractalTree> = []

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {return}
        let location = touch.location(in: self)
        print("location: \(location)")
        
        let maxLength = map(Float(location.y), vallow: 0, valhi: Float(height), tarlow: 30, tarhi: Float(height) / 5.333)
        var template = FractalBranchTemplate()
        template.sizeMultiplier = Float.random(in: 0.63...0.7)
        template.nextBranchAngle = Float.random(in: 35...50)
        let tree = FractalTree(name : "tree", root : CGPoint(x: location.x, y: 0), maxTrunkLength: maxLength, angle : trunkAngle(), template : template)
        trees.append(tree)
        addChild(tree.trunk)
        tree.startGrowing()
    }
    
    private func trunkAngle() -> Float {
        let angle = Float.random(in: 0...5)
        if (Bool.random()) {
            return angle
        }
        return angle * -1
    }
        
    func add(tree : FractalTree) {
        trees.append(tree)
        addChild(tree.trunk)
    }
}
     
struct ForestView: View {
    
    var scene : SKScene {

        let scene = ForestScene()
        scene.size = CGSize(width: width, height: height)
        scene.scaleMode = .fill
        scene.backgroundColor = .black

        let baseTree = FractalTree(name : "tree.1", root:CGPoint(x:width / 2, y:0), angle: 5)
        scene.add(tree: baseTree)
        baseTree.startGrowing()
        return scene
    }
    
    var body: some View {
        VStack {
            SpriteView(scene: scene)
                .frame(width: width, height: height)
                .ignoresSafeArea()
        }
    }
}

struct ForestView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ForestView()
        }
    }
}
