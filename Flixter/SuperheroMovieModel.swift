//
//  SuperheroMovieModel.swift
//  Flixter
//
//  Created by Joy Paul on 2/21/19.
//  Copyright © 2019 Joy Paul. All rights reserved.
//

import Foundation

//model for the gridView cell
class SuperheroMovieModel{
    
    var poster_URL: URL
    var movie_title: String
    var movie_overview: String
    var movie_backdrop: URL
    
    init(poster_URL: URL, movie_title: String, movie_overview: String, movie_backdrop: URL) {
        self.poster_URL = poster_URL
        self.movie_title = movie_title
        self.movie_overview = movie_overview
        self.movie_backdrop = movie_backdrop
    }
    
}
