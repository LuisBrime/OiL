//
//  VideoARViewController.swift
//  PrimerEntrega
//
//  Created by Luis Eduardo Brime Gomez on 10/25/18.
//  Copyright © 2018 Luis Eduardo Brime Gomez. All rights reserved.
//

import UIKit
import SceneKit
import ARKit
import AVFoundation

class VideoARViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        sceneView.delegate = self
        sceneView.showsStatistics = true
        let scene = SCNScene()
        sceneView.scene = scene
        registerGestureRecognizer()
    }
    
    private func registerGestureRecognizer()
    {
        let tapGesto = UITapGestureRecognizer(target: self, action: #selector(tapPantalla))
        self.sceneView.addGestureRecognizer(tapGesto)
    }
    
    @objc func tapPantalla(man: UIGestureRecognizer) {
        guard let currentFrame = self.sceneView.session.currentFrame else { return }
        
        let movie = "http://ebookfrenzy.com/ios_book/movie/movie.mov"
        let url = URL(string: movie)
        let player = AVPlayer(url: url!)
        player.volume = 0.5
        print(player.isMuted)
        
        let vN = SKVideoNode(url: url!)
        vN.play()
        
        let sKE = SKScene(size: CGSize(width: 640, height: 480))
        sKE.addChild(vN)
        vN.position = CGPoint(x: sKE.size.width/2, y: sKE.size.height/2)
        vN.size = sKE.size
        
        let pantalla = SCNPlane(width: 1.0, height: 0.75)
        pantalla.firstMaterial?.diffuse.contents = sKE
        pantalla.firstMaterial?.isDoubleSided = true
        let pantallaPlanaNodo = SCNNode(geometry: pantalla)
        var traduccion = matrix_identity_float4x4
        traduccion.columns.3.z = -1.0
        pantallaPlanaNodo.simdTransform = matrix_multiply(currentFrame.camera.transform, traduccion)
        pantallaPlanaNodo.eulerAngles = SCNVector3(Double.pi, 0, 0)
        self.sceneView.scene.rootNode.addChildNode(pantallaPlanaNodo)
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
