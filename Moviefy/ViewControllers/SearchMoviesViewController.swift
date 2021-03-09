//
//  SearchMoviesViewController.swift
//  Moviefy
//
//  Created by Zehra Iliyaz on 1.03.21.
//

import UIKit
import Nuke

class SearchMoviesViewController: UIViewController{
    
    @IBOutlet weak var tableView: UITableView!
    
    var movies:[MovieModel]? 
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}
extension SearchMoviesViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as! SearchMoviesTableViewCell
        
        cell.setup(with: (movies?[indexPath.row])!)
        return cell
    }
}

extension SearchMoviesViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let viewController = storyboard?.instantiateViewController(identifier: "DetailedMovieViewControllerID") as? DetailedMovieViewController {
            viewController.movieID = (movies![indexPath.row].id)
            self.present(viewController, animated: true)
        }
    }
    
    
}
