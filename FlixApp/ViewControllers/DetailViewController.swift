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
}

class DetailViewController: UIViewController {

    @IBOutlet weak var backDropImageView: UIImageView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
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
            //backDropImageView.af_setImage(withURL: posterPathURL)
            posterImageView.af_setImage(withURL: posterPathURL)
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
