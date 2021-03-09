//
//  HomeViewController.swift
//  Moviefy
//
//  Created by Zehra Iliyaz on 10.02.21.
//

import UIKit

class MovieListViewController: UIViewController{
    
    var endpointType:MovieAPIResources?
    var movies = [MovieModel] ()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        getMovies()
    }
    private func getMovies(){
        
        MovieListModel.getMovies(with: endpointType!,language: .language.self){
            result in
            self.movies = result
            self.collectionView.reloadData()
        }
    }
}
extension MovieListViewController: UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let viewController = storyboard?.instantiateViewController(identifier: "DetailedMovieViewControllerID") as? DetailedMovieViewController {
            viewController.movieID = movies[indexPath.row].id
            self.present(viewController, animated: true)
        }
    }
}

extension MovieListViewController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath) as! MovieCollectionViewCell
    
        cell.setup(with: movies[indexPath.row])
        return cell
    }
}
