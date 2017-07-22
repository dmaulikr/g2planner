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
let destination = City.MT_EVEREST

var fastestPath = dijkstra.getRoute(from: source, to: destination, searchFor: Dijkstra.Parameter.fastest)
var fastestNoPlanePath = dijkstra.getRoute(from: source, to: destination, searchFor: Dijkstra.Parameter.fastest, exclude: Route.Method.Plane)
var cheapestPath = dijkstra.getRoute(from: source, to: destination, searchFor: Dijkstra.Parameter.cheapest)
var cheapestNoBusPath = dijkstra.getRoute(from: source, to: destination, searchFor: Dijkstra.Parameter.cheapest, exclude: Route.Method.Bus)

print("Routes from \(source.rawValue) to \(destination.rawValue):\n")

print("Fastest:")
Dijkstra.prettyPrint(fastestPath)

print("Cheapest:")
Dijkstra.prettyPrint(cheapestPath)

print("Cheapest (no bus):")
Dijkstra.prettyPrint(cheapestNoBusPath)

print("Fastest (no plane):")
Dijkstra.prettyPrint(fastestNoPlanePath)
