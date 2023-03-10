//
//  DataMedia.swift
//  TMDB_Project_v2
//
//  Created by Oleksandr Sushchenko on 10.12.2022.
//

import Foundation
import RealmSwift

struct DataMedia {

    private let realm = try? Realm()

    // MARK: - Types save Movie

    func saveMovie(media: MovieResults?, genres: GenresResults? ) {

        let mediaRealm = MediaRealm()

        mediaRealm.id = media?.id  ?? 0
        mediaRealm.adult = media?.adult ?? false
        mediaRealm.backdrop_path = media?.backdrop_path ?? ""
        mediaRealm.title = media?.title ?? ""
        //mediaRealm.genre = media?.genreIds ?? [0]
        mediaRealm.genres = genres?.name ?? ""
        mediaRealm.overview = media?.overview ?? ""
        mediaRealm.media_type = media?.media_type ?? ""
        mediaRealm.popularity = media?.popularity ?? 0.0
        mediaRealm.release_date = media?.release_date ?? ""
        mediaRealm.video = media?.video ?? false
        mediaRealm.voteAverage = media?.voteAverage ?? 0
        mediaRealm.vote_count = media?.vote_count ?? 0
        mediaRealm.originalLanguage = media?.originalLanguage ?? ""
        try? realm?.write {
            realm?.add(mediaRealm, update: .all)
        }
    }

    // MARK: - Types save Tv

    func saveTV(media: TvResults?) {

        let mediaRealm = MediaRealm()

        mediaRealm.id = media?.id  ?? 0
        mediaRealm.adult = media?.adult ?? false
        mediaRealm.backdrop_path = media?.backdrop_path ?? ""
        mediaRealm.title = media?.name ?? ""
        mediaRealm.overview = media?.overview ?? ""
        mediaRealm.media_type = media?.media_type ?? ""
        mediaRealm.popularity = media?.popularity ?? 0.0
        mediaRealm.release_date = media?.first_air_date ?? ""
        mediaRealm.voteAverage = media?.voteAverage ?? 0
        mediaRealm.vote_count = media?.vote_count ?? 0
        mediaRealm.originalLanguage = media?.originalLanguage ?? ""

        try? realm?.write {
            realm?.add(mediaRealm, update: .all)
        }
    }
    
    // MARK: - Delete
    
    func delete(mediaRealm: MediaRealm, completion: @escaping(()->())) {
        try? realm?.write {
            realm?.delete(mediaRealm)
        }
        completion()
    }
    // MARK: - Private
    
    private func some() {
        
    }
    
}
