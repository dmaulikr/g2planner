//
//  Route.swift
//  g2planner
//
//  Created by Martin Verup on 20/07/2017.
//
//

import Foundation

public class Route: Hashable, CustomStringConvertible {
    public private(set) var source: City
    public private(set) var destination: City
    public private(set) var method: Method
    public private(set) var time: Int
    public private(set) var price: Int
    public var description: String {
        return "(\(source)) -> (\(destination)) [\(method)]"
    }
    
    init(from source: City, to destination: City, time: Int, price: Int, _ method: Method) {
        self.source = source
        self.destination = destination
        self.method = method
        self.price = price
        self.time = time
    }
    
    convenience init(from source: Cities, to destination: Cities, time: Int, price: Int, _ method: Method) {
        self.init(from: City(source), to: City(destination), time: time, price: price, method)
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
