//
//  MovieListVC.swift
//  MyMovies
//
//  Created by NCS Pro on 17/11/22.
//

import UIKit
import Alamofire
import SwiftyJSON
import CRRefresh

class MovieListVC: UIViewController {
    
    @IBAction func btBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var lbToolbarTitle: UILabel!
    @IBOutlet weak var lbGenre: UILabel!
    @IBOutlet weak var tvMovieList: UITableView!
    
    var id: String = ""
    var name: String = ""
    var movieList = [MovieList]()
    var currentPage: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lbGenre.text = name
        setupTableView(id: id)
    }
    
    func setupTableView(id: String){
        tvMovieList.delegate = self
        tvMovieList.dataSource = self
        
        let nib = UINib(nibName: "MoviesCell", bundle: nil)
        tvMovieList.register(nib, forCellReuseIdentifier: "MoviesCell")
        
        tvMovieList.cr.addHeadRefresh(animator: NormalHeaderAnimator()) { [weak self] in
            self?.AFgetMovieList(genre: id, pageNumber: self!.currentPage)
        }
        self.tvMovieList.cr.beginHeaderRefresh()
    }
    
    func AFgetMovieList(genre: String, pageNumber: Int){
        
        let param: Parameters = [
            Key.PARAM_API_KEY: Key.API_KEY,
            Key.PARAM_SORT_BY: "vote_count.desc",
            Key.PARAM_GENRES: genre,
            Key.PARAM_PAGE: pageNumber
        ]
        
        let url = Endpoint.MOVIE_LIST_URL
        
        AF.request(url, method: .get, parameters: param, encoding: URLEncoding(destination: .queryString)).validate().responseData { response in
            
            switch response.result {
                
            case .success(let value):
                do {
                    let json = JSON(value)
                    let data = try json["results"].rawData()
                    let decodeJson = JSONDecoder()
                    self.movieList.append(contentsOf: try decodeJson.decode([MovieList].self, from: data))
                    
                    self.tvMovieList.cr.endHeaderRefresh()
                    self.tvMovieList.reloadData()
                    
                    print("Response success: \(JSON(data))")
                } catch {
                    print("Error info: \(error)")
                }
            case .failure(let error):
                print("Response error: \(error)")
            }
            
        }
        
    }
    
    func AFgetMovieDetail(id: Int){
        
        let param: Parameters = [
            Key.PARAM_API_KEY: Key.API_KEY,
            Key.PARAM_APPEND_TO_RESPONSE: "videos"
        ]
        
        let url = Endpoint.MOVIE_DETAIL_URL + String(id)
        AF.request(url, method: .get, parameters: param, encoding: URLEncoding(destination: .queryString)).validate().responseData { response in
            
            switch response.result {
                
            case .success(let value):
                do {
                    let json = JSON(value)
                    let data = try json.rawData()
                    let decodeJson = JSONDecoder()
                    let movieData = try decodeJson.decode(MovieData.self, from: data)
                    
                    let mainView = UIStoryboard.init(name: "Main", bundle: nil)
                    let target = mainView.instantiateViewController(withIdentifier: "MovieDetailView") as! MovieDetailVC
                    target.modalPresentationStyle = .fullScreen
                    target.movieData = movieData
                    self.present(target, animated: true, completion: nil)
                    
                    print("Response success: \(JSON(data))")
                } catch {
                    print("Error info: \(error)")
                }
            case .failure(let error):
                print("Response error: \(error)")
            }
            
        }
    }
    
}

extension MovieListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MoviesCell", for: indexPath) as! MoviesCell
        let data = movieList[indexPath.row]
        cell.setItem(data: data)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        if cell?.isSelected == true {
            let id = movieList[indexPath.row].id
            self.AFgetMovieDetail(id: id)
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastItem = self.movieList.count - 1
        if indexPath.row == lastItem {
            print("IndexRow\(indexPath.row)")
            currentPage += 1
            self.AFgetMovieList(genre: id, pageNumber: currentPage)
        }
    }
}
