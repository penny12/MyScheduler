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
import RealmSwift

class ViewController: UIViewController {
    
    /* -- Relation Realm -- */
    let realm = try! Realm()
    var savedDate : Results<ScheduleDate>?
    
    var selectedDate : String = ""
    
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
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
    }
        
    // MARK: - Calendar Delegate Methods
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! DoneListViewController
        
        let date = savedDate?.filter("date == %@", self.date.format("yyyyMMdd"))
        destinationVC.selectedDate = (date?.first)!

        print("prepare: ")
    }
    
    // MARK: - Data Manipulation Methods
    func save(saveDate: ScheduleDate) {
        do {
            try realm.write {
                realm.add(saveDate)
            }
        } catch {
            print("Error saving context, \(error)")
        }
    }
    
    func load() {
        savedDate = realm.objects(ScheduleDate.self)
    }
}

extension ViewController: CalendarViewDelegate {
    
    func calendarDidSelectDate(date: Moment) {
        self.date = date
        print("selected Date: " + "\(self.date)")
        
        self.load()
        if savedDate?.filter("date == %@", date.format("yyyyMMdd")).count == 0 {
            let newDate = ScheduleDate()
            newDate.date = date.format("yyyyMMdd")
            self.save(saveDate: newDate)
        }

        
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    func calendarDidPageToDate(date: Moment) {
        self.date = date
        print("Pageto Date: " + "\(date)")
    }
    
    
    
}
