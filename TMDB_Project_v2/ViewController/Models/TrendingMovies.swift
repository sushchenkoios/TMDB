//
//  TrendingMovies.swift
//  TMDB_Project_v2
//
//  Created by Oleksandr Sushchenko on 13.12.2022.
//

import Foundation


struct TrendingMovies : Codable {
    let page : Int?
    let results : [MovieResults]?
    let total_pages : Int?
    let total_results : Int?
    
    enum CodingKeys: String, CodingKey {
        
        case page = "page"
        case results = "results"
        case total_pages = "total_pages"
        case total_results = "total_results"
    }
}

// MARK: - Result
struct MovieResults : Codable {
    let adult : Bool?
    let backdrop_path : String?
    let id : Int?
    let title : String
    let originalLanguage : String?
    let original_title : String?
    let overview : String?
    let poster_path : String?
    let media_type : String?
    let genreIds : [Int]?
    let popularity : Double?
    let release_date : String?
    let video : Bool?
    let voteAverage : Double?
    let vote_count : Int?

    enum CodingKeys: String, CodingKey {

        case adult = "adult"
        case backdrop_path = "backdrop_path"
        case id = "id"
        case title = "title"
        case originalLanguage = "original_language"
        case original_title = "original_title"
        case overview = "overview"
        case poster_path = "poster_path"
        case media_type = "media_type"
        case genreIds = "genre_ids"
        case popularity = "popularity"
        case release_date = "release_date"
        case video = "video"
        case voteAverage = "vote_average"
        case vote_count = "vote_count"
    }


}
