//
//  Genre.swift
//  MyMovies
//
//  Created by NCS Pro on 16/11/22.
//

import Foundation

// MARK: - Genre
struct Genre: Codable {
    let genres: [GenreElement]
}

// MARK: - GenreElement
struct GenreElement: Codable {
    let id: Int
    let name: String
}
