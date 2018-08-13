//
//  ViewController.swift
//  MyScheduler
//
//  Created by Takuya Nakajima on 2018/08/13.
//  Copyright © 2018 Takuya Nakajima. All rights reserved.
//

import UIKit
import CalendarView
import SwiftMoment

class ViewController: UIViewController {
    
    @IBOutlet weak var calendar: CalendarView!
    
    var date: Moment! {
        didSet {
            title = date.format("MMMM d, yyyy")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        date = moment()
        calendar.delegate = self
    }
    
}

extension ViewController: CalendarViewDelegate {
    
    func calendarDidSelectDate(date: Moment) {
        self.date = date
    }
    
    func calendarDidPageToDate(date: Moment) {
        self.date = date
    }
    
}
