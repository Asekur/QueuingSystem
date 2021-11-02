//
//  Statistics.swift
//  QueuingSystem
//
//  Created by Chegelik on 28.10.2021.
//

import Foundation

class Statistics {//: IStatistics {

    static var totalRequestDone: Int = 0
    static var totalRequestGenerated: Int = 0
    static var totalRequestInSystemTime: Int = 0
    static var totalReject: Int = 0
    static var totalBlocked: Int = 0
    static var totalRequestSystem: Int = 0
    static var totalRequestQueue: Int = 0
    static var totalRequestQueueDone: Int = 0
    static var totalRequestInQueueTime: Int = 0
    static var totalRequestFirstChannel: Int = 0
    static var totalRequestSecondChannel: Int = 0
    static var states = [[Int]: Int]()
    
    static func clearValues() {
        totalRequestDone = 0
        totalRequestGenerated = 0
        totalRequestInSystemTime = 0
        totalReject = 0
        totalBlocked = 0
        totalRequestSystem = 0
        totalRequestQueue = 0
        totalRequestQueueDone = 0
        totalRequestInQueueTime = 0
        totalRequestFirstChannel = 0
        totalRequestSecondChannel = 0
        states = [[Int]: Int]()
    }
    
    static func getProbabilities() -> String {
        var resultStringProbabilities = ""
        for (key, value) in states {
            resultStringProbabilities.append("P")
            for item in key {
                resultStringProbabilities.append("\(item)")
            }
            resultStringProbabilities.append(": \((Double(value) / Double(Constants.n)).roundToPlaces(places: 4))\n")
        }
        return resultStringProbabilities
    }
    
    //P_отк
    static func getRejectionProbability() -> Double {
        return Double(Statistics.totalReject) / Double(Statistics.totalRequestGenerated)
    }

    //P_блок
    static func getLockProbability() -> Double {
        return Double(Statistics.totalBlocked) / Double(Constants.n)
    }
    
    //L_оч
    static func getAverageQueueLength() -> Double {
        return Double(Statistics.totalRequestQueue) / Double(Constants.n)
    }

    //L_с
    static func getAverageSystemLength() -> Double {
        return Double(Statistics.totalRequestSystem) / Double(Constants.n)
    }

    //Q
    static func getRelativeBandwidth() -> Double {
        return Double(Statistics.totalRequestDone) / Double(Statistics.totalRequestGenerated)
    }

    //A
    static func getAbsoluteBandwidth() -> Double {
        return Double(Statistics.totalRequestDone) / Double(Constants.n)
    }
    
    //W_оч
    static func getAverageRequestInQueueTime() -> Double {
        return Double(Statistics.totalRequestInQueueTime) / Double(Statistics.totalRequestQueueDone)
    }

    //W_с
    static func getAverageRequestInSystemTime() -> Double {
        return Double(Statistics.totalRequestInSystemTime) / Double(Statistics.totalRequestDone)
    }

    //K_1
    static func getChannelFirsh() -> Double {
        return Double(Statistics.totalRequestFirstChannel) / Double(Constants.n)
    }
    
    //K_2
    static func getChannelSecond() -> Double {
        return Double(Statistics.totalRequestSecondChannel) / Double(Constants.n)
    }
}
