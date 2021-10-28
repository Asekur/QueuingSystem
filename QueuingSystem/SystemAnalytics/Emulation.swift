//
//  Emulation.swift
//  QueuingSystem
//
//  Created by Chegelik on 28.10.2021.
//

import Foundation

class Emulation {
    let lemerSequence: [Double]
    var nodes: [Node]
    
    init(lemerSequence: [Double], nodes: [Node]) {
        self.lemerSequence = lemerSequence
        self.nodes = nodes
    }
    
    func emulate(ticks: Int) -> [[Int]: Int] {
        var totalRequestDone: Int = 0
        var totalRequestInSystemTime: Int = 0
        var totalReject: Int = 0
        var totalBlocked: Int = 0
        var totalRequestInQueueTime: Int = 0
        
        var state: [Int] = [0,0,0,0]
        var states: [[Int]: Int] = [[0,0,0,0]:0,
                                    [0,0,1,0]:0,
                                    [0,1,1,0]:0,
                                    [0,0,1,1]:0,
                                    [0,0,0,1]:0,
                                    [1,1,1,0]:0,
                                    [0,1,1,1]:0,
                                    [1,1,1,1]:0]
        
        for tick in 0..<ticks {
            for indexNode in stride(from: 3, through: 0, by: -1) {
                let node = nodes[indexNode]
                switch indexNode {
                case 3:
                    if node.isFull() && node.isWorked(workedProbability: lemerSequence[tick]) {
                        totalRequestDone += 1
                        if let request = node.request {
                            totalRequestInSystemTime += request.endLifeTime(removeTime: tick)
                        }
                        node.request = nil
                    }
                case 2:
                    if node.isFull() && node.isWorked(workedProbability: lemerSequence[tick]) {
                        if !nodes[3].isFull() {
                            nodes[3].request = node.request
                        } else {
                            totalReject += 1
                        }
                        node.request = nil
                    }
                case 1:
                    if node.isFull() && !nodes[2].isFull() {
                        nodes[2].request = node.request
                        if let request = node.request {
                            totalRequestInQueueTime += request.endQueueTime(exitTime: tick)
                        }
                        if nodes[0].isFull() {
                            node.request = nodes[0].request
                            nodes[0].request = nil
                        } else {
                            node.request = nil
                        }
                    }
                case 0:
                    //if full -> nothing
                    if !node.isFull() {
                        if node.isWorked(workedProbability: lemerSequence[tick]) {
                            node.request = Request(creationTime: tick)
                            if nodes[1].isFull() {
                                totalBlocked += 1
                            } else {
                                if nodes[2].isFull() {
                                    if let request = node.request {
                                        request.setupQueueEnterTime(queueEnter: tick)
                                        nodes[1].request = node.request
                                    }
                                } else {
                                    nodes[2].request = node.request
                                }
                                node.request = nil
                            }
                        }
                    }
                default:
                    fatalError()
                }
            }
            
            for (index, node) in nodes.enumerated() {
                state[index] = node.request != nil ? 1 : 0
            }
            
            for (key, value) in states {
                if state == key {
                    states.updateValue(value + 1, forKey: key)
                }
            }
        }
        return states
    }
}
