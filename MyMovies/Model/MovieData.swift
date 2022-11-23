//
//  MoviesDetail.swift
//  MyMovies
//
//  Created by NCS Pro on 16/11/22.
//

import Foundation

// MARK: - MovieData
struct MovieData: Codable {
    let homepage: String
    let id: Int
    let originalLanguage, originalTitle, overview, posterPath: String
    let backdropPath, releaseDate: String
    let runtime: Int
    let tagline, title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int
    let videos: Videos
    let genres: [GenreList]

    enum CodingKeys: String, CodingKey {
        case homepage, id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case releaseDate = "release_date"
        case runtime, tagline, title, video, genres
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case videos
    }
}

// MARK: - Genre
struct GenreList: Codable {
    let id: Int
    let name: String
}

// MARK: - Videos
struct Videos: Codable {
    let results: [Result]
}

// MARK: - Result
struct Result: Codable {
    let name, key, site, type: String
    let official: Bool
}

