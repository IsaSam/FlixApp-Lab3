//
//  DetailViewController.swift
//  FlixApp
//
//  Created by Isaac Samuel on 9/23/18.
//  Copyright © 2018 Isaac Samuel. All rights reserved.
//

import UIKit

enum MovieKeys {
    static let title = "title"
    static let movieID = "id"
}

class DetailViewController: UIViewController, UITableViewDelegate {

    @IBOutlet weak var backDropImageView: UIImageView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var playMoviesButton: UIBarButtonItem!
    @IBOutlet weak var playMoviesImageButton: UIButton!
    @IBOutlet weak var playMoviesBackButton: UIButton!
    
    var movie: [String: Any]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let movie = movie{
            titleLabel.text = movie[MovieKeys.title] as? String
            releaseDateLabel.text = movie["release_date"] as? String
            overviewLabel.text = movie ["overview"] as? String
            let backdropPathString = movie["backdrop_path"] as! String
            let posterPathString = movie["poster_path"] as! String
            let posterBaseUrl = "https://image.tmdb.org/t/p/w500"
            let backdropURL = URL(string: posterBaseUrl + backdropPathString)!
            backDropImageView.af_setImage(withURL: backdropURL)
            let posterPathURL = URL(string: posterBaseUrl + posterPathString)!
            posterImageView.af_setImage(withURL: posterPathURL)
        }

    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! webViewTraillerViewController
        if let movie = movie{
            let movieID = String(describing: movie[MovieKeys.movieID]!)
            vc.movieId = movieID
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
