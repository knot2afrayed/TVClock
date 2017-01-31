//
//  ViewController.swift
//  TVClock
//
//  Created by Shawn Haynes on 1/18/17.
//  Copyright © 2017 Shawn Haynes. All rights reserved.
//


import UIKit


class ViewController: UIViewController {
    
    @IBOutlet var littleView: UIView!
    @IBOutlet var textView: UITextView!
    
    @IBOutlet var ScoreLbl: UILabel!
    
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var dayLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(displayTime), userInfo: nil, repeats:true);
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    static func currentTime() -> String {
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        return "\(hour):\(minutes)"
    }
    func displayTime(){
        let weekDays: [String] = ["Sunday", "Monday", "Tuesday","Wednesday", "Thursday","Friday", "Saturday"]
        let currentDateTime = Date()
        let calendar = Calendar.current
        let month = calendar.component(.month, from: currentDateTime)
        let year = calendar.component(.year, from: currentDateTime)
        let date = calendar.component(.day, from: currentDateTime)
        let hours = calendar.component(.hour, from: currentDateTime)
        let minutes = calendar.component(.minute, from: currentDateTime)
        let seconds = calendar.component(.second, from: currentDateTime)
        let day = calendar.component(.weekday, from: currentDateTime) - 1
        let weekday = weekDays[day]
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        formatter.dateStyle = .none
        let hour:Int
        let minute:String
        let second:String
        if (hours > 12) {
             hour = hours - 12
            
        }else if (hours == 0){
                hour = 12
        }
        else
        {
             hour = hours
        }
        if minutes < 10 {
             minute = "0\(minutes)"
        }else{
             minute = "\(minutes)"
        }
        if seconds < 10 {
         second = "0\(seconds)"
        }else{
        second = "\(seconds)"
        }
        let time = "\(hour):\(minute):\(second)"
        ScoreLbl.text = "\(time)"
        dayLabel.text = "\(weekday)"
        dateLabel.text = "\(month)/\(date)/\(year)"
    }
   
    @IBAction func buttonPressed(_ sender: Any) {
        if self.littleView.backgroundColor != UIColor.blue{
        self.littleView.backgroundColor = UIColor.blue
            self.dayLabel.textColor = UIColor.blue
        }else{
            self.dayLabel.textColor = UIColor.red
            self.littleView.backgroundColor = UIColor.red
        }
    }
}
    
    
    


