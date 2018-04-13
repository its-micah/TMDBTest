//
//  ViewController.swift
//  TMDB Test
//
//  Created by Micah Lanier on 3/7/18.
//  Copyright © 2018 Micah Lanier. All rights reserved.
//

import UIKit
import TMDBSwift



class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UISearchResultsUpdating, UISearchControllerDelegate {
    
    
    var movieArray: Array<MovieMDB>? = [MovieMDB]()
    let movieSearchController = UISearchController(searchResultsController: nil)
    var filteredMovies: [String]?
//    let learningClosure: (() -> Void)
    
    @IBOutlet weak var searchTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTableView.backgroundColor = ColorMode.light.backgroundColor
        
        searchTableView.delegate = self
        searchTableView.dataSource = self
        self.definesPresentationContext = true
        movieSearchController.delegate = self
        movieSearchController.searchBar.searchBarStyle = .minimal
        movieSearchController.searchBar.placeholder = "What are you watching?"
        
        movieSearchController.searchResultsUpdater = self
        movieSearchController.hidesNavigationBarDuringPresentation = false
        movieSearchController.dimsBackgroundDuringPresentation = false
        movieSearchController.extendedLayoutIncludesOpaqueBars = true
        movieSearchController.searchBar.tintColor = .white
        movieSearchController.searchBar.backgroundColor = UIColor(hex: "DE4327")
        searchTableView.tableHeaderView = movieSearchController.searchBar
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        navigationItem.backBarButtonItem?.tintColor = .white
        self.navigationController?.navigationBar.isOpaque = true
        self.navigationController!.view.backgroundColor = UIColor(hex: "DE4327")
        self.navigationController?.navigationBar.backgroundColor = UIColor(hex: "DE4327")

        
        TMDBConfig.apikey = APIKey
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onCancelButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let movieCount = movieArray?.count else {
            return 0
        }
        return movieCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movieCell = tableView.dequeueReusableCell(withIdentifier: "movieCell") as? SearchTableViewCell
        movieCell?.configureWith(movieArray![indexPath.row])
        return movieCell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedMovie = movieArray![indexPath.row]
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let destination = storyboard.instantiateViewController(withIdentifier: "MovieDetailVC") as! MovieDetailViewController
        destination.selectedMovie = selectedMovie
        navigationController?.pushViewController(destination, animated: true)
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = movieSearchController.searchBar.text, !searchText.isEmpty, searchText.count > 2 else {
            return
        }
        searchWith(searchText)
    }
    
    func searchWith(_ searchText: String) {
        SearchMDB.movie(query: searchText, language: "en", page: 1, includeAdult: true, year: nil, primaryReleaseYear: nil) { data, movies in
            guard let foundMovies = movies else {
                self.movieArray = nil
                return
            }
            self.movieArray = foundMovies
            self.searchTableView.reloadData()
        }
        
        
    }
    
    func didPresentSearchController(_ searchController: UISearchController) {
//        searchController.searchBar.showsCancelButton = false
    }


}

