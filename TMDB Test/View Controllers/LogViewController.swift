//
//  LogViewController.swift
//  TMDB Test
//
//  Created by Micah Lanier on 4/5/18.
//  Copyright © 2018 Micah Lanier. All rights reserved.
//

import UIKit

class LogViewController: UIViewController {
    
    var notes: Array<String>?
    var selectedIndexPath: IndexPath = IndexPath()
    var extraHeight: CGFloat = 100
    
    @IBOutlet weak var logTableView: UITableView!
    @IBOutlet weak var fab: FloatingActionButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logTableView.delegate = self
        addFAB()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addFAB() {
        fab.layer.backgroundColor = UIColor(hex: "DE4327").cgColor
        fab.layer.cornerRadius = fab.bounds.size.width / 2
        fab.layer.shadowColor = UIColor.black.cgColor
        fab.layer.shadowOffset = CGSize(width: 4, height: 4)
        fab.layer.shadowRadius = 4
        fab.layer.shadowOpacity = 0.5
        //        fab.hero.id = "fab"
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

extension LogViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let logCell = tableView.dequeueReusableCell(withIdentifier: "logCell") as! LogTableViewCell
        return logCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if selectedIndexPath == indexPath {
            return 56 + extraHeight
        }
        return 56
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndexPath = indexPath
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    
    
}
