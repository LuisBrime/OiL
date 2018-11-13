//
//  LabDetailViewController.swift
//  PrimerEntrega
//
//  Created by Luis Eduardo Brime Gomez on 9/17/18.
//  Copyright © 2018 Luis Eduardo Brime Gomez. All rights reserved.
//

import UIKit

class LabDetailViewController: UIViewController {

    var nombre : String = "None"
    var piso : String = "None"
    var ubicacion : String = "Tec CCM"
    var trayectoria : String = "None"
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var floor: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var trayec: UILabel!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    var imgs : [String] = []
    var i : Int = 0
    @IBOutlet weak var carousel: UIImageView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height + 1000)

        
        // Do any additional setup after loading the view.
        loadImage()
        name.text = nombre
        floor.text = piso
        location.text = ubicacion
        trayec.text = trayectoria
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadImage() {
        self.indicator.startAnimating()
        
        DispatchQueue.global().async {
            DispatchQueue.main.async {
                let s : String = self.imgs[self.i]
                if let imgURL = NSURL(string: s) {
                    if let data = NSData(contentsOf: imgURL as URL) {
                        self.carousel.image = UIImage(data: data as Data)
                        self.indicator.stopAnimating()
                    }
                }
            }
        }
    }
    
    @IBAction func backImage(_ sender: Any) {
        let size = imgs.count
        if i-1 < 0 {
            i = size - 1
        } else {
            i = i - 1
        }
        loadImage()
    }
    
    @IBAction func nextImage(_ sender: Any) {
        let size = imgs.count
        if i+1 >= size {
            i = 0
        } else {
            i = i + 1
        }
        loadImage()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "tressesenta" {
            let vc = segue.destination as! SphereViewController
            vc.img = imgs[0]
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
