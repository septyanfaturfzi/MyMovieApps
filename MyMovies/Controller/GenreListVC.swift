//
//  GenreListVC.swift
//  MyMovies
//
//  Created by NCS Pro on 17/11/22.
//

import UIKit
import Alamofire
import SwiftyJSON
import CRRefresh

class GenreListVC: UIViewController {
    
    @IBOutlet weak var tvGenreList: UITableView!
    
    var genres = [GenreElement]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        
    }
    
    func setupTableView(){
        tvGenreList.delegate = self
        tvGenreList.dataSource = self
        
        let nib = UINib(nibName: "GenreCell", bundle: nil)
        tvGenreList.register(nib, forCellReuseIdentifier: "GenreCell")
        
        tvGenreList.cr.addHeadRefresh(animator: NormalHeaderAnimator()) { [weak self] in
            self?.AFgetGenre()
        }
        self.tvGenreList.cr.beginHeaderRefresh()
    }
    
    func AFgetGenre(){
        self.genres.removeAll()
        self.tvGenreList.reloadData()
        
        let param: Parameters = [
            Key.PARAM_API_KEY: Key.API_KEY
        ]
        
        let url = Endpoint.GENRE_LIST_URL
        AF.request(url, method: .get, parameters: param, encoding: URLEncoding(destination: .queryString)).validate().responseData { response in
            
            switch response.result {
                
            case .success(let value):
                do {
                    let json = JSON(value)
                    let data = try json["genres"].rawData()
                    let decodeJson = JSONDecoder()
                    self.genres = try decodeJson.decode([GenreElement].self, from: data)
                    
                    self.tvGenreList.cr.endHeaderRefresh()
                    self.tvGenreList.reloadData()
                    
                    print("Response genre: \(json)")
                } catch {
                    print("error")
                }
            case .failure(let error):
                print("Response error: \(error)")
            }
            
        }
        
    }
}

extension GenreListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return genres.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GenreCell", for: indexPath) as! GenreCell
        let data = genres[indexPath.row]
        cell.setItem(data: data)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        if cell?.isSelected == true {
            let id = genres[indexPath.row].id
            let name = genres[indexPath.row].name
            
            let mainView = UIStoryboard.init(name: "Main", bundle: nil)
            let target = mainView.instantiateViewController(withIdentifier: "MovieListView") as! MovieListVC
            target.modalPresentationStyle = .fullScreen
            target.id = String(id)
            target.name = name
            self.present(target, animated: true, completion: nil)
            
        }
    }
}

