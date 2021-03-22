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
    private func setImages(){
        
            self.movieModel?.backdropImage = self.movieBackdrop.image?.jpegData(compressionQuality: 1.0)
            self.movieModel?.posterImage = self.moviePoster.image?.jpegData(compressionQuality: 1.0)
    }
    private func getMovieDetails(){
        
        movieDetailsModel.getMovieDetails(with: movieID, language: .language.self){
            result in
            self.movieModel = result
            
            self.movieTitle.text = self.movieModel?.title
            self.movieScore.text = "\(self.movieModel?.voteAverage)"
            self.releaseDate.text = self.movieModel?.releaseDate
            self.movieOverview.text = self.movieModel?.overview
            
            if let posterURL = self.movieModel?.posterURL{
                Nuke.loadImage(with: ImageRequest(url: posterURL), into: self.moviePoster)
            }
            if let backdropURL = self.movieModel?.backdropURL{
                Nuke.loadImage(with: ImageRequest(url: backdropURL), into: self.movieBackdrop)
            }
            /*
            Nuke.loadImage(with: self.movieModel!.posterURL!,
                           into: self.moviePoster)
            Nuke.loadImage(with: self.movieModel!.backdropURL!,
                           into: self.movieBackdrop)
      */
        }
       
    }
    @IBAction func onWatchLaterButtonClick(_ sender: Any) {
        
       setImages()
       CoreDataManager.sharedManager.saveToWatchLater(username: "user", movie: self.movieModel!)
        
    }
    
    
    
    @IBAction func onWatchedButtonClick(_ sender: Any) {
    
    setImages()
        CoreDataManager.sharedManager.saveToWatchedList(username: "user", movie: self.movieModel!)
    }

    
}
