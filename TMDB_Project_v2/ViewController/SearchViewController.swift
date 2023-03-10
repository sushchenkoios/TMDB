//
//  SearchViewController.swift
//  TMDB_Project_v2
//
//  Created by Oleksandr Sushchenko on 30.01.2023.
//

import UIKit
import Alamofire

class SearchViewController: UIViewController {
    
    var searchMediaArray: [SearchResults] = []
    
    
//    var mediaArray: [MovieResults] = []
//    var genresArray: [GenresResults] = []
    
    private var searchTimer: Timer?
    
    let searchController = UISearchController(searchResultsController: nil)
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        //self.title = "Search"
        
        tableView.separatorColor = .darkGray
        //tableView.backgroundColor = UIColor.systemTeal
        
        
        setupSearchBar()
        
    }
    
    private func setupSearchBar() {
        
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        navigationController?.navigationBar.prefersLargeTitles = true
        searchController.obscuresBackgroundDuringPresentation = false
    }
}


//MARK: - numberOfRowsInSection,cellForRowAt

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchMediaArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MediaTableViewCell", for: indexPath) as? MediaTableViewCell else {
            fatalError("MediaTableViewCell ERROR!")
        }
        
        cell.configureMovieSearch(with: searchMediaArray[indexPath.row])
       // cell.backgroundColor = UIColor.systemTeal
        
        cell.selectionStyle = .none
        return cell
    }
    
    //MARK: - Save left
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let actionSave = UIContextualAction(style: .normal, title: "Save Movie") { action, view, completion in
            
            //DataMedia().saveMovie(media: self.searchMediaArray[indexPath.row])
            //            DataMedia().saveTV(media: self.tvArray[indexPath.row])
            
            let  alert = UIAlertController(title: "Movie Save", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true, completion: nil)
            
            completion(true)
        }
        
        actionSave.backgroundColor = .green
        return UISwipeActionsConfiguration(actions: [actionSave])
    }
    
    //MARK: - didSelectRowAt
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let search = searchMediaArray[indexPath.row]
       // let media = mediaArray[indexPath.row]
        //let genre =  genresArray[indexPath.row]
        //let details = movieDetails[indexPath.row]
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController else { return }
        
        viewController.poster = search.backdropPath ?? "Error poster"
        viewController.overview = search.overview ?? "Error overview"
        viewController.name = search.title ?? "Error name"
        viewController.id = search.id ?? 0
        viewController.voteAverage = ("⭐️ \(String(describing: search.vote_average ?? 0.0))")
        //viewController.genre = genre.name ?? "Error genre"
        viewController.genre = (String(describing:search.genreIds ?? [] ))
        viewController.language = (" 🌍 \(search.originalLanguage?.uppercased() ?? "Error original language")")
        
        self.present(viewController, animated: true)
        
    }
    
}


// MARK: - UISearchBarDelegate

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        searchTimer?.invalidate()
        
        searchTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { [weak self] timer in
            
            
            let urlSearchMovie = Url.urlBase + Url.urlSearchMovies + Url.urlApiKey + Url.urlLanguageUS + Url.urlquery + "\(searchText)"
            
           let urlSearchTV = Url.urlBase + Url.urlSearchTV + Url.urlApiKey + Url.urlLanguageUS + Url.urlquery + "\(searchText)"

            
            let urlMovie = AF.request(urlSearchMovie, method: .get)
            let urlTV = AF.request(urlSearchTV, method: .get)
            
            var searchResults: [SearchResults] = []
            let group = DispatchGroup()
            
            group.enter()
                        urlMovie.responseDecodable(of: SearchResponse.self) { response in
                            if let results = response.value?.results {
                                searchResults.append(contentsOf: results)
                            }
                            group.leave()
                        }
                        
                        group.enter()
                        urlTV.responseDecodable(of: SearchResponse.self) { response in
                            if let results = response.value?.results {
                                searchResults.append(contentsOf: results)
                            }
                            group.leave()
                        }
                        
                        group.notify(queue: .main) {
                            self?.searchMediaArray = searchResults
                            self?.tableView.reloadData()
                        }
            
            let nib = UINib(nibName: "MediaTableViewCell", bundle: nil)
            
            self?.tableView.register(nib, forCellReuseIdentifier: "MediaTableViewCell")
        })
    }
}










//
//class SearchViewController: UIViewController {
//
//    let networkDataFetcher = NetworkData()
//    var searchResponse: SearchResponse? = nil
//    private var timer: Timer?
//    let searchController = UISearchController(searchResultsController: nil)
//
//    var mediaArray: [MovieResults] = []
//    var tvArray: [TvResults] = []
//
//    @IBOutlet weak var table: UITableView!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        setupTableView()
//        setupSearchBar()
//
//    }
//
//    private func setupSearchBar() {
//        navigationItem.searchController = searchController
//        searchController.searchBar.delegate = self
//        navigationController?.navigationBar.prefersLargeTitles = true
//        searchController.obscuresBackgroundDuringPresentation = false
//    }
//
//    private func setupTableView() {
//        table.delegate = self
//        table.dataSource = self
//        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
//    }
//
//}
//
//// MARK: - UITableViewDelegate, UITableViewDataSource
//
//extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return searchResponse?.results?.count ?? 0
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        let  movie = searchResponse?.results?[indexPath.row]
//        cell.textLabel?.text = movie?.title
//        cell.selectionStyle = .none
//        return cell
//    }
//
//    //MARK: - Save left
//    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        let actionSave = UIContextualAction(style: .normal, title: "Save Movie") { action, view, completion in
//
////            DataMedia().saveMovie(media: self.mediaArray[indexPath.row])
////            DataMedia().saveTV(media: self.tvArray[indexPath.row])
//
//            let  alert = UIAlertController(title: "Movie Save", message: nil, preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "OK", style: .default))
//            self.present(alert, animated: true, completion: nil)
//
//            completion(true)
//        }
//
//        actionSave.backgroundColor = .green
//        return UISwipeActionsConfiguration(actions: [actionSave])
//    }
//
//    //MARK: - didSelectRowAt
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//
//
//       // let media = mediaArray[indexPath.row]
//
//
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//
//        guard let viewController = storyboard.instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController else { return }
//
////        viewController.poster = media.backdrop_path ?? "Error poster"
////        viewController.overview = media.overview ?? "Error overview"
////        viewController.name = media.title ?? "Error name"
////        viewController.id = media.id ?? 0
////        viewController.voteAverage = ("⭐️ \(String(describing: media.voteAverage ?? 0.0))")
//        //viewController.genre = genre.name ?? "Error genre"
//        //viewController.runtime = (String(describing: details.runtime ))
//        self.present(viewController, animated: true)
//
//    }
//
//}
//
//// MARK: - UISearchBarDelegate
//
//extension SearchViewController: UISearchBarDelegate {
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//
//        let urlString = "https://api.themoviedb.org/3/search/movie?api_key=252c9bc8a678428064e9f48a065caabc&language=en-US&query=\(searchText)&page=1&include_adult=false"
//
//        timer?.invalidate()
//        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: {(_) in
//            self.networkDataFetcher.fetchMovie(urlString: urlString) {
//                (searchResponse) in
//                guard let searchResponse = searchResponse else { return }
//                self.searchResponse = searchResponse
//                self.table.reloadData()
//            }
//        })
//    }
//}
//
