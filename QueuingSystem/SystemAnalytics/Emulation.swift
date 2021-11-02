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
    
    func emulate(ticks: Int) {
        var shoulRequestCome: Bool = true
        
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
            shoulRequestCome = nodes[0].isFull() ? false : true
            for indexNode in stride(from: 3, through: 0, by: -1) {
                let node = nodes[indexNode]
                switch indexNode {
                case 3:
                    if node.isFull() && node.isWorked(workedProbability: lemerSequence[Int.random(in: 0..<Constants.n)]) {
                        //print("\(tick): пи 2 отработал")
                        Statistics.totalRequestDone += 1
                        Statistics.totalRequestInSystemTime += node.request!.endLifeTime(removeTime: tick)
                        node.request = nil
                    }
                case 2:
                    if node.isFull() && node.isWorked(workedProbability: lemerSequence[Int.random(in: 0..<Constants.n)]) {
                        if !nodes[3].isFull() {
                            nodes[3].request = node.request
                        } else {
                            Statistics.totalReject += 1
                        }
                        node.request = nil
                        if nodes[1].isFull() {
                            node.request = nodes[1].request
                            nodes[1].request = nil
                            Statistics.totalRequestInQueueTime += node.request!.endQueueTime(exitTime: tick)
                            Statistics.totalRequestQueueDone += 1
                            if nodes[0].isFull() {
                                nodes[1].request = nodes[0].request
                                nodes[1].request!.setupQueueEnterTime(queueEnter: tick)
                                nodes[0].request = nil
                            }
                        }
                    }
                case 1:
                    if node.isFull() && !nodes[2].isFull() {
                        nodes[2].request = node.request
                        Statistics.totalRequestQueueDone += 1
                        Statistics.totalRequestInQueueTime += node.request!.endQueueTime(exitTime: tick)
                        if nodes[0].isFull() {
                            nodes[0].request!.setupQueueEnterTime(queueEnter: tick)
                            node.request = nodes[0].request
                            nodes[0].request = nil
                        } else {
                            node.request = nil
                        }
                    }
                case 0:
                    if (node.isFull()) {
                        Statistics.totalBlocked += 1
                    }
                    if shoulRequestCome {
                        if node.isWorked(workedProbability: lemerSequence[Int.random(in: 0..<Constants.n)]) {
                            Statistics.totalRequestGenerated += 1
                            node.request = Request(creationTime: tick)
                            if nodes[1].isFull() {
                                Statistics.totalBlocked += 1
                            } else {
                                if nodes[2].isFull() {
                                    node.request!.setupQueueEnterTime(queueEnter: tick)
                                    nodes[1].request = node.request
                                    
                                } else {
                                    nodes[2].request = node.request
                                    Statistics.totalRequestQueueDone += 1
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
                if node.request != nil {
                    Statistics.totalRequestSystem += 1
                    if index == 1 {
                        Statistics.totalRequestQueue += 1
                    }
                    if index == 2 {
                        Statistics.totalRequestFirstChannel += 1
                    }
                    if index == 3 {
                        Statistics.totalRequestSecondChannel += 1
                    }
                }
                
            }
            
            for (key, value) in states {
                if state == key {
                    states.updateValue(value + 1, forKey: key)
                }
            }
        }
        Statistics.states = states
    }
}
