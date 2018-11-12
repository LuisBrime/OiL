//
//  LabsTableViewController.swift
//  PrimerEntrega
//
//  Created by Luis Eduardo Brime Gomez on 9/17/18.
//  Copyright © 2018 Luis Eduardo Brime Gomez. All rights reserved.
//

import UIKit

class LabsTableViewController: UITableViewController, UISearchResultsUpdating {
    
    var piso : String = "Piso 0"
    
    var filterData = [Any]()
    let searchController = UISearchController(searchResultsController: nil)
    
    func updateSearchResults(for searchController: UISearchController) {
        if searchController.searchBar.text! == "" {
            filterData = newArray!
        } else {
            filterData = newArray!.filter {
                let lab = $0 as! [String:Any]
                let s : String = lab["nombre"] as! String
                return(s.lowercased().contains(searchController.searchBar.text!.lowercased()))
            }
        }
        
        self.tableView.reloadData()
    }
    
    let address = "http://martinmolina.com.mx/201813/data/A01334886/milenio.json"
    
    var newArray : [Any]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        let url = URL(string: address)
        let data = try? Data(contentsOf: url!)
        newArray = try! JSONSerialization.jsonObject(with: data!) as? [Any]
        
        filterData = newArray!
        let t = getTrayect(t: piso)
        filterData = filterData.filter {
            let lab = $0 as! [String:Any]
            let s : String = lab["piso"] as! String
            return(s == t)
        }
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return (filterData.count)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EntradaLab", for: indexPath)

        // Configure the cell...
        let lab = filterData[indexPath.row] as! [String:Any]
        let s : String = lab["nombre"] as! String
        
        cell.textLabel?.text = s
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var i = 0
        var labs = [String:Any]()
        
        let nextView = self.storyboard?.instantiateViewController(withIdentifier: "LabDetail") as! LabDetailViewController
        
        i = indexPath.row
        labs = filterData[i] as! [String:Any]

        let s : String = labs["nombre"] as! String
        let s3 : String = labs["piso"] as! String
        let s4 : String = labs["id"] as! String
        let s6 : String = labs["trayectoria"] as! String
        
        let ims : [String] = labs["imagenes"] as! [String]
        
        if s != "" {    nextView.nombre = s }
        if s3 != "" {   nextView.piso = s3 }
        if s4 != "" {   nextView.ubicacion = s4 }
        if s6 != "" {   nextView.trayectoria = s6 }
        
        nextView.imgs = ims
        
        self.navigationController?.pushViewController(nextView, animated: true)
    }

    func getTrayect(t trayect : String) -> String {
        let number = trayect.last!
        let ans:String? = String(number)
        return ans!
    }

}
