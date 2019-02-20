//
//  MovieDetailsViewController.swift
//  Flixter
//
//  Created by Joy Paul on 2/19/19.
//  Copyright © 2019 Joy Paul. All rights reserved.
//

import UIKit
import AlamofireImage

class MovieDetailsViewController: UIViewController {

    var movieTitle: String!
    var synopsisText: String!
    var backdropURL: URL!
    var posterURL: URL!
    
    @IBOutlet weak private var backdropImage: UIImageView!
    @IBOutlet weak private var posterImage: UIImageView!
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var synopsisLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        debugPrint("passed over movie -> \(movieTitle as String)")
        
        titleLabel.text = movieTitle
        titleLabel.sizeToFit()
        
        backdropImage.af_setImage(withURL: backdropURL)
        posterImage.af_setImage(withURL: posterURL)
        
        synopsisLabel.text = synopsisText
        synopsisLabel.sizeToFit()
    }


}
