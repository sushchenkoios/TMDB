////
////  TvViewController.swift
////  TMDB_Project_v2
////
////  Created by Oleksandr Sushchenko on 05.12.2022.
////
//
//import UIKit
//import Alamofire
//
//
//class TvViewController: UIViewController {
//    
//    @IBOutlet weak var tableView: UITableView!
//    
//    var tvArray: [TvResults] = []
//    var genresArray: [GenresResults] = []
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        tableView.delegate = self
//        tableView.dataSource = self
//        
//        self.title = "Trending series week"
//        
//        tableView.separatorColor = .darkGray
//        //tableView.backgroundColor = UIColor.systemTeal
//        
//        //MARK: - Cell XIB
//        let nib = UINib(nibName: "MediaTableViewCell", bundle: nil)
//        self.tableView.register(nib, forCellReuseIdentifier: "MediaTableViewCell")
//        
//        //MARK: - decoder TV
//        NetworkService.shared.fetchTrendingTV { [weak self] result in
//            switch result {
//            case .success(let TV):
//                self?.tvArray = TV
//                self?.tableView.reloadData()
//            case .failure(let error):
//                print("Error fetching trending TV: \(error.localizedDescription)")
//            }
//        }
//        
//        //MARK: - decoder Genres
//        NetworkService.shared.fetchGenresTV { [weak self] result in
//            switch result {
//            case .success(let genres):
//                self?.genresArray = genres
//                self?.tableView.reloadData()
//            case .failure(let error):
//                print("Error fetching movie genres: \(error.localizedDescription)")
//            }
//        }
//    }
//}
//
////MARK: - numberOfRowsInSection,cellForRowAt
//extension TvViewController: UITableViewDataSource, UITableViewDelegate {
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return tvArray.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MediaTableViewCell", for: indexPath) as? MediaTableViewCell else {
//            fatalError("MediaTableViewCell ERROR!")
//        }
//        cell.configureTv(with: tvArray[indexPath.row])
//        //cell.backgroundColor = UIColor.systemTeal
//        cell.selectionStyle = .none
//        return cell
//    }
//    
//    //MARK: - Save left
//    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        let actionSave = UIContextualAction(style: .destructive, title: "Success") { _, _, completion in
//            
//            DataMedia().saveTV(media: self.tvArray[indexPath.row])
//            
//            let  alert = UIAlertController(title: "Success", message: "Media \(self.tvArray[indexPath.row].name?.uppercased() ?? "") saved for favorite", preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "OK", style: .default))
//            self.present(alert, animated: true, completion: nil)
//            
//            completion(true)
//        }
//        
//        actionSave.backgroundColor = .green
//        return UISwipeActionsConfiguration(actions: [actionSave])
//        
//    }
//    
//    //MARK: - Save right
//    
//    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        let actionSave = UIContextualAction(style: .normal, title: "Success") { _, _, completion in
//            
//            DataMedia().saveTV(media: self.tvArray[indexPath.row])
//            
//            let  alert = UIAlertController(title: "Success", message: "Media \(self.tvArray[indexPath.row].name?.uppercased() ?? "") saved for favorite", preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "OK", style: .default))
//            self.present(alert, animated: true, completion: nil)
//            
//            completion(true)
//        }
//        
//        actionSave.backgroundColor = .green
//        
//        return UISwipeActionsConfiguration(actions: [actionSave])
//        
//    }
//    
//    //MARK: - didSelectRowAt
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        
//        let media = tvArray[indexPath.row]
//        let genre =  genresArray[indexPath.row]
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        
//        guard let viewController = storyboard.instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController else { return }
//        
//        viewController.poster = media.backdrop_path ?? "Error poster"
//        viewController.overview = media.overview ?? "Error overview"
//        viewController.name = media.name ?? "Error name"
//        viewController.id = media.id ?? 0
//        viewController.genre = genre.name ?? "Error genre"
//        //viewController.genre = (String(describing: media.genreIds ?? []))
//        viewController.voteAverage = ("⭐️ \(String(describing: media.voteAverage ?? 0.0))")
//        viewController.language = (" 🌍 \(media.originalLanguage?.uppercased() ?? "Error original language")")
//        
//        self.present(viewController, animated: true)
//    }
//}
//
//
//
//
//
//
//
//
//
//
