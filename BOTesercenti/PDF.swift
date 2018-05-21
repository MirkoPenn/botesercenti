//
//  PDF.swift
//  Pdf
//
//  Created by Simone Penna on 20/05/2018.
//  Copyright © 2018 Simone Penna. All rights reserved.
//

import Foundation
import UIKit
import os.log

class PDF: NSObject, NSCoding {
    
    //MARK: Properties
    
    var name: String
    var size: String
    var date: Date
    
    //MARK: Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("pdf")
    
    //MARK: Types
    
    struct PropertyKey {
        static let name = "name"
        static let size = "size"
        static let date = "date"
    }
    
    //MARK: Initialization
    
    init?(name: String, size: String, date: Date) {
        
        // The name must not be empty
        guard !name.isEmpty else {
            return nil
        }
        
        // Initialize stored properties.
        self.name = name
        self.size = size
        self.date = date
        
    }
    
    //MARK: NSCoding
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(size, forKey: PropertyKey.size)
        aCoder.encode(date, forKey: PropertyKey.date)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        // The name is required. If we cannot decode a name string, the initializer should fail.
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else {
            os_log("Unable to decode the name for a PDF object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        // Because photo is an optional property of Meal, just use conditional cast.
        let size = aDecoder.decodeObject(forKey: PropertyKey.size) as? String
        
        let date = aDecoder.decodeObject(forKey: PropertyKey.date) as? Date
        
        // Must call designated initializer.
        self.init(name: name, size: size!, date: date!)
        
    }
}
