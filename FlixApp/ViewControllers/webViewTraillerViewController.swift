//
//  webViewTraillerViewController.swift
//  FlixApp
//
//  Created by Isaac Samuel on 9/26/18.
//  Copyright © 2018 Isaac Samuel. All rights reserved.
//

import UIKit

class webViewTraillerViewController: UIViewController {

    @IBOutlet weak var webViewTrailler: UIWebView!
    
    var movieId: String?
    var traillerKeys: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
       trailer()
    }
    func trailer(){
        
        // Do any additional setup after loading the view.
        if let movieId = movieId {
            let url = URL(string: "https://api.themoviedb.org/3/movie/\(movieId)/videos?api_key=5f89533e24a2ff0828389c5e1cb6f8e8&language=en-US")!
            let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
            let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
            let task = session.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    let errorAlertController = UIAlertController(title: "Cannot Get Trailer", message: "The Internet connections appears to be offline.", preferredStyle: .alert)
                    let cancelAction = UIAlertAction(title: "Retry", style: .cancel)
                    errorAlertController.addAction(cancelAction)
                    self.present(errorAlertController, animated: true)
                    print(error.localizedDescription)
                } else if let data = data {
                    // Get the trailers
                    let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                    let videoResults = dataDictionary["results"]! as! [[String: Any]]
                    for video in videoResults {
                        let type = String(describing: video["type"]!)
                        if type == "Trailer" {
                            self.traillerKeys.append(String(describing: video["key"]!))
                        }
                    }
                    if (self.traillerKeys.count > 0){
                        //let key = self.trailerKeys[0]
                        let key = self.traillerKeys[0]
                        let youtubeURL = URL(string: "https://www.youtube.com/watch?v=\(key)")!
                        let request = URLRequest(url: youtubeURL)
                        self.webViewTrailler.loadRequest(request)
                    }
                }
            }
            task.resume()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
