//
//  ViewController.swift
//  Flixter
//
//  Created by Joy Paul on 2/11/19.
//  Copyright © 2019 Joy Paul. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import AlamofireImage

class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var API_URL = "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed"
    
    //holds a list of Movie DataModel objects
    var movieArray: [MovieModel] = [MovieModel]()
    
    
    var movies = [[String:Any]]()
    
    //outlet for the tableView
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setting the datasource and delegate methods tp self
        tableView.dataSource = self
        tableView.delegate = self
        
        //downloading data with the help of pods, alternative to the tutorial
        getDataWithPods()
        
        //for automatic cell resizing
        //and the bottom constraints for view elements has to be >=
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 50

        
        tableView.backgroundColor = .red

    }
    
    // MARK: - data source and delegate methods for the tableview
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieArray.count
    }
    
    //configures tableView cell and returns it
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieCell
        
        //assigning values to the three UIView items
        cell.titleLabel.text = movieArray[indexPath.row].title
        cell.overviewLabel.text = movieArray[indexPath.row].overview
        cell.img_poster.af_setImage(withURL: movieArray[indexPath.row].image_URL)
        return cell
    }
    
    //configure behavior when a tableView cell is selected
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - downloading JSON. (Easy serialization, the Alamofire X SwiftyJSON way)
    func getDataWithPods(){
        Alamofire.request(API_URL, method: .get).responseJSON { (response) in
            if response.result.isSuccess{
                let resultCount = JSON(response.result.value!)["results"].count
                
                for x in 0...resultCount-1{
                    let movies = JSON(response.result.value!)["results"][x]
                    
                    let title = movies["title"].stringValue
                    let overview = movies["overview"].stringValue
                    let posterURL = movies["poster_path"].stringValue
                    let backdropURL = movies["backdrop_path"].stringValue
                    
                    let imageURL = URL(string: "https://image.tmdb.org/t/p/w185" + posterURL)
                    let backdropImageURL = URL(string: "https://image.tmdb.org/t/p/w1280" + backdropURL)
                    
                    //appending to movieArray
                    let data = MovieModel(title: title, overview: overview, image_URL: imageURL!, backdrop_URL: backdropImageURL!)
                    self.movieArray.append(data)
                    
                    //reload tableView
                    self.tableView.reloadData()
                }
                
            }
            
            else if response.result.isFailure{
                print("Request failed")
            }
            
            else{
                fatalError("Networking failed something went horribly wrong")
            }
        }
    }
    
    //triggers right before travels to the next view
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //find the selected cell
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)
        
        let movie = movieArray[indexPath!.row]
        
        //pass the selected cell
        let detailVC = segue.destination  as! MovieDetailsViewController
        detailVC.movieTitle = movie.title
        detailVC.synopsisText = movie.overview
        detailVC.backdropURL = movie.backdrop_URL
        detailVC.posterURL = movie.image_URL
    }
    
    
    
    
    
    // MARK : Tutorial's method of downloading JSON. Using URLSession and URLRequest to make a get request to API and gets a response back
    func tutorialGetData(){
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                
                self.movies = [dataDictionary]
                print(self.movies)
                //assign the cells using movies on the cellForRowAt func
                
            }
        }
        task.resume()

    }

}

