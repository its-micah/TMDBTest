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
        navigationItem.largeTitleDisplayMode = .never
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController!.view.backgroundColor = UIColor.clear
        self.navigationController?.navigationBar.backgroundColor = UIColor.clear
        
        startProjectButton.layer.cornerRadius = startProjectButton.frame.height / 2
        startProjectButton.clipsToBounds = true
        setupWith(selectedMovie!)

        self.view.backgroundColor = ColorMode.light.backgroundColor

        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    func makeURL(_ path: String?) -> URL? {
//        return (path != nil) ? URL(string: baseURL + posterSize + path!) : nil
//    }
    
    func setupWith(_ movie: MovieMDB) {
        preFillStuff(movie)
        
        MovieDetailedMDB.movie(movieID: movie.id) { (apiReturn, details) in
            if let logline = details?.tagline {
                print("This is the tagline -> \(logline)")
            }
            
            if let runtime = details?.runtime, let releaseDate = details?.release_date {
                // I need to only grab the year in releaseDate. Returns as Year-Month-Day
                let convertedYear = self.convertDateFormater(releaseDate)
                self.yearAndRuntimeLabel.text = "\(convertedYear)   \(runtime) mins"
            }
        }
        
        MovieMDB.credits(movieID: movie.id) { (apiReturn, credits) in
            var directorName: String?
            var writerName: String?
            let director = credits?.crew.filter { $0.job == "Director" }
            if director!.count > 1{
                var directorsArray = [String]()
                for directors in director! {
                    directorsArray.append(directors.name)
                }
                directorName = directorsArray.joined(separator: " & ")
            } else if director!.count == 1 {
                directorName = director![0].name
            } else {
                directorName = ""
            }
            
//            if let writer = credits?.crew.filter({ (crew) -> Bool in
//                if crew.job == "Screenplay" || crew.job == "Writer" {
//                    return true
//                } else {
//                    return false
//                }
//            }) {
//
//            }
            
            if let writer = credits?.crew.filter({ $0.job == "Screenplay" || $0.job == "Writer" }) {
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
    
    func preFillStuff(_ movie: MovieMDB) {
        if let moviePoster = movie.poster_path {
            let link = makeURL(moviePoster)
//            print("The URL for this movie poster is \(link)")
            self.posterImageView.kf.setImage(with: link)
            self.posterImageView.layer.borderWidth = 3.0
            self.posterImageView.layer.borderColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1.0).cgColor
        }
        
        self.movieTitleLabel.text = movie.title ?? ""
        
        
        if let backdropImage = movie.backdrop_path {
            // We need to animate the alpha of this view when the image is received
            let link = URL(string: baseURL + backdropSize + backdropImage)
            self.backdropImageView.kf.setImage(with: link)
        }
    }
    
    func makeURL(_ path: String?) -> URL? {
        guard let actualPath = path else {
            return nil
        }
        return URL(string: baseURL + posterSize + actualPath)
    }
    
    
    override func viewDidLayoutSubviews() {
        gradientView.gradientLayer.colors = [UIColor.black.cgColor, UIColor.clear.cgColor, UIColor(red: 0, green: 0, blue: 0, alpha: 0.65).cgColor, UIColor.black.cgColor]
        gradientView.gradientLayer.gradient = GradientPoint.bottomTop.draw()
    }
    
    
    @IBAction func onStartProjectButtonTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "unwindToProjects", sender: self)
    }
    
    func convertDateFormater(_ date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "yyyy"
        return  dateFormatter.string(from: date!)
        
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
