//
//  TrendingTv.swift
//  TMDB_Project_v2
//
//  Created by Oleksandr Sushchenko on 13.12.2022.
//


import Foundation

struct TrendingTv : Codable {
	let page : Int?
	let results : [TvResults]?
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
struct TvResults : Codable {
    let adult : Bool?
    let backdrop_path : String?
    let id : Int?
    let name : String?
    let originalLanguage : String?
    let original_name : String?
    let overview : String?
    let poster_path : String?
    let media_type : String?
    let genreIds : [Int]?
    let popularity : Double?
    let first_air_date : String?
    let voteAverage : Double?
    let vote_count : Int?
    let origin_country : [String]?

    enum CodingKeys: String, CodingKey {

        case adult = "adult"
        case backdrop_path = "backdrop_path"
        case id = "id"
        case name = "name"
        case originalLanguage = "original_language"
        case original_name = "original_name"
        case overview = "overview"
        case poster_path = "poster_path"
        case media_type = "media_type"
        case genreIds = "genre_ids"
        case popularity = "popularity"
        case first_air_date = "first_air_date"
        case voteAverage = "vote_average"
        case vote_count = "vote_count"
        case origin_country = "origin_country"
    }

}
