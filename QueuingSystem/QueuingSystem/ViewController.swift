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
            Node(rejectProbability: pTextField.doubleValue),
            Node(rejectProbability: nil),
            Node(rejectProbability: pi1TextField.doubleValue),
            Node(rejectProbability: pi2TextField.doubleValue)
        ]
        let emulation = Emulation(lemerSequence: lemerNumbers.getXValues(), nodes: nodes)
        emulation.emulate(ticks: Constants.n)
        print("Вероятности состояний \(Statistics.getProbabilities())")
        print("Вероятность отказа \(Statistics.getRejectionProbability())")
        print("Вероятность блокировки \(Statistics.getLockProbability())")
        print("Относительная пропускная способность \(Statistics.getRelativeBandwidth())")
        print("Абсолютная пропускная способность \(Statistics.getAbsoluteBandwidth())")
        print("Среднее время заявки в очереди \(Statistics.getAverageRequestInQueueTime())")
        print("Среднее время заявки в системе \(Statistics.getAverageRequestInSystemTime())") //?
        print("Средняя длина системы \(Statistics.getAverageSystemLength())")
        print("Средняя длина очереди \(Statistics.getAverageQueueLength())")
        print("Нагрузка первого канала \(Statistics.getChannelFirsh())")
        print("Нагрузка второго канала \(Statistics.getChannelSecond())")
    }

}

