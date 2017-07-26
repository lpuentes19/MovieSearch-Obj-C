//
//  MovieTableViewController.swift
//  MovieSearch-Obj-C
//
//  Created by Luis Puentes on 7/25/17.
//  Copyright © 2017 LuisPuentes. All rights reserved.
//

import UIKit

class MovieTableViewController: UITableViewController, UISearchBarDelegate {

    var movies: [LPMovie] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchbar.delegate = self
        navigationItem.title = "Movie Search"
        navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "Baskerville-Italic" , size: 28)!, NSForegroundColorAttributeName: UIColor.white]
        // BarStyle has to be .black in order to see the white UIStatusBarStyle
        navigationController?.navigationBar.barStyle = .black
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchbar.text, !searchTerm.isEmpty else { return }
        
        LPMovieController.shared().fetchMovie(forSearchTerm: searchTerm) { (movies) in
            guard let movies = movies as? [LPMovie] else { return }
            
            DispatchQueue.main.async {
                self.movies = movies
                self.searchbar.resignFirstResponder()
            }
        }
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as? MovieTableViewCell ?? MovieTableViewCell()
        
        let movie = movies[indexPath.row]
        
        cell.movies = movie
        
        DispatchQueue.main.async {
            cell.updateViews()
        }
        return cell
    }
    
    // Disables the cell from being highlighted when selected
   override func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    @IBOutlet weak var searchbar: UISearchBar!
}
