//
//  Movies.swift
//  MovieDemoAppTMDBAPI
//
//  Created by Erem Karalar on 3.05.2021.
//

import Foundation

struct MovieResponse: Decodable {
    
    let results: [Movie]
}

struct Movie : Codable{
        var id: Int
        var title: String
        var poster_path : String
        var overview: String
        var release_date: String
        var original_language: String
        var popularity: Double
        var vote_average: Double
        var posterURL: URL {
            return URL(string: "https://image.tmdb.org/t/p/w500\(poster_path )")!
        }
}
