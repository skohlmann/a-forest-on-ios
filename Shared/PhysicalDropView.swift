//
//  ContentView.swift
//  Shared
//
//  Created by Sascha Kohlmann on 08.04.21.
//

import SwiftUI
import SpriteKit

class PhysicalDropScene : SKScene {
    
    var oddEven = false
    
    override func didMove(to view: SKView) {
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {return}
        let location = touch.location(in: self)
        if oddEven {
            let box = SKSpriteNode(color: .red, size: CGSize(width: 50, height: 50))
            box.position = location
            box.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 50, height: 50))
            box.zPosition = 1
            addChild(box)
        } else {
            let shape = SKShapeNode(circleOfRadius: 25)
            shape.physicsBody = SKPhysicsBody(circleOfRadius: 25)
            shape.position = location
            shape.strokeColor = .blue
            shape.fillColor = .green
            shape.zPosition = 2
            addChild(shape)
        }
        oddEven.toggle()
    }
}
     
struct PhysicalDropView: View {
    
    var scene : SKScene {
        let scene = PhysicalDropScene()
        scene.size = CGSize(width: 600, height: 800)
        scene.scaleMode = .fill
        return scene
    }
    
    var body: some View {
        VStack {
            SpriteView(scene: scene)
                .frame(width: 600, height: 800)
                .ignoresSafeArea()
            Text("Hello SpriteKit")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PhysicalDropView()
        }
    }
}
