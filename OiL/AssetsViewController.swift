//
//  AssetsViewController.swift
//  PrimerEntrega
//
//  Created by Luis Eduardo Brime Gomez on 10/25/18.
//  Copyright © 2018 Luis Eduardo Brime Gomez. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class AssetsViewController: UIViewController, ARSCNViewDelegate {

    var nRaiz = SCNNode()
    @IBOutlet var sceneView: ARSCNView!
    
    @IBAction func tamanio(recognizer: UIPinchGestureRecognizer) {
        nRaiz.scale = SCNVector3(recognizer.scale, recognizer.scale, recognizer.scale)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        sceneView.delegate = self
        sceneView.showsStatistics = true
        sceneView.autoenablesDefaultLighting = true
        
        let s = SCNScene()
        
        if let filePath = Bundle.main.path(forResource: "model", ofType: "dae", inDirectory: "art.scnassets") {
            let referenceURL = URL(fileURLWithPath: filePath)
            
            let referenceNode = SCNReferenceNode(url: referenceURL)
            referenceNode?.load()
            nRaiz = referenceNode!
        }
        
//        let material = SCNMaterial()
//        material.diffuse.contents = UIImage(named: "pug_text.jpg")
//        nRaiz.geometry?.materials = [material]
        nRaiz.position = SCNVector3(x:0, y:0, z:-0.5)
        s.rootNode.addChildNode(nRaiz)
        
        let pinchGestureRecognizer = UIPinchGestureRecognizer (target: self, action: #selector(tamanio))
        sceneView.addGestureRecognizer(pinchGestureRecognizer)
        
        sceneView.scene = s
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
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
