//
//  WatchLaterListTableViewCell.swift
//  Moviefy
//
//  Created by Zehra Iliyaz on 26.03.21.
//

import UIKit

class WatchLaterListTableViewCell: UITableViewCell {

    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setup(with movie: MovieModel) {
        if let posterData = movie.posterImage, let posterImage = UIImage(data: posterData){
            self.movieImage.image = posterImage
        }
        self.movieTitle.text = movie.title
    }
}

