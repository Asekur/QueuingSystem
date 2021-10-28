//
//  LemerNumbers.swift
//  QueuingSystem
//
//  Created by Chegelik on 28.10.2021.
//

import Foundation

protocol LemerSequence {
    func getXValues() -> [Double]
}

class LemerNumbers: LemerSequence {
    
    // MARK: - Properties
    private let lemerGenerator: LemerGenerator
    private let intervals = 20
    private var sequenceCount: Int
    private var values = [Double]()
    private var xValues = [Double]()
    
    // MARK: - Init
    init(m: Double, a: Double, r0: Double, n: Int) {
        self.lemerGenerator = LemerGenerator(m: m, a: a, r0: r0)
        self.sequenceCount = n
        self.values = self.lemerGenerator.fullSequence(for: n)
        self.xValues = self.values.map { $0 / self.lemerGenerator.m }
    }
    
    // MARK: - Methods
    
    func getXValues() -> [Double] {
        return self.xValues
    }
}
