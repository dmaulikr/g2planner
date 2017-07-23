//
//  Route.swift
//  g2planner
//
//  Created by Martin Verup on 20/07/2017.
//
//

public class Route: Hashable, CustomStringConvertible {
    public private(set) var source: City
    public private(set) var destination: City
    public private(set) var method: Method
    public private(set) var time: Int
    public private(set) var price: Int
    public var description: String {
        return "(\(source.rawValue))".padding(toLength: 17, withPad: " ", startingAt: 0)
            .appending(" -> ")
            .appending("(\(destination.rawValue))".padding(toLength: 17, withPad: " ", startingAt: 0))
            .appending("[\(method)]".padding(toLength: 7, withPad: " ", startingAt: 0))
    }
    
    init(from source: City, to destination: City, time: Int, price: Int, _ method: Method) {
        self.source = source
        self.destination = destination
        self.method = method
        self.price = price
        self.time = time
    }
    
    public enum Method {
        case Ferry
        case Bus
        case Plane
        case Train
    }
    
    public var hashValue: Int {
        return description.hashValue
    }
    
    public static func == (lhs: Route, rhs: Route) -> Bool {
        return lhs.source == rhs.source &&
                lhs.destination == rhs.destination &&
                lhs.method == rhs.method
    }
    
}
