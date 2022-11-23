//
//  YoutubePlayerVC.swift
//  MyMovies
//
//  Created by NCS Pro on 21/11/22.
//

import UIKit
import youtube_ios_player_helper

class YoutubePlayerVC: UIViewController {
    
    @IBOutlet weak var playerView: YTPlayerView!
    
    var videoId: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playerView.load(withVideoId: videoId, playerVars: ["playsinline": "1"])
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
