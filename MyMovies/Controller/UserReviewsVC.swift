//
//  UserReviewsVC.swift
//  MyMovies
//
//  Created by NCS Pro on 17/11/22.
//

import UIKit
import Alamofire
import SwiftyJSON
import CRRefresh

class UserReviewsVC: UIViewController {

    @IBAction func btBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var lbToolbarTitle: UILabel!
    @IBOutlet weak var ivPoster: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbReleaseDate: UILabel!
    @IBOutlet weak var tvUserReview: UITableView!
    
    var result = [Results]()
    var movieData: MovieData?
    var currentPage: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView(id: String(movieData!.id))
        setupView()
    }
    
    func setupView(){
        lbTitle.text = movieData!.title
        lbReleaseDate.text = String(movieData!.releaseDate.prefix(4))
        
        let posterUrl = URL(string: Endpoint.IMAGE_URL + movieData!.posterPath)
        ivPoster.kf.setImage(with: posterUrl)
    }
    
    func setupTableView(id: String){
        tvUserReview.delegate = self
        tvUserReview.dataSource = self

        let nib = UINib(nibName: "UserReviewsCell", bundle: nil)
        tvUserReview.register(nib, forCellReuseIdentifier: "UserReviewsCell")

        tvUserReview.cr.addHeadRefresh(animator: NormalHeaderAnimator()) { [weak self] in
            self?.AFgetUserReviews(id: id, pageNumber: self!.currentPage)
        }
        self.tvUserReview.cr.beginHeaderRefresh()
    }
    
    func AFgetUserReviews(id: String, pageNumber: Int){
        
        let param: Parameters = [
            Key.PARAM_API_KEY: Key.API_KEY,
            Key.PARAM_PAGE: pageNumber
        ]
        
        let url = Endpoint.USER_REVIEWS_URL + id + "/reviews"
        
        AF.request(url, method: .get, parameters: param, encoding: URLEncoding(destination: .queryString)).validate().responseData { response in
        
            switch response.result {
                
            case .success(let value):
                do {
                    let json = JSON(value)
                    let data = try json["results"].rawData()
                    let decodeJson = JSONDecoder()
                    self.result.append(contentsOf: try decodeJson.decode([Results].self, from: data))
                    
                    self.tvUserReview.cr.endHeaderRefresh()
                    self.tvUserReview.reloadData()
                    
                    print("Response success user: \(JSON(data))")
                } catch {
                    print("Error info: \(error)")
                }
            case .failure(let error):
                print("Response error: \(error)")
            }
            
        }
        
    }

}

extension UserReviewsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return result.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserReviewsCell", for: indexPath) as! UserReviewsCell
        let data = result[indexPath.row]
        cell.setItem(data: data)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastItem = self.result.count - 1
        if indexPath.row == lastItem {
            print("IndexRow\(indexPath.row)")
            currentPage += 1
            self.AFgetUserReviews(id: String(movieData!.id), pageNumber: currentPage)
        }
    }
    
}
