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
    @IBOutlet weak var planoDetectado: UILabel!
    
    let configuration = ARWorldTrackingConfiguration()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print(img)
        // Do any additional setup after loading the view.
        self.sceneView.debugOptions = [ARSCNDebugOptions.showWorldOrigin, ARSCNDebugOptions.showFeaturePoints]
        self.configuration.planeDetection = .horizontal
        self.sceneView.session.run(configuration)
        self.sceneView.delegate = self
        
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
        do {
            print("Starting portal")
            let url = URL(string: img)
            let d = try? Data(contentsOf: url!)
            let imagen = UIImage(data: d!)
            
            let portalScene = SCNScene(named: "escenes.sncassets/Portal.scn")
            let portalNode = portalScene?.rootNode.childNode(withName: "Portal", recursively: false)
            
            
            let sphereNode = portalNode!.childNode(withName: "sphere", recursively: false)
            sphereNode?.geometry?.firstMaterial!.diffuse.contents = imagen
            
            let transform = hitTestResult.worldTransform
            let planeXposition = transform.columns.3.x
            let planeYposition = transform.columns.3.y
            let planeZposition = transform.columns.3.z
            
            portalNode?.position = SCNVector3(planeXposition, planeYposition, planeZposition)
            self.sceneView.scene.rootNode.addChildNode(portalNode!)
            print("Done")
        } catch {
            print("ERROR")
        }
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard anchor is ARPlaneAnchor else {return} //se agrego un plano
        //ejecución asincrona en donde se modifica la etiqueta de plano detectado
        DispatchQueue.main.async {
            self.planoDetectado.isHidden = false
            print("Plano detectado")
        }
        //espera 3 segundos antes de desaparecer
        DispatchQueue.main.asyncAfter(deadline: .now()+3){self.planoDetectado.isHidden = true}
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
