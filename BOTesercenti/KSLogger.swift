//
//  KSLogger.swift
//  BuBOTesercentiBOTesercentiies
//
//  Created by Mirko Pennone on 20/05/18.
//  Copyright © 2018 spark-ios-sdk. All rights reserved.
//

import Foundation
import SparkSDK

///Developer should implementation the SDK Logger protocol for troubleshooting.
public class KSLogger : Logger {
    public func log(message: LogMessage) {
        //log level control
        switch message.level {
        case .debug,.warning,.error,.no:
            print(message)
        default:
            break;
        }
        
    }
}
