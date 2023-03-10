//
//  MediaRealm.swift
//  TMDB_Project_v2
//
//  Created by Oleksandr Sushchenko on 10.12.2022.
//

import Foundation
import RealmSwift

class MediaRealm: Object {
    
    @Persisted(primaryKey: true) var id: Int
    @Persisted var adult : Bool
    @Persisted var backdrop_path : String
    @Persisted var poster_path : String
    @Persisted var title : String
    @Persisted var genre: Int
    @Persisted var genres: String
    @Persisted var overview : String
    @Persisted var media_type : String
    @Persisted var popularity : Double
    @Persisted var release_date : String
    @Persisted var video : Bool
    @Persisted var voteAverage : Double
    @Persisted var vote_count : Int
    @Persisted var originalLanguage : String

}


