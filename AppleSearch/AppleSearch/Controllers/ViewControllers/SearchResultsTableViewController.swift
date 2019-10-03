//
//  SearchResultsTableViewController.swift
//  AppleSearch
//
//  Created by Christopher Alegre on 10/3/19.
//  Copyright © 2019 Christopher Alegre. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController, UISearchBarDelegate {
    
    //MARK:- Properties
    var musicSearchResult: [MusicSearchResult] = []
    var appSearchResult: [AppSearchResult] = []

    //MARK:- Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var segmentCotroller: UISegmentedControl!
    
    //MARK:- View
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        self.tableView.estimatedRowHeight = 150
        self.tableView.rowHeight = 150
        SearchResultsConroller.getMusicItemsWith(searchText: "ODESZA") { (results) in
            self.musicSearchResult = results
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    //MARK:- Actions
    @IBAction func segmentControllerValueChange(_ sender: UISegmentedControl) {
        self.tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text, !searchText.isEmpty else {return}
        
        if segmentCotroller.selectedSegmentIndex == 0 {
            SearchResultsConroller.getMusicItemsWith(searchText: searchText) { (results) in
                self.musicSearchResult = results
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.searchBar.text = ""
                }
            }
        } else if segmentCotroller.selectedSegmentIndex == 1 {
            SearchResultsConroller.getAppItemsWith(searchText: searchText) { (results) in
                self.appSearchResult = results
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.searchBar.text = ""
                }
            }
        }
        self.searchBar.endEditing(true)
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 0
        if segmentCotroller.selectedSegmentIndex == 0 {
            count = musicSearchResult.count
        } else if segmentCotroller.selectedSegmentIndex == 1 {
            count = appSearchResult.count }
        return count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "resultCell", for: indexPath) as! ResultTableViewCell
        
        if segmentCotroller.selectedSegmentIndex == 0 {
            let searchResult = musicSearchResult[indexPath.row]
            cell.musicItem = searchResult
        } else if segmentCotroller.selectedSegmentIndex == 1 {
            let searchResult = appSearchResult[indexPath.row]
            cell.appItem = searchResult
        }
        return cell
    }
}
