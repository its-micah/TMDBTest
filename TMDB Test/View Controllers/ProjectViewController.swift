//
//  ProjectViewController.swift
//  TMDB Test
//
//  Created by Micah Lanier on 3/26/18.
//  Copyright © 2018 Micah Lanier. All rights reserved.
//

import UIKit
import TMDBSwift

class ProjectViewController: UIViewController {

    private lazy var logViewController: LogViewControllerTwo = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var vc = storyboard.instantiateViewController(withIdentifier: "LogViewControllerTwo") as! LogViewControllerTwo
        self.add(asChildViewController: vc)
        return vc
    }()
    
    private lazy var clockViewController: ClockViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var vc = storyboard.instantiateViewController(withIdentifier: "ClockViewController") as! ClockViewController
        self.add(asChildViewController: vc)
        return vc
    }()
    
    private lazy var notesViewController: NotesViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var vc = storyboard.instantiateViewController(withIdentifier: "NotesViewController") as! NotesViewController
        self.add(asChildViewController: vc)
        return vc
    }()
    
    @IBOutlet weak var runtimeLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var projectSegmentedController: ProjectSegmentedControl!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var projectBackdropImageView: UIImageView!
    @IBOutlet weak var gradientView: GradientView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var directorNameLabel: UILabel!
    var currentProject: ResearchProject?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        setUpUI()
//        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//        self.navigationController?.navigationBar.shadowImage = UIImage()
//        self.navigationController?.navigationBar.isTranslucent = true
//        self.navigationController?.navigationBar.tintColor = .white
//        self.navigationController?.navigationBar.backgroundColor = .clear
//        self.navigationController?.navigationBar.isTranslucent = true
//        self.navigationController?.navigationBar.backgroundColor = .clear
        
//        self.posterImageView.isHidden = true
        self.posterImageView.layer.borderWidth = 3.0
        self.posterImageView.layer.borderColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1.0).cgColor
        add(asChildViewController: logViewController)
        logViewController.currentProject = currentProject
        

    

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUpUI() {
        self.gradientView.alpha = 0
        self.projectBackdropImageView.alpha = 0
        guard let movie = currentProject else {
            print("No project here")
            return
        }
        movieTitleLabel.text = movie.title
        posterImageView.kf.setImage(with: movie.makePosterURL(movie.posterPath))
        
        MovieDetailedMDB.movie(movieID: movie.movieID) { (apiReturn, details) in
            if let logline = details?.tagline {
                print("This is the tagline -> \(logline)")
            }
            
            if let runtime = details?.runtime, let releaseDate = details?.release_date {
                // I need to only grab the year in releaseDate. Returns as Year-Month-Day
                let convertedYear = self.convertDateFormater(releaseDate)
                self.yearLabel.text = convertedYear
                self.runtimeLabel.text = "\(runtime) mins"
            }
        }
        
        MovieMDB.credits(movieID: movie.movieID) { (apiReturn, credits) in
            var directorName: String?
            if let director = credits?.crew.filter({ $0.job == "Director" }) {
                if director.count > 1{
                    var directorsArray = [String]()
                    for directors in director {
                        directorsArray.append(directors.name)
                    }
                    directorName = directorsArray.joined(separator: " & ")
                } else if director.count == 1 {
                    directorName = director[0].name
                }
            } else {
                directorName = ""
            }
            self.directorNameLabel.text = directorName
        }
        
        MovieMDB.images(movieID: currentProject?.movieID) { (apiReturn, details) in
            if let backdrops = details?.backdrops {
                let path = backdrops[0].file_path
//                self.projectBackdropImageView.kf.setImage(with: URL(string: baseURL + backdropSize + path!))
                self.projectBackdropImageView.kf.setImage(with: URL(string: baseURL + backdropSize + path!), placeholder: nil, options: nil, progressBlock: nil, completionHandler: { (backdrop, error, cacheType, url) in
                    self.projectBackdropImageView.image = backdrop
                    UIView.animate(withDuration: 0.3, animations: {
                        self.gradientView.alpha = 1
                        self.projectBackdropImageView.alpha = 1
                    })
                })
            }
        }
        
        
    }
    
    func convertDateFormater(_ date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "yyyy"
        return  dateFormatter.string(from: date!)
        
    }
    
    
    
    override func viewDidLayoutSubviews() {
        gradientView.gradientLayer.colors = [UIColor(red: 0, green: 0, blue: 0, alpha: 0.85).cgColor, UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).cgColor, UIColor(red: 0, green: 0, blue: 0, alpha: 0.65).cgColor, UIColor(red: 0, green: 0, blue: 0, alpha: 0.85).cgColor]
        gradientView.gradientLayer.gradient = GradientPoint.topBottom.draw()
    }
    
    private func add(asChildViewController viewController: UIViewController) {
        addChildViewController(viewController)
        containerView.addSubview(viewController.view)
        viewController.view.frame = containerView.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        viewController.didMove(toParentViewController: self)
    }
    
    private func updateViewWithIndex(_ index: Int) {
        logViewController.view.isHidden = (index != 0)
        clockViewController.view.isHidden = (index != 1)
        notesViewController.view.isHidden = (index != 2)
    }
    
    @IBAction func SegmentedControlValueChanged(_ sender: ProjectSegmentedControl) {
        updateViewWithIndex(sender.selectedSegmentIndex)
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
