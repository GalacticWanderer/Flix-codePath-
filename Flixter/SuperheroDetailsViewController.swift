//
//  SuperheroDetailsViewController.swift
//  Flixter
//
//  Created by Joy Paul on 2/23/19.
//  Copyright © 2019 Joy Paul. All rights reserved.
//

import UIKit
import AlamofireImage

class SuperheroDetailsViewController: UIViewController {
    
    var movieTitle: String!
    var synopsisText: String!
    var backdropURL: URL!
    var posterURL: URL!
    
    @IBOutlet weak var backdropImage: UIImageView!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpScene()
    }
    
    func setUpScene(){
        backdropImage.af_setImage(withURL: backdropURL)
        posterImage.af_setImage(withURL: posterURL)
        titleLabel.text = movieTitle
        titleLabel.sizeToFit()
        overviewLabel.text = synopsisText
        overviewLabel.sizeToFit()
    }

}
