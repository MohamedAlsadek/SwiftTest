//
//  MoviesListViewController.swift
//  test
//
//  Created by Mohamed Alsadek on 7/30/16.
//  Copyright © 2016 Mohamed Alsadek. All rights reserved.
//

import UIKit

class MoviesListViewController: UIViewController{

    
    @IBOutlet weak var tableViewMovies: UITableView!
    var moviesViewModel:MoviesListViewModel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableViewMovies.dataSource = self
        moviesViewModel = MoviesListViewModel(delegate: self)
        moviesViewModel?.fetchMovieListFromServer()
        
        tableViewMovies.accessibilityIdentifier = "tableViewMovies"
    }

    
    // MARK: - Memory Warning
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


// MARK: - UITableViewDataSource
extension MoviesListViewController: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (moviesViewModel?.moviesList.count)!
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell : MovieTableViewCell = tableView.dequeueReusableCellWithIdentifier("MovieTableViewCell", forIndexPath: indexPath) as! MovieTableViewCell
     
        let movie = moviesViewModel?.moviesList.objectAtIndex(indexPath.row) as! Movie
        cell.configure(withMovie: movie)
        
        return cell
     }
}

// MARK: - UpdateMovieListDelegate
extension MoviesListViewController: UpdateMovieListDelegate {
    
    func updateUI() {
        self.tableViewMovies.reloadData()
    }
    
    func handleError(error: NSError) {
        
        let alert = UIAlertController(title: "Alert", message: "Can't retrive movies!", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
}
