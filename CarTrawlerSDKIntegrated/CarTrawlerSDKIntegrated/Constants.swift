//
//  Constants.swift
//  TestAppObjC
//
//  Created by Rafael Ortiz on 24/06/2019.
//  Copyright © 2019 CarTrawler. All rights reserved.
//

import Foundation

enum EnvironmentType {
    case live
    case debug
}

struct CarTrawler {
    public static let environment = isProduction()
    
    static func isProduction() -> Bool {
        if Environment.getCurrent() == .live {
            return true
        }
        
        return false
    }
}

struct Environment {
    static func getCurrent() -> EnvironmentType {
        return .live
    }
}


