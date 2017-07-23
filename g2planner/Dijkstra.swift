//
//  Dijkstra.swift
//  g2planner
//
//  Created by Martin Verup on 21/07/2017.
//  Copyright © 2017 Martin Verup. All rights reserved.
//

import Foundation

public class Dijkstra {
    private var nodes: [City]
    private var edges: [Route]
    private var settledNodes: Set<City> = []
    private var unSettledNodes: Set<City> = []
    private var predecessors: [City: Route] = [:]
    private var distance: [City: Int] = [:]
    
    init(_ map: Map) {
        nodes = Array(map.cities)
        edges = Array(map.routes)
    }
    
    public func getRoute(from source: City, to destination: City, searchFor: Parameter, exclude exclusions: Route.Method...) -> [Route] {
        for exclusion in exclusions {
            edges = edges.filter{$0.method != exclusion}
        }
        settledNodes = []
        unSettledNodes = []
        predecessors = [:]
        distance = [:]
        distance[source] = 0
        unSettledNodes.insert(source)
        while unSettledNodes.count > 0 {
            let node = getMinimum(unSettledNodes)
            settledNodes.insert(node)
            unSettledNodes.remove(node)
            findMinimalDistances(node, searchFor)
        }
        return getPath(destination)
    }
    
    private func findMinimalDistances(_ node: City, _ searchFor: Parameter) {
        let adjacentNodes = getNeighbors(node)
        for target in adjacentNodes {
            let d = getDistance(node, target, searchFor)
            let weight: Int
            switch searchFor {
                case .cheapest: weight = d.price
                case .fastest: weight = d.time
            }
            if getShortestDistance(target) > getShortestDistance(node) + weight {
                distance[target] = getShortestDistance(node) + weight
                predecessors[target] = d
                unSettledNodes.insert(target)
            }
        }
    }
    
    private func getDistance(_ node: City, _ target: City, _ searchFor: Parameter) -> Route {
        var route: Route?
        var weight = Int(INT_MAX)
        for edge in edges {
            if edge.source == node && edge.destination == target {
                let value: Int
                switch searchFor {
                    case .cheapest: value = edge.price
                    case .fastest: value = edge.time
                }
                if value < weight {
                    weight = value
                    route = edge
                }
            }
        }
        return route!
    }
    
    private func getNeighbors(_ node: City) -> [City] {
        var neighbors: [City] = [];
        for edge in edges {
            if edge.source == node && !settledNodes.contains(edge.destination) {
                neighbors.append(edge.destination)
            }
        }
        return neighbors
    }
    
    private func getMinimum(_ cities: Set<City>) -> City {
        var minimum: City?
        for city in cities {
            if minimum == nil {
                minimum = city
            } else {
                if getShortestDistance(city) < getShortestDistance(minimum!) {
                    minimum = city
                }
            }
        }
        return minimum!
    }
    
    private func getShortestDistance(_ destination: City) -> Int {
        let d = distance[destination]
        return d == nil ? Int(INT_MAX) : d!
    }
    
    private func getPath(_ target: City) -> [Route] {
        var path: [Route] = []
        var step = target
        while predecessors[step] != nil {
            path.append(predecessors[step]!)
            step = predecessors[step]!.source
        }
        return path.reversed()
    }
    
    public enum Parameter {
        case cheapest, fastest
    }
    
    public class func prettyPrint(_ path: [Route]) {
        if path.count > 0 {
            for route in path {
                let prettyRoute = "(\(route.source.rawValue))".padding(toLength: 16, withPad: " ", startingAt: 0)
                    .appending(" -> ")
                    .appending("(\(route.destination.rawValue))".padding(toLength: 16, withPad: " ", startingAt: 0))
                    .appending("[\(route.method)],".padding(toLength: 9, withPad: " ", startingAt: 0))
                    .appending("£\(route.price),".padding(toLength: 6, withPad: " ", startingAt: 0))
                    .appending("\(route.time)h")
                print(prettyRoute)
            }
            print("Total price: £\(path.map({$0.price}).reduce(0, +))")
            print("Total time:  \(path.map({$0.time}).reduce(0, +))h")
        } else {
            print("No route found")
        }
        print("\n")
    }
    
}
