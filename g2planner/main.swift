//
//  main.swift
//  g2planner
//
//  Created by Martin Verup on 20/07/2017.
//
//

import Foundation

let world = Map.createMap()

let dijkstra = Dijkstra(world)

let source = City.BOSTON
let destination = City.SHANGHAI

var fastestPath = dijkstra.getRoute(from: source, to: destination, searchFor: Dijkstra.Parameter.fastest)
var cheapestPath = dijkstra.getRoute(from: source, to: destination, searchFor: Dijkstra.Parameter.cheapest)
var cheapestNoBusPath = dijkstra.getRoute(from: source, to: destination, searchFor: Dijkstra.Parameter.cheapest, exclude: Route.Method.Bus)


// Fastest
if fastestPath.count > 0 {
    print("Fastest route from \(source.rawValue) to \(destination.rawValue):\n")
    
    for route in fastestPath {
        print("\(route), £\(route.price), \(route.time)h")
    }

    print("Total price: £\(fastestPath.map({$0.price}).reduce(0, +))")
    print("Total time: \(fastestPath.map({$0.time}).reduce(0, +))h")
} else {
    print("No route found from \(source.rawValue) to \(destination.rawValue)")
}
print(); print()

// Cheapest

if cheapestPath.count > 0 {
    print("Cheapest route from \(source.rawValue) to \(destination.rawValue):\n")
    
    for route in cheapestPath {
        print("\(route), £\(route.price), \(route.time)h")
    }
    
    print("Total price: £\(cheapestPath.map({$0.price}).reduce(0, +))")
    print("Total time: \(cheapestPath.map({$0.time}).reduce(0, +))h")
} else {
    print("No route found from \(source.rawValue) to \(destination.rawValue)")
}
print(); print()

// Cheapest (no bus)

if cheapestNoBusPath.count > 0 {
    print("Cheapest (no bus) route from \(source.rawValue) to \(destination.rawValue):\n")
    
    for route in cheapestPath {
        print("\(route), £\(route.price), \(route.time)h")
    }
    
    print("Total price: £\(cheapestNoBusPath.map({$0.price}).reduce(0, +))")
    print("Total time: \(cheapestNoBusPath.map({$0.time}).reduce(0, +))h")
} else {
    print("No route without bus found from \(source.rawValue) to \(destination.rawValue)")
}
print()
