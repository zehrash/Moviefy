//
//  ExpandedMovieViewController.swift
//  Moviefy
//
//  Created by Zehra Iliyaz on 10.02.21.
//

import UIKit
import Nuke


class DetailedMovieViewController: UIViewController {

    var movieID: Int = 0
    var movieModel: MovieModel?
    let movieDetailsModel = MovieDetailsModel ()
    
    @IBOutlet weak var movieOverview: UITextView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieScore: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieBackdrop: UIImageView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getMovieDetails()
    }
    
    private func getMovieDetails(){
        
        movieDetailsModel.getMovieDetails(with: movieID, language: .language.self){
            result in
            self.movieModel = result
            
            self.movieTitle.text = self.movieModel?.title
            self.movieScore.text = "\(self.movieModel?.voteAverage)"
            self.releaseDate.text = self.movieModel?.releaseDate
            self.movieOverview.text = self.movieModel?.overview
            
            
            Nuke.loadImage(with: self.movieModel?.posterURL as! ImageRequestConvertible,
                           into: self.moviePoster)
            Nuke.loadImage(with: self.movieModel?.backdropURL as! ImageRequestConvertible,
                           into: self.movieBackdrop)
            
           // self.collectionView.reloadData()
        }
    }

}
