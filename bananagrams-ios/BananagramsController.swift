import UIKit
import SpriteKit
import Foundation

class BananagramsController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let scene = BoardScene(size: view.bounds.size)
        println(view.debugDescription)
        let skView = view as SKView

        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = true
        scene.scaleMode = .ResizeFill
        skView.presentScene(scene)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

