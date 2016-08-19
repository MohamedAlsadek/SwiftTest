//
//  MovieTableViewCell.swift
//  test
//
//  Created by Mohamed Alsadek on 7/30/16.
//  Copyright © 2016 Mohamed Alsadek. All rights reserved.
//

import UIKit
import AlamofireImage

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var imageViewPoster: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelReleaseDate: UILabel!
}

extension MovieTableViewCell {
    
    func configure(withMovie movie: Movie?) {
        self.imageViewPoster.af_setImageWithURL(NSURL(string: (movie?.posterPath)!)!)
        self.labelTitle.text = movie?.title
        self.labelReleaseDate.text = movie?.releaseDate
    }
}
