//
//  ProjectTabBarController.swift
//  TMDB Test
//
//  Created by Micah Lanier on 4/8/18.
//  Copyright © 2018 Micah Lanier. All rights reserved.
//

import UIKit

class ProjectTabBarController: UITabBarController {
    
    var currentProject: ResearchProject?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = false
        self.extendedLayoutIncludesOpaqueBars = true

//        self.title = currentProject?.title
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
