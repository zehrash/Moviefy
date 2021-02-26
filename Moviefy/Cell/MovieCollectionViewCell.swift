//
//  MovieCollectionViewCell.swift
//  Moviefy
//
//  Created by Zehra Iliyaz on 19.02.21.
//

import UIKit
import Nuke

class MovieCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    
    
    func setup(with movie: MovieModel) {
        Nuke.loadImage(with: movie.posterURL,
                       into: movieImageView)
        movieTitleLabel.text = movie.title
       }
}
