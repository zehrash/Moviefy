//
//  WatchedViewController.swift
//  Moviefy
//
//  Created by Zehra Iliyaz on 10.02.21.
//
// swiftlint:disable force_cast
import UIKit

class WatchedViewController: UIViewController {
    var movies:[MovieModel] = []
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        loadMovies()
    }
    private func loadMovies(){
       movies = CoreDataHelper().getWatchedList()
        // CoreDataManager.sharedManager.fetchWatchLaterListMovies(username: "zizi")
    }
}
extension WatchedViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "WatchedCell", for: indexPath)
            as! WatchedListTableViewCell
        cell.setup(with: (movies[indexPath.row]))
        return cell
    }
}

extension WatchedViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let viewController =
            storyboard?.instantiateViewController(identifier: "DetailedMovieViewControllerID")
            as? DetailedMovieViewController {
            viewController.movieID = (movies[indexPath.row].id)
            self.present(viewController, animated: true)
        }
    }
}
