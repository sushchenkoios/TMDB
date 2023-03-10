//
//  MovieViewController.swift
//  TMDB_Project_v2
//
//  Created by Oleksandr Sushchenko on 05.12.2022.
//

import UIKit
import Alamofire

class MovieViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    
    var mediaArray: [MovieResults] = []
    var tvArray: [TvResults] = []
    var personArray: [PersonResult] = []
    var genresArray: [GenresResults] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        self.title = "Trending week"
        tableView.separatorColor = .darkGray
    
        //tableView.backgroundColor = UIColor(red: 2/255, green: 179/255, blue: 224/255, alpha: 1)
        //view.backgroundColor = UIColor(hex: "#02B3E0")
        //#02B3E0
        
        
        
        //перезагружает таблицу и отображает данные в таблице.
        segmentedControl.addTarget(self, action: #selector(segmentedControlChanged(_:)), for: .valueChanged)
        tableView.reloadData()
        
        //MARK: - Cell XIB
        let nib = UINib(nibName: "MediaTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "MediaTableViewCell")
        
        let nibPerson = UINib(nibName: "PersonTableViewCell", bundle: nil)
        self.tableView.register(nibPerson, forCellReuseIdentifier: "PersonTableViewCell")
        
        //MARK: - decoder Movie
        NetworkService.shared.fetchTrendingMovies { [weak self] result in
            switch result {
            case .success(let movies):
                self?.mediaArray = movies
                self?.tableView.reloadData()
            case .failure(let error):
                print("Error fetching trending movies: \(error.localizedDescription)")
            }
        }
        
        //MARK: - decoder TV
        NetworkService.shared.fetchTrendingTV { [weak self] result in
            switch result {
            case .success(let TV):
                self?.tvArray = TV
                self?.tableView.reloadData()
            case .failure(let error):
                print("Error fetching trending TV: \(error.localizedDescription)")
            }
        }
        
        //MARK: - decoder Person
        NetworkService.shared.fetchTrendingPerson { [weak self] result in
            switch result {
            case .success(let persons):
                self?.personArray = persons
                self?.tableView.reloadData()
            case .failure(let error):
                print("Error fetching trending persons: \(error.localizedDescription)")
            }
        }
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
        //MARK: - decoder Details
        //        NetworkService.shared.fetchDetailsMovies(for: id) { [weak self] result in
        //            switch result {
        //            case .success(let details):
        //                self?.detailsArray = details
        //                self?.tableView.reloadData()
        //            case .failure(let error):
        //                print("Error fetching movie genres: \(error.localizedDescription)")
        //            }
        //        }
    }
    
    @objc func segmentedControlChanged(_ sender: UISegmentedControl) {
        tableView.reloadData()
    }
}

//MARK: - numberOfRowsInSection,cellForRowAt
extension MovieViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        
        if segmentedControl.selectedSegmentIndex == 0 {
            return mediaArray.count
        } else if segmentedControl.selectedSegmentIndex == 1 {
            return tvArray.count
        } else {
            return personArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MediaTableViewCell", for: indexPath) as? MediaTableViewCell else {
            fatalError("MediaTableViewCell ERROR!")
        }
        
        guard let cellPerson = tableView.dequeueReusableCell(withIdentifier: "PersonTableViewCell", for: indexPath) as? PersonTableViewCell else {
            fatalError("PersonTableViewCell ERROR!")
        }
        
        cell.selectionStyle = .none
        //cell.backgroundColor = UIColor(hex: "#02B3E0")
        
        if segmentedControl.selectedSegmentIndex == 0 {
            cell.configureMovie(with: mediaArray[indexPath.row])
            return cell
        } else if segmentedControl.selectedSegmentIndex == 1 {
            cell.configureTv(with: tvArray[indexPath.row])
            return cell
        } else {
            cellPerson.configurePerson(with: personArray[indexPath.row])
            return cellPerson
        }
        
    }
    
    //MARK: - Save left
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let actionSave = UIContextualAction(style: .normal, title: "Save") { action, view, completion in
            
            if self.segmentedControl.selectedSegmentIndex == 0 {
                DataMedia().saveMovie(media: self.mediaArray[indexPath.row], genres: nil)
            } else if self.segmentedControl.selectedSegmentIndex == 1 {
                DataMedia().saveTV(media: self.tvArray[indexPath.row])
            } else {
                
            }
            
            let  alert = UIAlertController(title: "Save", message: "Media \(self.mediaArray[indexPath.row].title.uppercased()) saved for favorite", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true, completion: nil)
            
            completion(true)
        }
        
        actionSave.backgroundColor = .green
        return UISwipeActionsConfiguration(actions: [actionSave])
    }
    
    //MARK: - Save right
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let actionSave = UIContextualAction(style: .normal, title: "Save") { action, view, completion in
            
            if self.segmentedControl.selectedSegmentIndex == 0 {
                DataMedia().saveMovie(media: self.mediaArray[indexPath.row], genres: nil)
            } else {
                DataMedia().saveTV(media: self.tvArray[indexPath.row])
            }
            
            let  alert = UIAlertController(title: "Save", message: "Media \(self.mediaArray[indexPath.row].title.uppercased() ) saved for favorite", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true, completion: nil)
            
            completion(true)
        }
        
        actionSave.backgroundColor = .green
        return UISwipeActionsConfiguration(actions: [actionSave])
    }
    
    //MARK: - didSelectRowAt
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let media = mediaArray[indexPath.row]
        let tv = tvArray[indexPath.row]
        let genre =  genresArray[indexPath.row]
        
        //let detail = detailsArray
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController else { return }
        
        if segmentedControl.selectedSegmentIndex == 0 {
            viewController.poster = media.backdrop_path ?? "Error poster"
            viewController.overview = media.overview ?? "Error overview"
            viewController.name = media.title
            viewController.id = media.id ?? 0
            viewController.voteAverage = ("⭐️ \(String(describing: media.voteAverage ?? 0.0))")
            viewController.genre = genre.name ?? "Error genre"
            viewController.language = (" 🌍 \(media.originalLanguage?.uppercased() ?? "Error original language")")
            //viewController.genre = genre.name ?? "Error genre"
            self.present(viewController, animated: true)
            
        } else if segmentedControl.selectedSegmentIndex == 1 {
            viewController.poster = tv.backdrop_path ?? "Error poster"
            viewController.overview = tv.overview ?? "Error overview"
            viewController.name = tv.name ?? "Error name"
            viewController.id = tv.id ?? 0
            viewController.genre = genre.name ?? "Error genre"
            //viewController.genre = (String(describing: media.genreIds ?? []))
            viewController.voteAverage = ("⭐️ \(String(describing: tv.voteAverage ?? 0.0))")
            viewController.language = (" 🌍 \(tv.originalLanguage?.uppercased() ?? "Error original language")")
            
            self.present(viewController, animated: true)
        } else {
            
        }
    }
}






