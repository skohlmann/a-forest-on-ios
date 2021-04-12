//
//  ForestView.swift
//  Forest
//
//  Created by Sascha Kohlmann on 10.04.21.
//

import Foundation
import SwiftUI
import SpriteKit

class ForestScene : SKScene {

    private var trees : Array<FractalTree> = []
    
    override func update(_ currentTime: TimeInterval) {
        for tree in self.trees {
            tree.growIfPossible()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for tree in self.trees {
            tree.growIfPossible()
        }
    }

    
    override func didMove(to view: SKView) {
    }
    
    func add(tree : FractalTree) {
        trees.append(tree)
        addChild(tree.trunk)
    }
}
     
struct ForestView: View {
    
    var scene : SKScene {

        let scene = ForestScene()
        scene.size = CGSize(width: 600, height: 800)
        scene.scaleMode = .fill
        scene.backgroundColor = .black

        let baseTree = FractalTree(name : "tree.1", root:CGPoint(x:300, y:0), angle: 0)
        scene.add(tree: baseTree)
        return scene
    }
    
    var body: some View {
        VStack {
            SpriteView(scene: scene)
                .frame(width: 600, height: 800)
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
