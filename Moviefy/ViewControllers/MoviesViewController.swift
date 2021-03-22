//
//  MoviesViewController.swift
//  Moviefy
//
//  Created by Zehra Iliyaz on 22.02.21.
//
// swiftlint:disable force_cast
import UIKit

class MoviesViewController: UIViewController{
    
    @IBOutlet weak var tableView: UITableView!
    let allImages = [UIImage(named: "popular"), UIImage(named: "trending"), UIImage(named: "top_rated"), UIImage(named: "upcoming")]
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: selectedIndexPath, animated: animated)
        }
    }
    
    func getCategoryType(typeNumber: Int) ->MovieAPIResources{
        switch typeNumber {
            case 0:
                return .popular.self
            case 1:
                return .trending.self
            case 2:
                return .topRated.self
            default:
                return .upcoming.self
            }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension MoviesViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allImages.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell=tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CategoryTableViewCell

        cell.categoryImage.image=allImages[indexPath .row]
        return cell
    }
}

extension MoviesViewController: UITableViewDelegate{
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         
         if let viewController = storyboard?.instantiateViewController(identifier: "MovieListViewControllerID") as? MovieListViewController {
             viewController.endpointType = getCategoryType(typeNumber: indexPath.row)
             self.present(viewController, animated: true)
         }
     }
}
