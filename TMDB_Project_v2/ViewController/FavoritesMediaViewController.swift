//
//  FavoritesMediaViewController.swift
//  TMDB_Project_v2
//
//  Created by Oleksandr Sushchenko on 05.12.2022.
//

import UIKit
import Alamofire
import RealmSwift

class FavoritesMediaViewController: UIViewController {
    
    private let realm = try! Realm()
    var arrayOfFavourites: [MediaRealm] = []
    var genresArray: [GenresResults] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Favorites media"
        
        tableView.separatorColor = .darkGray
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //MARK: - decoder Genres
        NetworkService.shared.fetchGenresMovie { [weak self] result in
            switch result {
            case .success(let genres):
                self?.genresArray = genres
                self?.tableView.reloadData()
            case .failure(let error):
                print("Error fetching movie genres: \(error.localizedDescription)")
            }
        }
        
        //MARK: - decoder Genres TV
//        NetworkService.shared.fetchGenresTV { [weak self] result in
//            switch result {
//            case .success(let genres):
//                self?.genresArray = genres
//                self?.tableView.reloadData()
//            case .failure(let error):
//                print("Error fetching movie genres: \(error.localizedDescription)")
//            }
//        }
        
        let arrayOfData = realm.objects(MediaRealm.self)
        arrayOfFavourites = arrayOfData.reversed()
        //tableView.reloadData()
        tableView.endUpdates()
    }
}

//MARK: - numberOfRowsInSection,cellForRowAt
extension FavoritesMediaViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfFavourites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        //cell.backgroundColor = UIColor.systemTeal
        cell.selectionStyle = .none
//        cell.backgroundColor = UIColor(hex: "#02B3E0")
        cell.textLabel?.text = self.arrayOfFavourites[indexPath.row].title + "   " + "*" + "\(arrayOfFavourites[indexPath.row].media_type.uppercased())" + "*"
        
        
        return cell
    }
    
    //MARK: - Delete right
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let actionDelete = UIContextualAction(style: .destructive, title: "Delete Media") { action, view, completion in
            DataMedia().delete(mediaRealm: self.arrayOfFavourites[indexPath.row], completion: {
                self.arrayOfFavourites.remove(at: indexPath.row)
                
                let  alert = UIAlertController(title: "Favorites media Delete", message: nil, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Exit", style: .default))
                self.present(alert, animated: true, completion: nil)
                
                self.tableView.reloadData()
            })
            completion(true)
        }
        return UISwipeActionsConfiguration(actions:[actionDelete])
    }
    
    //MARK: - Delete left
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let actionDelete = UIContextualAction(style: .destructive, title: "Delete Media") { action, view, completion in
            DataMedia().delete(mediaRealm: self.arrayOfFavourites[indexPath.row], completion: {
                self.arrayOfFavourites.remove(at: indexPath.row)
                
                let  alert = UIAlertController(title: "Favorites media Delete", message: nil, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Exit", style: .default))
                self.present(alert, animated: true, completion: nil)
                
                self.tableView.reloadData()
            })
            completion(true)
        }
        return UISwipeActionsConfiguration(actions:[actionDelete])
    }
    
    //MARK: - DetailsViewController
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let media = arrayOfFavourites[indexPath.row]
        let genre = genresArray[indexPath.row]
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController else { return }
        
        viewController.poster = media.backdrop_path
        viewController.overview = media.overview
        viewController.name = media.title
        viewController.id = media.id
        viewController.genre = genre.name ?? "Error genre"
        //viewController.genre = (String(describing: media.genreIds ?? []))
        viewController.voteAverage = ("⭐️ \(String(describing: media.voteAverage ))")
        viewController.language = (" 🌍 \(media.originalLanguage.uppercased())")
        self.present(viewController, animated: true)
    }
}




