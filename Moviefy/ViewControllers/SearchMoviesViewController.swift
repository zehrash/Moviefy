//
//  SearchMoviesViewController.swift
//  Moviefy
//
//  Created by Zehra Iliyaz on 1.03.21.
//

import UIKit
import Nuke

class SearchMoviesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var movies:[MovieModel]? 
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as! SearchMoviesTableViewCell
        
        cell.labelOutlet.text = movies?[indexPath.row].title
        
        Nuke.loadImage(with: movies?[indexPath.row].posterURL as! ImageRequestConvertible,
                       into: cell.imageOutlet)
        
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

   

}
