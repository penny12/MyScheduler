//
//  DoneListViewController.swift
//  MyScheduler
//
//  Created by Takuya Nakajima on 2018/08/13.
//  Copyright © 2018 Takuya Nakajima. All rights reserved.
//

import UIKit
import CalendarView
import SwiftMoment
import RealmSwift

class DoneListViewController: UITableViewController {
    
    /* -- Relation Realm -- */
    let realm = try! Realm()
    var todoItem : Results<Item>?

    var selectedDate : ScheduleDate? {
        didSet {
            loadItems()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        print("moment: " + "\(selectedDate)")
        
        loadItems()
    }


    // MARK: - TableView Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItem?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DoneItemCell", for: indexPath)
        
        if let item = todoItem?[indexPath.row] {
            cell.textLabel?.text = item.name
        } else {
            cell.textLabel?.text = "No Items Added"
        }

        return cell
    }
    
    // MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Actions
    @IBAction func addButtonPressed(_ sender: Any) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Done Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
//            let newItem = Item()
//            newItem.name = textField.text!
//            self.save(item: newItem)
            
            
            if let currentDate = self.selectedDate {
                do {
                    try self.realm.write {
                        let newItem = Item()
                        newItem.name = textField.text!
                        currentDate.items.append(newItem)
                    }
                } catch {
                    print("Error saving new items, \(error)")
                }
            }
            
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Realm Function
    func loadItems() {
        todoItem = selectedDate?.items.sorted(byKeyPath: "name", ascending: true)
        
        tableView.reloadData()
    }
}
