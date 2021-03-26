//
//  WatchLaterViewController.swift
//  Moviefy
//
//  Created by Zehra Iliyaz on 10.02.21.
//
// swiftlint:disable force_cast
// swiftlint:disable opening_brace
import UIKit

class WatchLaterViewController: UIViewController {
    var movies:[MovieModel] = []
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        loadMovies()
    }
    private func loadMovies(){
       movies = CoreDataHelper().getWatchLaterList()
       // CoreDataManager.sharedManager.fetchWatchLaterListMovies(username: "zizi")
    }
}

extension WatchLaterViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "WatchLaterCell", for: indexPath)
            as! WatchLaterListTableViewCell
        cell.setup(with: (movies[indexPath.row]))
        return cell
    }
}

extension WatchLaterViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let viewController =
            storyboard?.instantiateViewController(identifier: "DetailedMovieViewControllerID")
            as? DetailedMovieViewController {
            viewController.movieID = (movies[indexPath.row].id)
            self.present(viewController, animated: true)
        }
    }
}
