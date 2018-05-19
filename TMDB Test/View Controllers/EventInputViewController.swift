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
        movieNameLabel.text = currentProject?.title
        timePicker.delegate = self
        eventTextView.delegate = self
        eventTextView.text = "What Happened?"
        eventTextView.textColor = .lightGray
        self.eventTextView.becomeFirstResponder()
        eventTextView.selectedTextRange = eventTextView.textRange(from: eventTextView.beginningOfDocument, to: eventTextView.beginningOfDocument)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSaveTapped(_ sender: Any) {
        print("Save")
        let timestamp: String = "\(hour):\(minutes):\(seconds)"
        let event = Event(description: eventTextView.text, timestamp: timestamp)
        delegate?.addEvent(event)
        self.eventTextView.resignFirstResponder()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onCloseTapped(_ sender: Any) {
        self.eventTextView.resignFirstResponder()
        self.dismiss(animated: true, completion: nil)
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
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let pickerLabel = UILabel()
        var rowTitle: String = ""
        switch component {
        case 0:
            rowTitle = "Hour"
        case 1:
            rowTitle = "Minute"
        case 2:
            rowTitle = "Second"
        default:
            rowTitle = ""
        }
        let titleData = "\(row) \(rowTitle)"
        let myTitle = NSAttributedString(string: titleData, attributes: [NSAttributedStringKey.font: UIFont(name: "Avenir", size: 20)!])
        pickerLabel.attributedText = myTitle
        return pickerLabel
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return 4
        case 1,2:
            return 60
            
        default:
            return 0
        }
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

extension EventInputViewController: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText = textView.text
        let updatedText = (currentText! as NSString).replacingCharacters(in: range, with: text)
        if updatedText.isEmpty {
            textView.text = "What Happened?"
            textView.textColor = .lightGray
            textView.selectedTextRange = textView.textRange(from: eventTextView.beginningOfDocument, to: eventTextView.beginningOfDocument)
            return false
        } else if textView.textColor == .lightGray && !text.isEmpty {
            textView.text = nil
            textView.textColor = .black
        }
        return true
    }
    
    func textViewDidChangeSelection(_ textView: UITextView) {
        if self.view.window != nil {
            if textView.textColor == .lightGray {
                textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
            }
        }
    }
    
}
