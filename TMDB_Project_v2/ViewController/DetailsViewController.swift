//
//  DetailsViewController.swift
//  TMDB_Project_v2
//
//  Created by Oleksandr Sushchenko on 05.12.2022.
//

import UIKit
import Alamofire
import SDWebImage
import YouTubePlayer
import RealmSwift

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var mediaTitleLabel: UILabel!
    @IBOutlet weak var overViewLabel: UILabel!
    @IBOutlet weak var genresViewLabel: UILabel!
    @IBOutlet weak var playerView: YouTubePlayerView!
    @IBOutlet weak var popularityViewLabel: UILabel!
    @IBOutlet weak var languageViewLabel: UILabel!
    
    
    var videoArray: [YouTubeResults] = []
    
    private let realm = try! Realm()
    var arrayOfFavourites: [MediaRealm] = []
    
    var name = ""
    var poster = ""
    var overview = ""
    var id = 0
    var video = ""
    var genre = ""
    var voteAverage = ""
    var language = ""
    var detail = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadImage(dpath: poster)
        mediaTitleLabel.text = name
        overViewLabel.text = overview
        genresViewLabel.text = genre
        popularityViewLabel.text = voteAverage
        languageViewLabel.text = language
        getMovieVideo(dpath: video)
        getTvVideo(dpath: video)
        
        let arrayOfData = realm.objects(MediaRealm.self)
        arrayOfFavourites = arrayOfData.reversed()
        
    }
    
    @IBAction func buttonSaveFavorit(_ sender: UIButton) {
        
        sender.isSelected = !sender.isSelected
        
        
        if sender.isSelected {
            sender.tintColor = .red
            
            //save
            
            let alertController = UIAlertController(title: "Save", message: "Media \(name.uppercased()) saved for favorite", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alertController, animated: true, completion: nil)
        } else {
            sender.tintColor = .systemTeal
            
            //delite
            
            let alertController = UIAlertController(title: "Delite", message: "Media \(name.uppercased()) saved for favorite", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alertController, animated: true, completion: nil)
            
        }
    }
    
    
    // MARK: - loadImage
    func loadImage (dpath: String) {
        let imageURLString = Url.urlImagePoster + dpath
        let imageURL = URL(string: imageURLString)
        let defaultImage = UIImage(named: "defaultImage") // деф картинка
        posterImageView.sd_setImage(with: imageURL, placeholderImage: defaultImage)
    }
    
    
    func getMovieVideo (dpath: String) {
        
        let urlVideo = AF.request("https://api.themoviedb.org/3/movie/\(id))/videos?api_key=252c9bc8a678428064e9f48a065caabc", method: .get)
        
        urlVideo.responseDecodable(of: YouTubeResponce.self) { responce in
            
            do {
                self.videoArray = try responce.result.get().results
                
                self.playerView.loadVideoID((self.videoArray.first?.key ?? ""))
            } catch {
                print("Models are not working with our JSON")
            }
        }
        
    }
    
    
    func getTvVideo (dpath: String) {
        
        let urlVideo = AF.request("https://api.themoviedb.org/3/tv/\(id))/videos?api_key=252c9bc8a678428064e9f48a065caabc", method: .get)
        
        
        urlVideo.responseDecodable(of: YouTubeResponce.self) { responce in
            
            do {
                guard let videoResponce = try? responce.result.get() else { return }
                
                let trailers = videoResponce.results.filter { $0.type.rawValue == "Trailer" }
                
                if let trailer = trailers.first {
                    self.playerView.loadVideoID(trailer.key)
                } else {
//                    print("No trailers found Teaser")
                    let teasers = videoResponce.results.filter { $0.type.rawValue == "Teaser" }
                    
                    if let teaser = teasers.first {
                        self.playerView.loadVideoID(teaser.key)
                    }
                }
            }
        }
    }
}







