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
        let id: Int
        let title: String
//        let posterPath: String?
        var poster_path : String
        var posterURL: URL {
            return URL(string: "https://image.tmdb.org/t/p/w500\(poster_path ?? "")")!
        }
}
struct MovieUrls : Codable{
    let posterPath: String
    //var regular : String
}
