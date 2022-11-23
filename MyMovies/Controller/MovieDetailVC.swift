//
//  MovieDetailVC.swift
//  MyMovies
//
//  Created by NCS Pro on 17/11/22.
//

import UIKit
import Kingfisher
import SwiftyJSON

class MovieDetailVC: UIViewController {
    
    @IBAction func btBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btPlayTrailer(_ sender: Any) {
        let mainView = UIStoryboard.init(name: "Main", bundle: nil)
        let target = mainView.instantiateViewController(withIdentifier: "YoutubePlayerView") as! YoutubePlayerVC
        target.modalPresentationStyle = .pageSheet
        target.videoId = movieData!.videos.results.last!.key
        self.present(target, animated: true, completion: nil)
    }
    
    @IBAction func btUserReview(_ sender: Any) {
        let mainView = UIStoryboard.init(name: "Main", bundle: nil)
        let target = mainView.instantiateViewController(withIdentifier: "UserReviewsView") as! UserReviewsVC
        target.modalPresentationStyle = .fullScreen
        target.movieData = movieData
        self.present(target, animated: true, completion: nil)
    }
    
    @IBOutlet weak var lbToolbarTitle: UILabel!
    @IBOutlet weak var ivBackdrop: UIImageView!
    @IBOutlet weak var ivPoster: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbReleaseDate: UILabel!
    @IBOutlet weak var lbGenre: UILabel!
    @IBOutlet weak var lbRating: UILabel!
    @IBOutlet weak var lbVoters: UILabel!
    @IBOutlet weak var lbLanguage: UILabel!
    @IBOutlet weak var lbRunningTime: UILabel!
    @IBOutlet weak var lbTagline: UILabel!
    @IBOutlet weak var lbOverview: UILabel!
    
    var movieData: MovieData?
    var genreName: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        // Do any additional setup after loading the view.
    }
    
    func setupView(){
        lbTitle.text = movieData?.title
        lbReleaseDate.text = movieData?.releaseDate
        lbRating.text = String(movieData!.voteAverage)
        lbVoters.text = "\(movieData!.voteCount) voters"
        lbLanguage.text = movieData?.originalLanguage
        lbRunningTime.text = "\(String(movieData!.runtime)) mins"
        lbTagline.text = movieData?.tagline
        lbOverview.text = movieData?.overview
        
        let posterUrl = URL(string: Endpoint.IMAGE_URL + movieData!.posterPath)
        let backdropUrl = URL(string: Endpoint.IMAGE_URL + movieData!.backdropPath)
        ivPoster.kf.setImage(with: posterUrl)
        ivBackdrop.kf.setImage(with: backdropUrl)
        
        for i in 0 ..< movieData!.genres.count {
            genreName.append("\(movieData!.genres[i].name), ")
            if i == movieData!.genres.count - 1 {
                genreName.append("\(movieData!.genres[i].name) ")
            }
        }
        lbGenre.text = genreName
        
        
//        print("ini link: \(movieData!.videos.results.last?.key))")
        
//        for i in 0 ..< movieData!.videos.results.count {
//            print("videos: \(movieData!.videos.results[i])")
//            if movieData!.videos.results[i].type == "Trailer"
//                && movieData!.videos.results[i].official == true {
//                print("ini link: \(movieData!.videos.results.last?.key)")
//            }
//        }
        
    }
    
}
