//
//  main.swift
//  g2planner
//
//  Created by Martin Verup on 20/07/2017.
//
//

import Foundation

let args = CommandLine.arguments
if args.count < 3 {
    print("Not enough parameters given")
    exit(0)
}

let world = Map.createMap()

let dijkstra = Dijkstra(world)

let source: City
let destination: City

if let from = City(rawValue: args[1]) {
    source = from
} else {
    print("City \"\(args[1])\" not recognized")
    exit(0)
}
if let to = City(rawValue: args[2]) {
    destination = to
} else {
    print("City \"\(args[2])\" not recognized")
    exit(0)
}

let fastestPath = dijkstra.getRoute(from: source, to: destination, searchFor: Dijkstra.Parameter.fastest)
let fastestNoPlanePath = dijkstra.getRoute(from: source, to: destination, searchFor: Dijkstra.Parameter.fastest, exclude: Route.Method.Plane)
let cheapestPath = dijkstra.getRoute(from: source, to: destination, searchFor: Dijkstra.Parameter.cheapest)
let cheapestNoBusPath = dijkstra.getRoute(from: source, to: destination, searchFor: Dijkstra.Parameter.cheapest, exclude: Route.Method.Bus)

print("Routes from \(source.rawValue) to \(destination.rawValue):\n")

print("Fastest:")
Dijkstra.prettyPrint(fastestPath)

print("Cheapest:")
Dijkstra.prettyPrint(cheapestPath)

print("Cheapest (no bus):")
Dijkstra.prettyPrint(cheapestNoBusPath)

print("Fastest (no plane):")
Dijkstra.prettyPrint(fastestNoPlanePath)
