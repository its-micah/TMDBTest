//
//  HomeViewController.swift
//  TMDB Test
//
//  Created by Micah Lanier on 3/18/18.
//  Copyright © 2018 Micah Lanier. All rights reserved.
//

import UIKit
import TMDBSwift
import Kingfisher

fileprivate extension Selector {
    static let buttonTapped =
        #selector(HomeViewController.toggleColorMode)
}

private struct Const {
    /// Image height/width for Large NavBar state
    static let ImageSizeForLargeState: CGFloat = 22
    /// Margin from right anchor of safe area to right anchor of Image
    static let ImageRightMargin: CGFloat = 16
    /// Margin from bottom anchor of NavBar to bottom anchor of Image for Large NavBar state
    static let ImageBottomMarginForLargeState: CGFloat = 14
    /// Margin from bottom anchor of NavBar to bottom anchor of Image for Small NavBar state
    static let ImageBottomMarginForSmallState: CGFloat = 6
    /// Image height/width for Small NavBar state
    static let ImageSizeForSmallState: CGFloat = 18
    /// Height of NavBar for Small state. Usually it's just 44
    static let NavBarHeightSmallState: CGFloat = 44
    /// Height of NavBar for Large state. Usually it's just 96.5 but if you have a custom font for the title, please make sure to edit this value since it changes the height for Large state of NavBar
    static let NavBarHeightLargeState: CGFloat = 96.5
}

extension UIButton {
    func setBackgroundColor(color: UIColor, forState: UIControlState) {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        UIGraphicsGetCurrentContext()!.setFillColor(color.cgColor)
        UIGraphicsGetCurrentContext()!.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        self.setBackgroundImage(colorImage, for: forState)
    }}

extension UIColor {
    convenience init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0
        
        var rgbValue: UInt64 = 0
        
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff, alpha: 1
        )
    }
}


class HomeViewController: UIViewController, UIScrollViewDelegate, Deleteable {

    
    
    @IBOutlet weak var fab: FloatingActionButton!
    @IBOutlet weak var projectsCollectionView: UICollectionView!
    var projects: [ResearchProject] = []
    var currentColorMode: ColorMode?
    private let dataSource: ProjectsDataSource = ProjectsDataSource()
    private let imageView = UIImageView(image: UIImage(named: "ColorMode-Light"))
    var newCellAdded: Bool?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        TMDBConfig.apikey = APIKey
        projectsCollectionView.isUserInteractionEnabled = true
        currentColorMode = .light
        setUpDisplayWith(mode: currentColorMode!)
        projectsCollectionView.delegate = self
        addGestureRecognizers()
        
