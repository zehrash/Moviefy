//
//  HomeViewController.swift
//  Moviefy
//
//  Created by Zehra Iliyaz on 10.02.21.
//

import UIKit

class MovieListViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var endpointType:MovieAPIResources?
    var movies = [MovieModel] ()
    var model = MovieListModel ()
    
    @IBOutlet weak var collectionView: UICollectionView!
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (movies.count)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath) as! MovieCollectionViewCell
    
        cell.setup(with: movies[indexPath.row] as MovieModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(movies[indexPath.row] as MovieModel )
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        getMovies()
    }
    private func getMovies(){
        
        model.getMovies(with: endpointType!, format:.api_key.self, language: .language.self){
            result in
            self.movies = result
            self.collectionView.reloadData()
        }
    }
}
