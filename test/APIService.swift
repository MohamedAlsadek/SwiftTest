//
//  APIService.swift
//  test
//
//  Created by Mohamed Alsadek on 7/29/16.
//  Copyright © 2016 Mohamed Alsadek. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class APIService: NSObject {

    
    
    // MARK: API Requests
    func getPopularMovies(pageNumber:Int ,
                         success: (result: JSON) -> Void,
                         failure: (error: NSError) -> Void) {
        
        let requetURL = Constants.BaseApi.baseURL + Constants.Paths.popularMovies
        
        let params = ["api_key": Constants.APIKeys.APIKey,
                      "page": String(pageNumber)]
        
        baseRequest(NSURL(string: requetURL)!, params: params, success: success, failure: failure)
    }
    
    // MARK: Base Request
    func baseRequest(requestURL: NSURL, params: [String: AnyObject],
                     success: (result: JSON) -> Void,
                     failure: (error: NSError) -> Void) {
        
        Alamofire.request(.GET, requestURL, parameters: params, encoding: Alamofire.ParameterEncoding.URL)
            .validate()
            .responseJSON { response in
                
                switch response.result {
                case .Success:
                    do {
                        if let jsonResult = try NSJSONSerialization.JSONObjectWithData(response.data!, options: []) as? NSDictionary {
                            let json = JSON(jsonResult)
                            success(result: json)
                        }
                    } catch let error as NSError {
                        print(error.localizedDescription)
                        failure(error: error)
                    }
                    
                case .Failure(let error):
                    print(error)
                    failure(error: error)
                }
            }
        
    }
}