        styleNavBar()
        self.projectsCollectionView.delegate = self
        self.projectsCollectionView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
        newCellAdded = false
        navigationItem.rightBarButtonItems = [editButtonItem, UIBarButtonItem.init(barButtonSystemItem: .organize, target: self, action: Selector.buttonTapped)]
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        styleNavBar()
        setUpDisplayWith(mode: ColorMode.light)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if newCellAdded == true {
            let newCell = projectsCollectionView.cellForItem(at: IndexPath(row: 0, section: 0)) as! PosterCollectionViewCell
            newCell.shimmer()
            newCellAdded = false
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addGestureRecognizers() {
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongGesture(gesture:)))
        self.projectsCollectionView.addGestureRecognizer(longPressGesture)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func styleNavBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.topItem?.title = "Research Projects"
        let attributes = [
            NSAttributedStringKey.font:UIFont.boldSystemFont(ofSize: 28)
        ]
        navigationController?.navigationBar.largeTitleTextAttributes = attributes
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
//        addImageToNavBar()
    }
    
    func addImageToNavBar() {
        guard let navigationBar = self.navigationController?.navigationBar else { return }
        navigationBar.addSubview(imageView)
        imageView.layer.cornerRadius = Const.ImageSizeForLargeState / 2
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.rightAnchor.constraint(equalTo: navigationBar.rightAnchor, constant: -Const.ImageRightMargin),
            imageView.bottomAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: -Const.ImageBottomMarginForLargeState),
            imageView.heightAnchor.constraint(equalToConstant: Const.ImageSizeForLargeState),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor)
            ])
    }
    
    
    @IBAction func onFabTapped(_ sender: Any) {
        print("tapped")
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        toggleColorMode()
    }
    
    @objc func toggleColorMode() {
        if currentColorMode == .light {
            currentColorMode = .dark
        } else {
            currentColorMode = .light
        }
        setUpDisplayWith(mode: currentColorMode!)
    }
    
    func setUpDisplayWith(mode: ColorMode) {
        self.projectsCollectionView.backgroundColor = mode.backgroundColor
        self.navigationController?.navigationBar.barTintColor = mode.backgroundColor
        self.navigationController?.navigationBar.backgroundColor = mode.backgroundColor
        switch mode {
        case .dark:
            imageView.image = UIImage(named: "ColorMode-Dark")
        case .light:
            imageView.image = UIImage(named: "ColorMode-Light")
        }
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor: mode.textColor,              NSAttributedStringKey.font:UIFont.boldSystemFont(ofSize: 28)]
    }
    
    @IBAction func unwindToHere(segue: UIStoryboardSegue) {
        if let sourceViewController = segue.source as? MovieDetailViewController {
            guard let movie = sourceViewController.selectedMovie else {
                newCellAdded = false
                return
            }
            let newProject = ResearchProject(title: movie.title!, movieID: movie.id!, posterPath: movie.poster_path, backdropPath: movie.backdrop_path, notes: [String](), researchLog: ResearchLog(), director: nil, writer: nil, runtime: nil, year: nil)
            dataSource.addNewProject(newProject)
            self.projectsCollectionView.reloadData()
            newCellAdded = true
        }
    }
    
    @objc func handleLongPress(gestureRecognizer : UILongPressGestureRecognizer){
        
        if (gestureRecognizer.state != UIGestureRecognizerState.began){
            return
        }
        
        let p = gestureRecognizer.location(in: projectsCollectionView)
        
        if let indexPath = self.projectsCollectionView.indexPathForItem(at: p) {
            //do whatever you need to do
            print("Item at index path \(indexPath) has been long pressed")
        }
        
    }
    
    @objc func handleLongGesture(gesture: UILongPressGestureRecognizer) {
        
        switch(gesture.state) {
            
        case UIGestureRecognizerState.began:
            guard let selectedIndexPath = self.projectsCollectionView.indexPathForItem(at: gesture.location(in: self.projectsCollectionView)) else {
                break
            }
            projectsCollectionView.beginInteractiveMovementForItem(at: selectedIndexPath)
        case UIGestureRecognizerState.changed:
            projectsCollectionView.updateInteractiveMovementTargetPosition(gesture.location(in: gesture.view!))
        case UIGestureRecognizerState.ended:
            projectsCollectionView.endInteractiveMovement()
        default:
            projectsCollectionView.cancelInteractiveMovement()
        }
    }
    
    func deleteProject(atCell cell: PosterCollectionViewCell) {
        guard let indexPath = projectsCollectionView.indexPath(for: cell) else { return }
        dataSource.removeProject(at: (indexPath.item))
        projectsCollectionView.deleteItems(at: [indexPath])
        print("Deleted project")
    }
    
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.numberOfProjectsInSection()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let posterCell = collectionView.dequeueReusableCell(withReuseIdentifier: "posterCell", for: indexPath) as! PosterCollectionViewCell
        let project = dataSource.projectForItemAtIndexPath(indexPath)
        posterCell.posterImageView.kf.setImage(with: project?.makePosterURL(project?.posterPath))
        posterCell.movieTitleLabel.text = project?.title
        posterCell.isEditing = isEditing
        posterCell.delegate = self
        return posterCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if !isEditing {
            let project = dataSource.projectForItemAtIndexPath(indexPath)
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let destination = storyboard.instantiateViewController(withIdentifier: "ProjectVC") as! ProjectViewController
//            let destination = storyboard.instantiateViewController(withIdentifier: "ProjectTabBarController") as! ProjectTabBarController
            destination.currentProject = project
//            (destination.viewControllers![0].childViewControllers[0] as! LogViewControllerTwo).currentProject = project
//            (destination.viewControllers![0] as! LogViewController).currentProject = project
//            destination.currentProject = project
            navigationController?.pushViewController(destination, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        dataSource.moveProjectAtIndexPath(sourceIndexPath, toIndexPath: destinationIndexPath)
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        fab.switchState()
        let indexes = projectsCollectionView.indexPathsForVisibleItems
        for index in indexes {
            let projectCell = projectsCollectionView.cellForItem(at: index) as! PosterCollectionViewCell
            projectCell.isEditing = editing
        }
    }
    
//    func collectionView(_ collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: projectsCollectionView.bounds.width / 1.13, height: projectsCollectionView.bounds.height / 2.2)
//    }
//    
//    func collectionView(_ collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 16.0
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout
//        collectionViewLayout: UICollectionViewLayout,
//                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 16.0
//    }
    
}
