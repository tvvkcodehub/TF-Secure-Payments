//
//  TSDatePickerPopOverController.swift
//  TellerSecureTransfer
//
//  Created by Vamsi Krishna Tirumala on 20/02/21.
//

import UIKit

protocol TSCalendarPopOverControllerDelegate : class {
    func doneSelectedDate(selectedDate : String)
    func cancelCalendar()
}

class TSDatePickerPopOverController: UIViewController {

    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var calendarPicker: UIDatePicker!
    weak var delegate : TSCalendarPopOverControllerDelegate! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }

    
    
    @IBAction func cancelTapped(_ sender: Any) {
        self.delegate.cancelCalendar()
    }
    
    @IBAction func doneTapped(_ sender: Any) {
        self.calendarPicker.datePickerMode = UIDatePicker.Mode.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MMM-yyyy"
        let selectedDate = dateFormatter.string(from: self.calendarPicker.date)
        self.delegate.doneSelectedDate(selectedDate: selectedDate)
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        var label: UILabel
        if let view = view as? UILabel { label = view }
        else { label = UILabel() }
        
        label.text = "My Picker Text"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        
        return label
    }

}
