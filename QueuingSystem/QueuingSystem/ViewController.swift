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
    @IBOutlet var resultTextView: NSTextView!
    
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
        
        resultTextView.string =
        "Вероятности состояний\n\(Statistics.getProbabilities())\n" +
        "Вероятность отказа \(Statistics.getRejectionProbability().roundToPlaces(places: 4))\n" +
        "Вероятность блокировки \(Statistics.getLockProbability().roundToPlaces(places: 4))\n" +
        "Относительная пропускная способность \(Statistics.getRelativeBandwidth().roundToPlaces(places: 4))\n" +
        "Абсолютная пропускная способность \(Statistics.getAbsoluteBandwidth().roundToPlaces(places: 4))\n" +
        "Среднее время заявки в очереди \(Statistics.getAverageRequestInQueueTime().roundToPlaces(places: 4))\n" +
        "Среднее время заявки в системе \(Statistics.getAverageRequestInSystemTime().roundToPlaces(places: 4))\n" +
        "Средняя длина системы \(Statistics.getAverageSystemLength().roundToPlaces(places: 4))\n" +
        "Средняя длина очереди \(Statistics.getAverageQueueLength().roundToPlaces(places: 4))\n" +
        "Нагрузка первого канала \(Statistics.getChannelFirsh().roundToPlaces(places: 4))\n" +
        "Нагрузка второго канала \(Statistics.getChannelSecond().roundToPlaces(places: 4))"
        
        Statistics.clearValues()
    }

}

extension Double {
    func roundToPlaces(places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
