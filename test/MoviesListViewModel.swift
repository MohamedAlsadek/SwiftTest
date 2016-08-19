//
//  MoviesListViewModel.swift
//  test
//
//  Created by Mohamed Alsadek on 7/30/16.
//  Copyright © 2016 Mohamed Alsadek. All rights reserved.
//

import UIKit


protocol UpdateMovieListDelegate: class {
    func updateUI()
    func handleError(error:NSError)
}

class MoviesListViewModel: NSObject {
    
    weak var updateDelegate:UpdateMovieListDelegate?
    var pageNumber = 1
    var moviesList = NSMutableArray()
    
    // MARK: initialization
    init(delegate:UpdateMovieListDelegate) {
        updateDelegate = delegate
    }
    
    // MARK: Fetching data 
    func fetchMovieListFromServer() {
        
        let dataService = MoviesDataService(apiService: APIService());
        dataService.getPopularMovies(pageNumber, success: { (movies) in
            self.pageNumber += 1
            self.moviesList.addObjectsFromArray(movies as! [Movie])
            
            if self.updateDelegate != nil {
                self.updateDelegate?.updateUI()
            }
            
        }) { (error) in
            if self.updateDelegate != nil {
                self.updateDelegate?.handleError(error)
            }
        }
    }
    

}
