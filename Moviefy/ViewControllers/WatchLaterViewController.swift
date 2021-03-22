//
//  WatchLaterViewController.swift
//  Moviefy
//
//  Created by Zehra Iliyaz on 10.02.21.
//

import UIKit
// swiftlint:disable force_cast
class WatchLaterViewController: UIViewController {
   
    var movies:[MovieModel?] = []
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        loadMovies()
        // Do any additional setup after loading the view.
    }

    private func loadMovies(){
        movies = CoreDataManager.sharedManager.fetchWatchLaterListMovies(username: "zizi")
     //     self.collectionView.reloadData()
    }
   
}
extension WatchLaterViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as! SearchMoviesTableViewCell
        
        cell.setup(with: (movies[indexPath.row])!)
        return cell
    }
}

extension WatchLaterViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let viewController = storyboard?.instantiateViewController(identifier: "DetailedMovieViewControllerID") as? DetailedMovieViewController {
            viewController.movieID = (movies[indexPath.row]?.id) as! Int
            self.present(viewController, animated: true)
        }
    }
    
    
}
