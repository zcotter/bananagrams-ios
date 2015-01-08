import UIKit
import SpriteKit
import Foundation

class BananagramsController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let scene = BananagramsScene(size: view.bounds.size)
        let skView = view as SKView

        skView.ignoresSiblingOrder = true
        scene.scaleMode = .ResizeFill
        skView.presentScene(scene)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

