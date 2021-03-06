//
//  Request.swift
//  QueuingSystem
//
//  Created by Chegelik on 28.10.2021.
//

import Foundation

class Request {
    let creationTime: Int
    var queueEnterTime: Int
    
    init(creationTime: Int, queueEnterTime: Int = 0) {
        self.creationTime = creationTime
        self.queueEnterTime = queueEnterTime
    }
    
    func endLifeTime(removeTime: Int) -> Int {
        removeTime - self.creationTime
    }
    
    func setupQueueEnterTime(queueEnter: Int) {
        self.queueEnterTime = queueEnter
    }
    
    func endQueueTime(exitTime: Int) -> Int {
        exitTime - self.queueEnterTime
    }
}
