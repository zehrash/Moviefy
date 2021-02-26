//
//  MoviesViewController.swift
//  Moviefy
//
//  Created by Zehra Iliyaz on 22.02.21.
//

import UIKit

class MoviesViewController: UIViewController,UITableViewDataSource,UITableViewDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    let allImages = [UIImage(named: "popular"), UIImage(named: "trending"), UIImage(named: "top_rated"), UIImage(named: "upcoming")]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CategoryTableViewCell
        
        let image = allImages[indexPath .row]
        cell.categoryImage.image=image
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let viewController = storyboard?.instantiateViewController(identifier: "MovieListViewControllerID") as? MovieListViewController {
            viewController.endpointType = getCategoryType(typeNumber: indexPath.row)
            self.present(viewController, animated: true)
           // navigationController?.pushViewController(viewController, animated: true)
        }
    }
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
                return .top_rated.self
            default:
                return .upcoming.self
            }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
