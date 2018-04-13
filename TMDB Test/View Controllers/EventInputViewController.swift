//
//  EventInputViewController.swift
//  TMDB Test
//
//  Created by Micah Lanier on 4/12/18.
//  Copyright © 2018 Micah Lanier. All rights reserved.
//

import UIKit
import PopupDialog

protocol EventInputDelegate {
    func addEvent(_ event: Event)
}

class EventInputViewController: UIViewController {

    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var timePicker: UIPickerView!
    @IBOutlet weak var eventTextView: UITextView!
    var hour:Int = 0
    var minutes:Int = 0
    var seconds:Int = 0
    public weak var popup: PopupDialog?
    var currentProject: ResearchProject?
    var delegate: EventInputDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSaveTapped(_ sender: Any) {
        print("Save")
        let event = Event(description: eventTextView.text, timestamp: "00:45:16")
        delegate?.addEvent(event)
        popup?.dismiss()
    }
    
    @IBAction func onCloseTapped(_ sender: Any) {
        popup?.dismiss()
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

extension EventInputViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return 25
        case 1,2:
            return 60
            
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return pickerView.frame.size.width/3
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return "\(row) Hour"
        case 1:
            return "\(row) Minute"
        case 2:
            return "\(row) Second"
        default:
            return ""
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            hour = row
        case 1:
            minutes = row
        case 2:
            seconds = row
        default:
            break;
        }
    }
}
