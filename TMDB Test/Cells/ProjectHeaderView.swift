//
//  ProjectHeaderView.swift
//  TMDB Test
//
//  Created by Micah Lanier on 4/9/18.
//  Copyright © 2018 Micah Lanier. All rights reserved.
//

import UIKit
import TMDBSwift

protocol ProjectHeaderDelegate {
    func didTapDetailsButton()
}

class ProjectHeaderView: UITableViewHeaderFooterView {

    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var directorNameLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var runtimeLabel: UILabel!
    var delegate: ProjectHeaderDelegate?
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    @IBAction func onMoreTapped(_ sender: Any) {
        print("Show project details")
        self.delegate?.didTapDetailsButton()
    }
    
    func cofigureWith(_ project: ResearchProject) {
        self.movieTitleLabel.text = project.title
        self.directorNameLabel.text = project.director
        self.yearLabel.text = project.year
        self.runtimeLabel.text = project.runtime
    }
    
}
