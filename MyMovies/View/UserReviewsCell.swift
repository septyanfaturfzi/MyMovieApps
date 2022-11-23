//
//  UserReviewsCell.swift
//  MyMovies
//
//  Created by NCS Pro on 17/11/22.
//

import UIKit

class UserReviewsCell: UITableViewCell {

    @IBOutlet weak var ivProfile: UIImageView!
    @IBOutlet weak var lbAuthor: UILabel!
    @IBOutlet weak var lbCreatedAt: UILabel!
    @IBOutlet weak var lbContent: UILabel!
    
    func setItem(data: Results){
    
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd MMM yyyy"

        if let date = dateFormatterGet.date(from: data.createdAt ?? "") {
            let dateFormatted = dateFormatterPrint.string(from: date)
            
            lbAuthor.text = data.author
            lbCreatedAt.text = "Written on \(dateFormatted)"
            lbContent.text = data.content
        } else {
           print("There was an error decoding the string")
        }
        
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
