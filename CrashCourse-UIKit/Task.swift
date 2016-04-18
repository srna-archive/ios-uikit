//
//  Task.swift
//  CrashCourse-UIKit
//
//  Created by Tomas Srna on 18/04/16.
//  Copyright © 2016 SRNA. All rights reserved.
//

import Foundation

class Task {
    var name : String
    var dueDate : NSDate
    var notes = [Note]()
    
    init(name : String, dueDate : NSDate) {
        self.name = name
        self.dueDate = dueDate
    }
    
    var dueDateFormatted : String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .LongStyle
        dateFormatter.timeStyle = .NoStyle
        return dateFormatter.stringFromDate(dueDate)
    }
}
