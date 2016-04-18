//
//  Task.swift
//  CrashCourse-UIKit
//
//  Created by Tomas Srna on 18/04/16.
//  Copyright © 2016 SRNA. All rights reserved.
//

import Foundation

struct Task {
    var name : String
    var dueDate : NSDate
    var notes : [Note]
    
    var dueDateFormatted : String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .LongStyle
        dateFormatter.timeStyle = .NoStyle
        return dateFormatter.stringFromDate(dueDate)
    }
}
