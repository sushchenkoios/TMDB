//
//  MediaTableViewCell.swift
//  TMDB_Project_v2
//
//  Created by Oleksandr Sushchenko on 05.12.2022.
//

import UIKit


class MediaTableViewCell: UITableViewCell {
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var mediaTitleLabel: UILabel!
    @IBOutlet weak var overViewLabel: UILabel!
    
    @IBOutlet weak var popularityViewLabel: UILabel!
    @IBOutlet weak var originalLanguage: UILabel!
    @IBOutlet weak var mediaType: UILabel!
    
    @IBOutlet weak var releaseDateViewLabel: UILabel!
    @IBOutlet weak var runtimeViewLabel: UILabel!
    
    
    //MARK: - Result == movie
    
    func configureMovie(with media: MovieResults) {
        
        posterImageView.layer.cornerRadius = 20
        self.mediaTitleLabel.text = media.title
        self.popularityViewLabel.text = ("⭐️ \(String(describing: media.voteAverage ?? 0.0))")
        self.originalLanguage.text = (" 🌍 \(media.originalLanguage?.uppercased() ?? "Error original language")")
        self.overViewLabel.text = media.overview
        self.releaseDateViewLabel.text = ("🗓️  \(String(describing: media.release_date ?? ""))")
//        self.runtimeViewLabel.text = ("Time: \(String(describing: mov)")
        self.mediaType.text = media.media_type
        loadImage(path: media.poster_path ?? "")
        
    }
    //MARK: -  Result == tv

    func configureTv(with media: TvResults) {
        posterImageView.layer.cornerRadius = 20
        self.mediaTitleLabel.text = media.name
        self.popularityViewLabel.text = ("⭐️ \(String(describing: media.voteAverage ?? 0.0))")
        self.originalLanguage.text = (" 🌍 \(media.originalLanguage?.uppercased() ?? "Error original language")")
        self.overViewLabel.text = media.overview
        self.releaseDateViewLabel.text = ("🗓️ \(String(describing: media.first_air_date ?? ""))")
        self.mediaType.text = media.media_type
        loadImage(path: media.poster_path ?? "")
        
    }
    
    //MARK: - Result == Search
    
    func configureMovieSearch(with search: SearchResults) {
        
        posterImageView.layer.cornerRadius = 20
        self.mediaTitleLabel.text = search.title
        self.popularityViewLabel.text = ("⭐️ \(String(describing: search.vote_average ?? 0.0))")
        self.overViewLabel.text = search.overview
        self.originalLanguage.text = (" 🌍 \(search.originalLanguage?.uppercased() ?? "Error original language")")
        self.releaseDateViewLabel.text = ("🗓️  \(String(describing: search.release_date ?? ""))")
      //self.mediaType.text = media.media_type
        loadImage(path: search.poster_path ?? "")
        
    }
    
    //MARK: Result == image
    
    func loadImage (path: String) {
     
        let imageURLString = Url.urlImagePoster + path
        let imageURL = URL(string: imageURLString)
        let defaultImage = UIImage(named: "defaultImage") // деф картинка
         
        posterImageView.sd_setImage(with: imageURL, placeholderImage: defaultImage)
    }
    
}

