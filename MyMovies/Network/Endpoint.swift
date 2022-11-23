//
//  Endpoint.swift
//  MyMovies
//
//  Created by NCS Pro on 16/11/22.
//

import Foundation

struct Endpoint {
    
    // TMDB URL
    static let BASE_URL                         = "https://api.themoviedb.org/3/"
    static let IMAGE_URL                        = "https://image.tmdb.org/t/p/w500/"
    
    static let GENRE_LIST_URL                   = BASE_URL + "genre/movie/list"
    static let MOVIE_LIST_URL                   = BASE_URL + "discover/movie"
    static let MOVIE_DETAIL_URL                 = BASE_URL + "movie/"
    static let USER_REVIEWS_URL                 = BASE_URL + "movie/"
}
