//
//  MoviesCell.swift
//  MyMovies
//
//  Created by NCS Pro on 18/11/22.
//

import UIKit
import Kingfisher

class MoviesCell: UITableViewCell {

    @IBOutlet weak var ivPoster: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbReleaseDate: UILabel!
    @IBOutlet weak var lbRating: UILabel!
    
    func setItem(data: MovieList){
        
        lbTitle.text = data.title
        lbReleaseDate.text = String(data.releaseDate.prefix(4))
        lbRating.text = String(data.voteAverage)
        
        let url = URL(string: Endpoint.IMAGE_URL + data.posterPath)
        ivPoster.kf.setImage(with: url)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
