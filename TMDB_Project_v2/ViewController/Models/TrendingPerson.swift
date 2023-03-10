//
//  TrendingPerson.swift
//  TMDB_Project_v2
//
//  Created by Oleksandr Sushchenko on 02.03.2023.
//

import Foundation

// MARK: - TrendingPerson
struct TrendingPerson: Codable {
    let page: Int?
    let results: [PersonResult]?
    let totalPages: Int?
    let totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - PersonResult
struct PersonResult: Codable {
    let adult: Bool?
    let id: Int?
    let name, originalName: String?
    let mediaType: String?
    let popularity: Double?
    let gender: Int?
    let knownForDepartment: String?
    let profilePath: String?
    let knownFor: [KnownForResult]?

    enum CodingKeys: String, CodingKey {
        case adult, id, name
        case originalName = "original_name"
        case mediaType = "media_type"
        case popularity, gender
        case knownForDepartment = "known_for_department"
        case profilePath = "profile_path"
        case knownFor = "known_for"
    }
}

// MARK: - KnownForResult
struct KnownForResult: Codable {
    let originalLanguage: String?
    let voteCount: Int?
    let mediaType: String?
    let id: Int?
    let adult: Bool?
    let backdropPath: String?
    let genreIDS: [Int]?
    let originalTitle, overview, posterPath, releaseDate, title: String?
    let video: Bool?
    let voteAverage: Double?
    let firstAirDate, name, originalName: String?

    enum CodingKeys: String, CodingKey {
        case originalLanguage = "original_language"
        case voteCount = "vote_count"
        case mediaType = "media_type"
        case id, adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case firstAirDate = "first_air_date"
        case name
        case originalName = "original_name"
    }
}


//
//// MARK: - TrendingPerson
//
//struct TrendingPerson : Codable {
//    let page : Int?
//    let results : [PersonResult]?
//    let total_pages : Int?
//    let total_results : Int?
//
//    enum CodingKeys: String, CodingKey {
//
//        case page = "page"
//        case results = "results"
//        case total_pages = "total_pages"
//        case total_results = "total_results"
//    }
//}
//// MARK: - PersonResult
//
//    struct PersonResult : Codable {
//        let adult : Bool?
//        let id : Int?
//        let name : String?
//        let original_name : String?
//        let media_type : String?
//        let popularity : Double?
//        let gender : Int?
//        let known_for_department : String?
//        let profilePath : String?
//        let known_for : [String]?
//
//        enum CodingKeys: String, CodingKey {
//
//            case adult = "adult"
//            case id = "id"
//            case name = "name"
//            case original_name = "original_name"
//            case media_type = "media_type"
//            case popularity = "popularity"
//            case gender = "gender"
//            case known_for_department = "known_for_department"
//            case profilePath = "profile_path"
//            case known_for = "known_for"
//        }
//    }
