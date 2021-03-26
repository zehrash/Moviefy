//
//  WatchedLisTableViewCell.swift
//  Moviefy
//
//  Created by Zehra Iliyaz on 26.03.21.
//

import UIKit

class WatchedListTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var posterOutlet: UIImageView!
    @IBOutlet weak var titleOutlet: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setup(with movie: MovieModel) {
        if let posterData = movie.posterImage, let posterImage = UIImage(data: posterData) {
            self.posterOutlet.image = posterImage
        }
        self.titleOutlet.text = movie.title
    }
}
