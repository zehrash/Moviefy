//
//  MovieCollectionViewCell.swift
//  Moviefy
//
//  Created by Zehra Iliyaz on 19.02.21.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    private var movie: MovieModel?
    
    func setMovieModel(from: MovieModel?){
        movie = from
        self.setup(with: movie)
    }
    func getMovieModel()->MovieModel?{
        return movie
    }
    
    func setup(with movie: MovieModel?) {
        movieImageView.image = movie?.thumbnail
        movieTitleLabel.text = movie?.title
       }
}
