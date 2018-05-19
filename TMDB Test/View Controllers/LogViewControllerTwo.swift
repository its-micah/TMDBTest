//
//  LogViewControllerTwo.swift
//  TMDB Test
//
//  Created by Micah Lanier on 4/9/18.
//  Copyright © 2018 Micah Lanier. All rights reserved.
//

import UIKit
import TMDBSwift
import PopupDialog


class LogViewControllerTwo: UIViewController, ProjectHeaderDelegate, EventInputDelegate {
    @IBOutlet weak var logTableView: UITableView!
    var currentProject: ResearchProject?
    var events = [Event]()
    let cardTransitioningDelegate = CardTransitioningDelegate()


    
    override func viewDidLoad() {
        super.viewDidLoad()

        logTableView.register(UINib(nibName: "ProjectHeaderView", bundle: Bundle.main), forHeaderFooterViewReuseIdentifier: "ProjectHeaderView")
        logTableView.delegate = self
        
        let edgeInsets = UIEdgeInsetsMake(-20, 0, 0, 0)
        logTableView.contentInset = edgeInsets
        logTableView.scrollIndicatorInsets = edgeInsets
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
//        setUpUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        logTableView.sectionHeaderHeight = UITableViewAutomaticDimension
        logTableView.estimatedSectionHeaderHeight = 152 // for example. Set your average height
        logTableView.reloadData()
        
    }
    
//    func setUpUI() {
//        self.gradientView.alpha = 0
//        self.projectBackdropImageView.alpha = 0
//        guard let movie = currentProject else {
//            print("No project here")
//            return
//        }
//        movieTitleLabel.text = movie.title
//        posterImageView.kf.setImage(with: movie.makePosterURL(movie.posterPath))
//
//        MovieDetailedMDB.movie(movieID: movie.movieID) { (apiReturn, details) in
//            if let logline = details?.tagline {
//                print("This is the tagline -> \(logline)")
//            }
//
//            if let runtime = details?.runtime, let releaseDate = details?.release_date {
//                // I need to only grab the year in releaseDate. Returns as Year-Month-Day
//                let convertedYear = self.convertDateFormater(releaseDate)
//                self.yearLabel.text = convertedYear
//                self.runtimeLabel.text = "\(runtime) mins"
//            }
//        }
//
//        MovieMDB.credits(movieID: movie.movieID) { (apiReturn, credits) in
//            var directorName: String?
//            if let director = credits?.crew.filter({ $0.job == "Director" }) {
//                if director.count > 1{
//                    var directorsArray = [String]()
//                    for directors in director {
//                        directorsArray.append(directors.name)
//                    }
//                    directorName = directorsArray.joined(separator: " & ")
//                } else if director.count == 1 {
//                    directorName = director[0].name
//                }
//            } else {
//                directorName = ""
//            }
//            self.directorNameLabel.text = directorName
//        }
//
//        MovieMDB.images(movieID: currentProject?.movieID) { (apiReturn, details) in
//            if let backdrops = details?.backdrops {
//                let path = backdrops[0].file_path
//                //                self.projectBackdropImageView.kf.setImage(with: URL(string: baseURL + backdropSize + path!))
//                self.projectBackdropImageView.kf.setImage(with: URL(string: baseURL + backdropSize + path!), placeholder: nil, options: nil, progressBlock: nil, completionHandler: { (backdrop, error, cacheType, url) in
//                    self.projectBackdropImageView.image = backdrop
//                    UIView.animate(withDuration: 0.3, animations: {
//                        self.gradientView.alpha = 1
//                        self.projectBackdropImageView.alpha = 1
//                    })
//                })
//            }
//        }
//
//
//    }
    
    func didTapDetailsButton() {
        print("Show Details")
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let destination = storyboard.instantiateViewController(withIdentifier: "ProjectDetailsViewController") as! ProjectDetailsViewController
        let navController = UINavigationController(rootViewController: destination)
        self.present(navController, animated: true, completion: nil)
    }
    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//
//        // Dynamic sizing for the header view
//        if let headerView = logTableView.tableHeaderView {
//            let height = headerView.systemLayoutSizeFitting(UILayoutFittingCompressedSize).height
//            var headerFrame = headerView.frame
//
//            // If we don't have this check, viewDidLayoutSubviews() will get
//            // repeatedly, causing the app to hang.
//            if height != headerFrame.size.height {
//                headerFrame.size.height = height
//                headerView.frame = headerFrame
//                logTableView.tableHeaderView = headerView
//            }
//        }
//    }
    
    func addEvent(_ event: Event) {
        events.append(event)
        logTableView.reloadData()
    }

    
    @IBAction func onAddEventButtonTapped(_ sender: Any) {
        print("show Add Event Dialogue")
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyboard.instantiateViewController(withIdentifier: "EventInputViewController") as! EventInputViewController
        vc.transitioningDelegate = cardTransitioningDelegate
        vc.delegate = self
        vc.modalPresentationStyle = .custom
        vc.currentProject = currentProject
        self.present(vc, animated: true, completion: {
            print("done presenting")
        })
    }
}

extension LogViewControllerTwo: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        cell.textLabel?.text = events[indexPath.row].description
        cell.detailTextLabel?.text = events[indexPath.row].timestamp
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = logTableView.dequeueReusableHeaderFooterView(withIdentifier: "ProjectHeaderView") as! ProjectHeaderView
        headerView.delegate = self
        headerView.cofigureWith(currentProject!)
        headerView.gradientView.gradientLayer.colors = [UIColor(red: 0, green: 0, blue: 0, alpha: 0.85).cgColor, UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).cgColor, UIColor(red: 0, green: 0, blue: 0, alpha: 0.65).cgColor, UIColor(red: 0, green: 0, blue: 0, alpha: 0.85).cgColor]
        headerView.gradientView.gradientLayer.gradient = GradientPoint.topBottom.draw()
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 152
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            events.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    
}
