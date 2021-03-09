//
//  SearchMoviesTableViewCell.swift
//  Moviefy
//
//  Created by Zehra Iliyaz on 2.03.21.
//

import UIKit
import Nuke

class SearchMoviesTableViewCell: UITableViewCell {

   
    @IBOutlet weak var imageOutlet: UIImageView!
    @IBOutlet weak var labelOutlet: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(with movie: MovieModel) {
        Nuke.loadImage(with: movie.posterURL!,
                       into: imageOutlet)
        labelOutlet.text = movie.title
       }

}
