//
//  ViewController.swift
//  QueuingSystem
//
//  Created by Chegelik on 28.10.2021.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var pTextField: NSTextField!
    @IBOutlet weak var pi1TextField: NSTextField!
    @IBOutlet weak var pi2TextField: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func generateClicked(_ sender: Any) {
        let lemerNumbers = LemerNumbers.init(m: 1046527.0, a: 65537.0, r0: 32771.0, n: Constants.n)
        let nodes = [
            Node(rejectProbability: 0.7),
            Node(rejectProbability: nil),
            Node(rejectProbability: 0.7),
            Node(rejectProbability: 0.8)
        ]
        let emulation = Emulation(lemerSequence: lemerNumbers.getXValues(), nodes: nodes)
        emulation.emulate(ticks: Constants.n)
        //print(Statistics.getProbabilities())
        //print(Statistics.getRejectionProbability())
        //print(Statistics.getLockProbability()) //?
        //print(Statistics.getRelativeBandwidth())
        //print(Statistics.getAbsoluteBandwidth())
        //print(Statistics.getAverageRequestInQueueTime())
        //print(Statistics.getAverageRequestInSystemTime()) //?
        //print(Statistics.getAverageSystemLength())
        //print(Statistics.getAverageQueueLength())
        //print(Statistics.getChannelFirsh())
        //print(Statistics.getChannelSecond())
    }
    
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

