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

let baseURL = "https://image.tmdb.org/t/p/"
let posterSize = "w185"
let backdropSize = "w500"

extension UIImageView {
    
    func downloadedFrom(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
    func downloadedFrom(link: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url, contentMode: mode)
    }
    
    func applyNoir() {
        let context = CIContext(options: nil)
        let currentFilter = CIFilter(name: "CIPhotoEffectNoir")!
        currentFilter.setValue(CIImage(image: self.image!), forKey: kCIInputImageKey)
        let output = currentFilter.outputImage!
        let cgImage = context.createCGImage(output, from: output.extent)!
        let processedImage = UIImage(cgImage: cgImage, scale: (self.image?.scale)!, orientation: (self.image?.imageOrientation)!)
        self.image = processedImage
    }
}

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
            print("The poster link is \(link)")
//            self.posterImageView.downloadedFrom(link: link, contentMode: .scaleAspectFill)
            self.posterImageView.kf.setImage(with: link)
        }
        if let movieTitle = movie.title {
            self.titleLabel.text = movieTitle
        }
        
//        MovieDetailedMDB.movie(movieID: movie.id) { data, detailMovie in
//            print(detailMovie?.runtime)
//        }

        
                
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
