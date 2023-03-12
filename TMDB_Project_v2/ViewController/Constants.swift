//
//  Constants.swift
//  TMDB_Project_v2
//
//  Created by Oleksandr Sushchenko on 05.12.2022.
//

import Foundation

enum Url {
    static let urlBase = "https://api.themoviedb.org/3/"
    static let urlApiKey = "api_key=252c9bc8a678428064e9f48a065caabc"
    static let urlTrendingMovie = "https://api.themoviedb.org/3/trending/movie/week?"
    static let urlTrendingTv = "https://api.themoviedb.org/3/trending/tv/week?"
    static let urlTrendingPerson = "https://api.themoviedb.org/3/trending/person/week?"
    static let urlLanguageUk = "&language=uk"
    static let urlLanguageUS = "&language=en-US"
    static let urlImagePoster = "https://image.tmdb.org/t/p/w500"
    
    static let urlSearchMovies = "search/movie?"
    static let urlSearchTV = "search/tv?"
    static let urlquery = "&query="
    
    static let urlGenresMovie = "genre/movie/list?"
    static let urlGenresTV = "genre/tv/list?"
 }






