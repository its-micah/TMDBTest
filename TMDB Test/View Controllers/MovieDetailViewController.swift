//
//  MovieDetailViewController.swift
//  TMDB Test
//
//  Created by Micah Lanier on 3/9/18.
//  Copyright © 2018 Micah Lanier. All rights reserved.
//

import UIKit
import TMDBSwift
import Kingfisher

class MovieDetailViewController: UIViewController {
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var directorNameLabel: UILabel!
    @IBOutlet weak var backdropImageView: UIImageView!
    @IBOutlet weak var writerNameLabel: UILabel!
    @IBOutlet weak var yearAndRuntimeLabel: UILabel!
    @IBOutlet weak var startProjectButton: UIButton!
    @IBOutlet weak var gradientView: GradientView!
    var selectedMovie: MovieMDB?
    var gradientLayer: CAGradientLayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupWith(selectedMovie!)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.barStyle = .black
        self.navigationController?.navigationBar.tintColor = .white
        
        startProjectButton.layer.cornerRadius = startProjectButton.bounds.size.width / 7.5
        startProjectButton.clipsToBounds = true
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupWith(_ movie: MovieMDB) {
        
        if let moviePoster = movie.poster_path {
            let link = URL(string: baseURL + posterSize + moviePoster)
            self.posterImageView.kf.setImage(with: link)
            self.posterImageView.layer.borderWidth = 3.0
            self.posterImageView.layer.borderColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1.0).cgColor
        }
        if let movieTitle = movie.title {
            self.movieTitleLabel.text = movieTitle
        }
        
        if let backdropImage = movie.backdrop_path {
            let link = URL(string: baseURL + backdropSize + backdropImage)
            self.backdropImageView.kf.setImage(with: link)
        }
        
        MovieDetailedMDB.movie(movieID: movie.id) { (apiReturn, details) in
            if let logline = details?.tagline {
                print("This is the tagline -> \(logline)")
            }
            
            if let runtime = details?.runtime, let releaseDate = details?.release_date {
                self.yearAndRuntimeLabel.text = "\(releaseDate) \(runtime) mins"
            }
        }
        
        MovieMDB.credits(movieID: movie.id) { (apiReturn, credits) in
            let jobs = credits?.crew.filter { $0.job != nil }
            for job in jobs! {
                print(job.job)
            }
            var directorName: String?
            var writerName: String?
            let director = credits?.crew.filter { $0.job == "Director" }
            if director!.count > 1{
                var directorsArray = [String]()
                for directors in director! {
                    directorsArray.append(directors.name)
                }
                directorName = directorsArray.joined(separator: " & ")
            } else {
                directorName = director![0].name
            }
            
            if let writer = credits?.crew.filter({ $0.job == "Screenplay" }) {
                if writer.count >= 1 {
                    var writersArray = [String]()
                    for writers in writer {
                       writersArray.append(writers.name)
                    }
                    writerName = writersArray.joined(separator: ", ")
                }
            } else {
                self.writerNameLabel.isHidden = true
            }
            
            
            self.directorNameLabel.text = directorName
            self.writerNameLabel.text = writerName
        }
    }
    
    
    override func viewDidLayoutSubviews() {
        gradientView.gradientLayer.colors = [UIColor.black.cgColor, UIColor.clear.cgColor, UIColor(red: 0, green: 0, blue: 0, alpha: 0.65).cgColor, UIColor.black.cgColor]
        gradientView.gradientLayer.gradient = GradientPoint.bottomTop.draw()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
