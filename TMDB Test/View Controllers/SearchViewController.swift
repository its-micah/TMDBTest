//
//  ViewController.swift
//  TMDB Test
//
//  Created by Micah Lanier on 3/7/18.
//  Copyright © 2018 Micah Lanier. All rights reserved.
//

import UIKit
import TMDBSwift

let APIKey = "129c600b875d890d125e8dfda77bb60c"

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UISearchResultsUpdating {
    
    
    var movieArray = [MovieMDB]()
    let movieSearchController = UISearchController(searchResultsController: nil)
    var filteredMovies: [String]?

    
    @IBOutlet weak var searchTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTableView.delegate = self
        searchTableView.dataSource = self
        self.definesPresentationContext = true
        movieSearchController.searchBar.searchBarStyle = .minimal
        movieSearchController.searchBar.placeholder = "What are you watching?"
        
        movieSearchController.searchResultsUpdater = self
        movieSearchController.hidesNavigationBarDuringPresentation = false
        movieSearchController.dimsBackgroundDuringPresentation = false
        searchTableView.tableHeaderView = movieSearchController.searchBar
        
        TMDBConfig.apikey = APIKey
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movieCell = tableView.dequeueReusableCell(withIdentifier: "movieCell") as? SearchTableViewCell
        movieCell?.configureWith(movieArray[indexPath.row])
        return movieCell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedMovie = movieArray[indexPath.row]
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let destination = storyboard.instantiateViewController(withIdentifier: "MovieDetailVC") as! MovieDetailViewController
        destination.selectedMovie = selectedMovie
        navigationController?.pushViewController(destination, animated: true)

    
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = movieSearchController.searchBar.text, !searchText.isEmpty, searchText.count > 2 {
            searchWith(searchText)
            }
        searchTableView.reloadData()
    }
    
    func searchWith(_ searchText: String) {
        SearchMDB.movie(query: searchText, language: "en", page: 1, includeAdult: true, year: nil, primaryReleaseYear: nil) { data, movies in
            self.movieArray = movies!
        }
        
        
    }


}

