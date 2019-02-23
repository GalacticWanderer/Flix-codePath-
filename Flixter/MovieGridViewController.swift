//
//  MovieGridViewController.swift
//  Flixter
//
//  Created by Joy Paul on 2/21/19.
//  Copyright © 2019 Joy Paul. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON

class MovieGridViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
   
    var API_URL = "https://api.themoviedb.org/3/movie/297762/similar?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed"
    
    var superheroMovieArray: [SuperheroMovieModel] = [SuperheroMovieModel]()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //just like tableView, setting the dataSource and delegate to self
        collectionView.delegate = self
        collectionView.dataSource = self
        
        getDataWithPods()
        setGridViewlayout()
       
    }
    
    //sets up the layout for the gridView items
    func setGridViewlayout(){
        //init a layout var
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        //sets minimum space between
        layout.minimumLineSpacing = 4
        layout.minimumInteritemSpacing = 4
        
        //using math to figure out thge item size for the girdView
        //**view.frame.size.width is the enire width of the view
        let width = (view.frame.size.width - layout.minimumInteritemSpacing * 2)/3
        layout.itemSize = CGSize(width: width, height: width * 3/2)
    }
    
    //returns # of items for the gridView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return superheroMovieArray.count
    }
    
    //congigure the cell and return it
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        
        cell.posterView.af_setImage(withURL: superheroMovieArray[indexPath.item].poster_URL)
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //find the selected cell
        let gridViewItem = sender as! UICollectionViewCell
        let indexPath = collectionView.indexPath(for: gridViewItem)
        
        let superheroMovie = superheroMovieArray[(indexPath?.item)!]
        
        let destinationVC = segue.destination as! SuperheroDetailsViewController
        
        destinationVC.backdropURL = superheroMovie.movie_backdrop
        destinationVC.posterURL = superheroMovie.poster_URL
        destinationVC.movieTitle = superheroMovie.movie_title
        destinationVC.synopsisText = superheroMovie.movie_overview
    }
 
    //func to download JSON from api
    func getDataWithPods(){
        Alamofire.request(API_URL, method: .get).responseJSON { (response) in
            if response.result.isSuccess{
                let resultCount = JSON(response.result.value!)["results"].count
                
                for x in 0...resultCount-1{
                    print(JSON(response.result.value!)["results"][x]["title"])
                    
                    let movie = JSON(response.result.value!)["results"][x]
                    
                    let title = movie["title"].stringValue
                    let overview = movie["overview"].stringValue
                    let posterURL = movie["poster_path"].stringValue
                    let backdropURL = movie["backdrop_path"].stringValue
                    
                    let poster_url = URL(string:"https://image.tmdb.org/t/p/w185"+posterURL)
                    let backdrop_url = URL(string:"https://image.tmdb.org/t/p/w1280"+backdropURL)
                    
                    let data = SuperheroMovieModel(poster_URL: poster_url!, movie_title: title, movie_overview: overview, movie_backdrop: backdrop_url!)
                    
                    self.superheroMovieArray.append(data)
                    self.collectionView.reloadData()
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

}
