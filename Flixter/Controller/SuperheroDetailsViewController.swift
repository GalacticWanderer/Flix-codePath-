//
//  SuperheroDetailsViewController.swift
//  Flixter
//
//  Created by Joy Paul on 2/23/19.
//  Copyright © 2019 Joy Paul. All rights reserved.
//

import UIKit
import AlamofireImage
import Alamofire
import SwiftyJSON

class SuperheroDetailsViewController: UIViewController {
    
    var movieTitle: String!
    var synopsisText: String!
    var backdropURL: URL!
    var posterURL: URL!
    var id: String!
    
    @IBOutlet weak var backdropImage: UIImageView!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    var API_URL: URL!
    
    var videoUrl: URL!
    
    //the tap gesture recognizer func
    @IBAction func tapGesture(_ sender: UITapGestureRecognizer) {
        
        print("poster tapped!!!")
        performSegue(withIdentifier: "WebViewController", sender: self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpScene()
        posterImage.isUserInteractionEnabled = true
        print("video ID ->>> \(id as String)")
        API_URL = URL(string: "https://api.themoviedb.org/3/movie/\(id as String)/videos?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&language")
        getDataWithPods()
    }
    
    func setUpScene(){
        backdropImage.af_setImage(withURL: backdropURL)
        posterImage.af_setImage(withURL: posterURL)
        titleLabel.text = movieTitle
        titleLabel.sizeToFit()
        overviewLabel.text = synopsisText
        overviewLabel.sizeToFit()
    }
    
    //get the youtube video key
    func getDataWithPods(){
        Alamofire.request(API_URL, method: .get).responseJSON { (response) in
            if response.result.isSuccess{

                    let movie = JSON(response.result.value!)["results"][0]
                    
                    let videoKey = movie["key"].stringValue
                    self.videoUrl = URL(string: "https://www.youtube.com/watch?v=\(videoKey)")!
                
                    print(self.videoUrl as URL)
            }
                
            else if response.result.isFailure{
                print("Request failed")
            }
                
            else{
                fatalError("Networking failed something went horribly wrong")
            }
        }
    }
    
    //segue func
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! WebViewController
        
        destinationVC.url = videoUrl
        
    }

}
