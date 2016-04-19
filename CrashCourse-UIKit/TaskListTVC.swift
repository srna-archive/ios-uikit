//
//  TaskListTVC.swift
//  CrashCourse-UIKit
//
//  Created by Tomas Srna on 18/04/16.
//  Copyright © 2016 SRNA. All rights reserved.
//

import UIKit
import CoreData

class TaskListTVC : UITableViewController, NSFetchedResultsControllerDelegate, TaskAddDelegate {
    
    var data = [Task]()
    
    enum Constants: String {
        case TaskCellReuseIdentifier = "TaskCell"
        case TaskAddSegueIdentifier = "TaskAddSegue"
        case NotesSegueIdentifier = "NotesSegue"
    }
    
    var selectedTask : Task?
    
    // MARK: View Controller Lifecycle
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        refresh()
    }
    
    func refresh() {
        tableView.reloadData()
    }
    
    // MARK: Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        super.prepareForSegue(segue, sender: sender)
        
        if let segueIdentifier = segue.identifier {
            switch segueIdentifier {
            case Constants.TaskAddSegueIdentifier.rawValue:
                if let navigationVC = segue.destinationViewController as? UINavigationController, taskAddVC = navigationVC.topViewController as? TaskAddTVC {
                    taskAddVC.delegate = self
                }
            case Constants.NotesSegueIdentifier.rawValue:
                if let notesVC = segue.destinationViewController as? NotesTVC, selected = selectedTask {
                    notesVC.navigationItem.title = "\(selected.name)"
                    notesVC.task = selected
                }
            default:
                break
            }
        }
    }
    
    @IBAction func unwindToTasks(segue: UIStoryboardSegue) {
    }
    
    // MARK: UITableViewDataSource
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(Constants.TaskCellReuseIdentifier.rawValue)!
        
        let task = data[indexPath.row]
        cell.textLabel?.text = task.name
        cell.detailTextLabel?.text = task.dueDateFormatted
        
        return cell
    }
    
    // MARK: UITableViewDelegate
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let selected = data[indexPath.row]
        selectedTask = selected
        performSegueWithIdentifier(Constants.NotesSegueIdentifier.rawValue, sender: self.tableView)
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        return [UITableViewRowAction(style: .Destructive, title: "Delete", handler: { action, indexPath in
            tableView.beginUpdates()
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            self.data.removeAtIndex(indexPath.row)
            tableView.endUpdates()
        })]
    }
    
    // MARK: TaskAddDelegate
    
    func addTask(name: String, dueDate: NSDate) {
        let newTask = Task(name: name, dueDate: dueDate)
        
        tableView.beginUpdates()
        tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: data.count, inSection: 0)], withRowAnimation: .Automatic)
        data.append(newTask)
        tableView.endUpdates()
    }
    
}
