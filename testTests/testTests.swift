//
//  testTests.swift
//  testTests
//
//  Created by Mohamed Alsadek on 7/27/16.
//  Copyright © 2016 Mohamed Alsadek. All rights reserved.
//

import XCTest
import SwiftyJSON

@testable import test

class testTests: XCTestCase {
    
    var apiService: APIService!
    var dataService: MoviesDataService!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        apiService = APIService()
        dataService = MoviesDataService(apiService: apiService)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
    
    // MARK: Base API Testing
    func testGetPopularMoviesJsonCalback() {
        
        // 1. Define an expectation
        let expectation = expectationWithDescription("getPopularMovies returns valid json")

        var jsonResult:JSON?
        apiService.getPopularMovies(1, success: { (result) in

            jsonResult = result
            XCTAssertNotNil(result)
            expectation.fulfill()

        }) { (error) in
            XCTFail("Service Fails with error : \(error)")
            expectation.fulfill()
        };
        
        
        // Wait for the expectation to be fulfilled
        waitForExpectationsWithTimeout(10) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
        
        
        /// validate the Json
        
        // 1. validate number of returned objects
        let movies = jsonResult!["results"].arrayObject
        let moviesCount = movies!.count
        XCTAssert(moviesCount == 20)
        
        
        // 2. valide if the used parameters are valid
        for tempMovie in movies! {
            let movieObject = JSON(tempMovie)
            
            // ID Param
            if let id = movieObject[MovieParams.id].int  {
                XCTAssertNotNil(id)
            }else {
                XCTFail("Problem json parameter \(MovieParams.id)")
            }
            
            // valid image
            if let overView = movieObject[MovieParams.posterPath].string  {
                XCTAssertNotNil(overView)
            }else {
                XCTFail("Problem json parameter \(MovieParams.posterPath)")
            }
            
            // valid title
            if let title = movieObject[MovieParams.title].string  {
                XCTAssertNotNil(title)
            }else {
                XCTFail("Problem json parameter \(MovieParams.title)")
            }
            
            // valid release date
            if let releaseDate = movieObject[MovieParams.releaseDate].string  {
                XCTAssertNotNil(releaseDate)
            }else {
                XCTFail("Problem json parameter \(MovieParams.releaseDate)")
            }
        }
        
    }
    
    // MARK: Data Service Testing
    func testGetPopularMoviesObjects() {
        
        // 1. Define an expectation
        let expectation = expectationWithDescription("getPopularMovies returns valid objects after parsing")
        
        var moviesList:NSArray?
        dataService.getPopularMovies(1, success: { (movies) in
            
            moviesList = movies
            XCTAssertNotNil(movies)
            expectation.fulfill()
            
        }) { (error) in
                XCTFail("Service Fails with error : \(error)")
                expectation.fulfill()
        }
        
        
        // Wait for the expectation to be fulfilled
        waitForExpectationsWithTimeout(10) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
        
        
        /// validate the Objects
        
        // 1. validate number of returned objects
        let moviesCount = moviesList!.count
        XCTAssert(moviesCount == 20)
        
        
        // 2. valide if the used parameters are valid
        for tempMovie in moviesList! {
            
            let movieObject = tempMovie as! Movie
            
            // ID Param
            if let id = movieObject.id  {
                XCTAssertNotNil(id)
            }else {
                XCTFail("Problem object parameter \(MovieParams.id)")
            }
            
            // valid image
            if let overView = movieObject.posterPath  {
                XCTAssertNotNil(overView)
            }else {
                XCTFail("Problem object parameter \(MovieParams.posterPath)")
            }
            
            // valid title
            if let title = movieObject.title  {
                XCTAssertNotNil(title)
            }else {
                XCTFail("Problem object parameter \(MovieParams.title)")
            }
            
            // valid release date
            if let releaseDate = movieObject.releaseDate  {
                XCTAssertNotNil(releaseDate)
            }else {
                XCTFail("Problem object parameter \(MovieParams.releaseDate)")
            }
        }
        
    }
    
}
