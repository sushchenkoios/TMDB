//
//  NetworkService.swift
//  TMDB_Project_v2
//
//  Created by Oleksandr Sushchenko on 15.02.2023.
//

import UIKit
import Alamofire

class NetworkService {
    static let shared = NetworkService()
    
    //MARK: - Movie decoder JSON
    func fetchTrendingMovies(completion: @escaping (Result<[MovieResults], Error>) -> Void) {
        
        let urlMovie = AF.request(Url.urlTrendingMovie + Url.urlApiKey, method: .get)
    
        urlMovie.responseDecodable(of: TrendingMovies.self) { response in
            switch response.result {
            case .success(let trendingMovies):
                let movies = trendingMovies.results ?? []
                completion(.success(movies))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    //MARK: - TV decoder JSON
    func fetchTrendingTV(completion: @escaping (Result<[TvResults], Error>) -> Void) {
        
        let urlTv = AF.request(Url.urlTrendingTv + Url.urlApiKey, method: .get)
       
        urlTv.responseDecodable(of: TrendingTv.self) { responce in
            
            switch responce.result {
            case .success(let trendingTv):
                let TV = trendingTv.results ?? []
                completion(.success(TV))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    //MARK: - Person decoder JSON
    func fetchTrendingPerson(completion: @escaping (Result<[PersonResult], Error>) -> Void) {
        
        let urlPerson = AF.request(Url.urlTrendingPerson + Url.urlApiKey, method: .get)
    
        urlPerson.responseDecodable(of: TrendingPerson.self) { response in

            switch response.result {
            case .success(let trendingPerson):
                let persons = trendingPerson.results ?? []
                completion(.success(persons))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
        //MARK: - Movie Genres JSON
    func fetchGenresMovie(completion: @escaping (Result<[GenresResults], Error>) -> Void) {

        let urlGenres = AF.request(Url.urlBase + Url.urlGenresMovie + Url.urlApiKey, method: .get)

        urlGenres.responseDecodable(of: Genres.self) { response in
            switch response.result {
            case .success(let genres):
                let genresArray = genres.genres ?? []
                completion(.success(genresArray))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    //MARK: - TV Genres JSON
    func fetchGenresTV(completion: @escaping (Result<[GenresResults], Error>) -> Void) {
        
        let urlGenres = AF.request(Url.urlBase + Url.urlGenresTV + Url.urlApiKey, method: .get)
        
        urlGenres.responseDecodable(of: Genres.self) { response in
            switch response.result {
            case .success(let genres):
                let genresArray = genres.genres ?? []
                completion(.success(genresArray))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    //MARK: - Details Movies JSON
//    func fetchDetailsMovies(for id: Int, completion: @escaping (Result<DetailsMovies, Error>) -> Void) {
//        
//        let urlDetails = "https://api.themoviedb.org/3/movie/\(id)?api_key=252c9bc8a678428064e9f48a065caabc&language=en-US"
//        
//        AF.request(urlDetails).responseDecodable(of: DetailsMovies.self) { response in
//            switch response.result {
//            case .success(let details):
//                completion(.success(details))
//            case .failure(let error):
//                completion(.failure(error))
//            }
//        }
        
//    }
    }
