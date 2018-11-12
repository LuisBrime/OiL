//
//  SphereViewController.swift
//  OiL
//
//  Created by Luis Eduardo Brime Gomez on 11/12/18.
//  Copyright © 2018 Luis Eduardo Brime Gomez. All rights reserved.
//

import UIKit
import ARKit

class SphereViewController: UIViewController, ARSCNViewDelegate {

    var img : String = "https://i.imgur.com/tmgWXUP.jpg"
    @IBOutlet weak var sceneView: ARSCNView!
    let configuration = ARWorldTrackingConfiguration()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.sceneView.debugOptions = [ARSCNDebugOptions.showWorldOrigin, ARSCNDebugOptions.showFeaturePoints]
        self.configuration.planeDetection = .horizontal
        self.sceneView.session.run(configuration)
        self.sceneView.delegate = self
        
        let imgURL = NSURL(string: img)
        
        
        let portalScene = SCNScene(named: "art.scnassets/Portal.scn")
        let portalNode = portalScene?.rootNode.childNode(withName: "Portal", recursively: false)
        
        portalNode?.position = SCNVector3(0, 0, -0.5)
        portalNode?.geometry?.firstMaterial!.diffuse.contents = "Hola"
        self.sceneView.scene.rootNode.addChildNode(portalNode!)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapHandler))
        self.sceneView.addGestureRecognizer(tap)
    }
    
    @objc func tapHandler(sender: UITapGestureRecognizer) {
        guard let sceneView = sender.view as? ARSCNView else { return }
        
        let touchLocation = sender.location(in: sceneView)
        let hitTestResult = sceneView.hitTest(touchLocation, types: .existingPlaneUsingExtent)
        if !hitTestResult.isEmpty {
            self.addPortal(hitTestResult: hitTestResult.first!)
        }
        else {
            
        }
    }
    
    func addPortal(hitTestResult: ARHitTestResult) {
        let portalScene = SCNScene(named: "art.scnassets/Portal.scn")
        let portalNode = portalScene?.rootNode.childNode(withName: "Portal", recursively: false)
        let transform = hitTestResult.worldTransform
        let planeXposition = transform.columns.3.x
        let planeYposition = transform.columns.3.y
        let planeZposition = transform.columns.3.z
        portalNode?.position = SCNVector3(planeXposition, planeYposition, planeZposition)
        self.sceneView.scene.rootNode.addChildNode(portalNode!)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
