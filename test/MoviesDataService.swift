//
//  MoviesDataService.swift
//  test
//
//  Created by Mohamed Alsadek on 7/30/16.
//  Copyright © 2016 Mohamed Alsadek. All rights reserved.
//

import UIKit

class MoviesDataService: NSObject {
    let apiService:APIService!
    
    init(apiService:APIService) {
        self.apiService = apiService
    }
    
    // MARK: API Requests
    func getPopularMovies(pageNumber:Int ,
                          success: (movies: NSArray) -> Void,
                          failure: (error: NSError) -> Void) {
        
        apiService.getPopularMovies(pageNumber, success: { (result) in
            
            let movies = result["results"].arrayObject
            let moviesObjects = NSMutableArray()
            
            for tempMovie in movies! {
                let movieObj = Movie(object: tempMovie as! NSDictionary)
                moviesObjects.addObject(movieObj);
            }
            
            success(movies: moviesObjects)
            
        }) { (error) in

            print(error);
            failure(error: error)
        }
    }
    
}
