//
//  LogViewControllerTwo.swift
//  TMDB Test
//
//  Created by Micah Lanier on 4/9/18.
//  Copyright © 2018 Micah Lanier. All rights reserved.
//

import UIKit
import PopupDialog


class LogViewControllerTwo: UIViewController, ProjectHeaderDelegate, EventInputDelegate {
    @IBOutlet weak var logTableView: UITableView!
    var currentProject: ResearchProject?
    var events = [Event]()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        logTableView.register(UINib(nibName: "ProjectHeaderView", bundle: Bundle.main), forHeaderFooterViewReuseIdentifier: "ProjectHeaderView")
        logTableView.delegate = self
        
        let edgeInsets = UIEdgeInsetsMake(-45, 0, 0, 0)
        logTableView.contentInset = edgeInsets
        logTableView.scrollIndicatorInsets = edgeInsets
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")

    }

    override func viewWillAppear(_ animated: Bool) {
        logTableView.sectionHeaderHeight = UITableViewAutomaticDimension
        logTableView.estimatedSectionHeaderHeight = 152 // for example. Set your average height
        logTableView.reloadData()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
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
        let popup = PopupDialog(viewController: vc, buttonAlignment: .horizontal, transitionStyle: .zoomIn, preferredWidth: self.view.frame.width, gestureDismissal: false, hideStatusBar: false, completion: nil)
        vc.popup = popup
        vc.delegate = self
        self.present(popup, animated: true, completion: nil)
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
