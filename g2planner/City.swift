//
//  City.swift
//  g2planner
//
//  Created by Martin Verup on 20/07/2017.
//
//

import Foundation


public class City: Hashable, CustomStringConvertible {
    public private(set) var name: Cities
    public var description: String {
        return name.rawValue
    }
    
    init(_ name: Cities) {
        self.name = name
    }
    
    public var hashValue: Int {
        return name.hashValue
    }
    
    public static func == (lhs: City, rhs: City) -> Bool {
        return lhs.name == rhs.name
    }

}
