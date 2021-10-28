//
//  IStatistics.swift
//  QueuingSystem
//
//  Created by Chegelik on 28.10.2021.
//

import Foundation

protocol IStatistics {
    func getProbabilities() -> [String:Double]
    func getRejectionProbability() -> Double
    func getLockProbability() -> Double
    func getAverageQueueLength() -> Double
    func getAverageRequestCount() -> Double
    func getRelativeBandwidth() -> Double
    func getAbsoluteBandwidth() -> Double
    func getAverageRequestInQueueTime() -> Double
    func getAverageRequestInSystemTime() -> Double
    func getChannelRatios() -> [String:Double]
}
