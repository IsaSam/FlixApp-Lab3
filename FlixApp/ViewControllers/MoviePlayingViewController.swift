//
//  MoviePlayingViewController.swift
//  FlixApp
//
//  Created by Isaac Samuel on 9/17/18.
//  Copyright © 2018 Isaac Samuel. All rights reserved.
//

import UIKit
import AlamofireImage


class MoviePlayingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    
    var movies: [[String: Any]] = []
    var searchController: UISearchController!
    var reasultsController = UITableViewController()
    var refreshControl: UIRefreshControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.searchController = UISearchController(searchResultsController: self.reasultsController)
        self.tableView.tableHeaderView = self.searchController.searchBar
        self.searchController.searchResultsUpdater = self
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl.addTarget(self, action: #selector(MoviePlayingViewController.didPullToRefresh(_:)), for: .valueChanged)

        tableView.delegate = self
        tableView.rowHeight = 168
        tableView.estimatedRowHeight = 200
        
        tableView.insertSubview(refreshControl, at: 0)
        tableView.dataSource = self
        //searchBar.delegate = self
        fetchMovies()
        
    }
    @objc func didPullToRefresh(_ refreshControl: UIRefreshControl){
        fetchMovies()
    }
    
    func fetchMovies(){
        activityIndicator.startAnimating()
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) {(data, response, error) in
            //-- This will run when the network request returns
            if let error = error{
                let errorAlertController = UIAlertController(title: "Cannot Get Movies", message: "The Internet connections appears to be offline", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "Retry", style: .cancel)
                errorAlertController.addAction(cancelAction)
                self.present(errorAlertController, animated: true)
                print(error.localizedDescription)
            } else if let data = data,
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]{
                //print(dataDictionary)
                self.movies = dataDictionary["results"] as! [[String: Any]]
                self.tableView.reloadData()
                
            }
            self.refreshControl.endRefreshing()
        }
        task.resume()
        activityIndicator.stopAnimating()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return self.movies.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        let movie = movies[indexPath.row]
        let title = movie["title"] as! String
        let overview = movie["overview"] as! String
        cell.titleLabel.text = title
        cell.overviewTextView.text = overview
        
        if let posterPath = movie["poster_path"] as? String{
            let posterBaseUrl = "https://image.tmdb.org/t/p/w500"
            let posterUrl = URL(string:  posterBaseUrl + posterPath)
            cell.MoviesImageView.af_setImage(withURL: posterUrl!)
        }
        else{
            cell.MoviesImageView.image = nil
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)
        let movie = movies[(indexPath?.row)!]
        let detailViewController = segue.destination as! DetailViewController
        detailViewController.movie = movie
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}
