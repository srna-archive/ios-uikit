//
//  Note.swift
//  CrashCourse-UIKit
//
//  Created by Tomas Srna on 18/04/16.
//  Copyright © 2016 SRNA. All rights reserved.
//

import Foundation

class Note {
    var text : String
    var task : Task
    
    init(text : String, task: Task) {
        self.text = text
        self.task = task
    }
}
