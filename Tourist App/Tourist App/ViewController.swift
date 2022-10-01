//
//  ViewController.swift
//  Tourist App
//
//  Created by Shaoshuai Xu on 9/24/22.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let TouristPlacesNames = ["Space Needle", "Museum of Pop Culture", "Pike Place Market", "Seattle Art Museum"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TouristPlacesNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("TouristCell", owner: self)?.first as! TouristCell
        
        cell.img.image = UIImage(named: TouristPlacesNames[indexPath.row])
        cell.label.text = TouristPlacesNames[indexPath.row]
        
        return cell
    }
}

