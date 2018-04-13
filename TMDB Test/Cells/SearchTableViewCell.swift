//
//  SearchTableViewCell.swift
//  TMDB Test
//
//  Created by Micah Lanier on 3/7/18.
//  Copyright © 2018 Micah Lanier. All rights reserved.
//

import UIKit
import TMDBSwift
import Kingfisher


class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureWith(_ movie: MovieMDB) {
        if let moviePoster = movie.poster_path {
            let link = URL(string: baseURL + posterSize + moviePoster)
            self.posterImageView.kf.setImage(with: link)
        }
        if let movieTitle = movie.title {
            self.titleLabel.text = movieTitle
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
