//
//  ClockViewController.swift
//  TMDB Test
//
//  Created by Micah Lanier on 4/5/18.
//  Copyright © 2018 Micah Lanier. All rights reserved.
//

import UIKit

class ClockViewController: UIViewController {
    
    var clockView: ClockView?

    override func viewDidLoad() {
        super.viewDidLoad()
        clockView = ClockView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width / 1.2, height: self.view.frame.height / 1.2))
        clockView?.makeWaves()
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
