//
//  MovieGridViewController.swift
//  Flixter
//
//  Created by Joy Paul on 2/21/19.
//  Copyright © 2019 Joy Paul. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class MovieGridViewController: UIViewController {
    
    var API_URL = "https://api.themoviedb.org/3/movie/297762/similar?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getDataWithPods()
       
    }
 
    func getDataWithPods(){
        Alamofire.request(API_URL, method: .get).responseJSON { (response) in
            if response.result.isSuccess{
                let resultCount = JSON(response.result.value!)["results"].count
                
                for x in 0...resultCount-1{
                    print(JSON(response.result.value!)["results"][x]["title"])
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
