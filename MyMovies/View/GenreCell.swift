//
//  GenreCell.swift
//  MyMovies
//
//  Created by NCS Pro on 17/11/22.
//

import UIKit

class GenreCell: UITableViewCell {

    @IBOutlet weak var lbGenreName: UILabel!
    
    func setItem(data: GenreElement){
        lbGenreName.text = data.name
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
