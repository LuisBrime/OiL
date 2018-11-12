//
//  SelectViewController.swift
//  PrimerEntrega
//
//  Created by Luis Eduardo Brime Gomez on 10/25/18.
//  Copyright © 2018 Luis Eduardo Brime Gomez. All rights reserved.
//

import UIKit

class SelectViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let next = segue.destination as! TrayectoriasTableViewController
        if segue.identifier == "pisos" {
            next.what = "P"
        } else if segue.identifier == "trayectorias" {
            next.what = "T"
        }
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
