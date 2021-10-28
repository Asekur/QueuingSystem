//
//  Node.swift
//  QueuingSystem
//
//  Created by Chegelik on 28.10.2021.
//

import Foundation

class Node {
    var rejectProbability: Double? = nil
    var processingProbability: Double? = nil
    var request: Request? = nil
    
    init(rejectProbability: Double?) {
        self.rejectProbability = rejectProbability
        if let reject = rejectProbability {
            self.processingProbability = 1.0 - reject
        }
    }
    
    func isFull() -> Bool {
        request != nil
    }
    
    func isWorked(workedProbability: Double) -> Bool {
        //return workedProbability < processingProbability!
        return Double.random(in: 0...1) < processingProbability!
    }
}
