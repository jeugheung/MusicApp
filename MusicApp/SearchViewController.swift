//
//  SearchViewController.swift
//  MusicApp
//
//  Created by Andrey Kim on 17.08.2022.
//

import Foundation
import UIKit
import Alamofire

struct TrackModel {
    var trackName: String
    var artistName: String
}

class SearchViewController: UITableViewController {
    
    private lazy var searchController: UISearchController = {
        let search = UISearchController(searchResultsController: nil)
        return search
    }()
    
    let tracks = [TrackModel(trackName: "bad guy", artistName: "Billie Eilish"),
                 TrackModel(trackName: "bury a friend", artistName: "Billie Eilish")]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupSearchBar()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
    }
    
    private func setupSearchBar() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        let track = tracks[indexPath.row]
        cell.textLabel?.text = "\(track.trackName)\n\(track.artistName)"
        cell.textLabel?.numberOfLines = 2
        cell.imageView?.image = UIImage(named: "itunes.png")
        return cell
    }
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let url = "https://itunes.apple.com/search?term=\(searchText)"
        
        AF.request(url).responseData { (dataResponse) in
            if let error = dataResponse.error {
                print("Error received requesting data: \(error.localizedDescription)")
                return
            }
            
            guard let data = dataResponse.data else { return }
            let someString = String(data: data, encoding: .utf8)
            print(someString ?? "")
        }
    }
}
