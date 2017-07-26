//
//  MovieTableViewCell.swift
//  MovieSearch-Obj-C
//
//  Created by Luis Puentes on 7/25/17.
//  Copyright © 2017 LuisPuentes. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    var movies: LPMovie? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        
        guard let movie = movies else { return }
        titleLabel.text = movie.title
        ratingLabel.text = "Rating: \(movie.rating)"
        ratingLabel.adjustsFontSizeToFitWidth = true
        guard let overview = movie.summary else { return }
        summaryTextView.text = "Summary: \(overview)"
        summaryTextView.layer.cornerRadius = 5
        summaryTextView.layer.masksToBounds = true
        summaryTextView.layer.borderColor = UIColor.white.cgColor
        summaryTextView.layer.borderWidth = 0.5
        
        LPMovieController.shared().fetchMovieImage(movie.movieImage) { (image) in
            DispatchQueue.main.async {
                self.movieImage.image = image
            }
        }
    }

    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var summaryTextView: UITextView!
}
