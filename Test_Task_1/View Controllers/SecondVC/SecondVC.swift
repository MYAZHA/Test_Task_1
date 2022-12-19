//
//  SecondVC.swift
//  Test_Task_1
//
//  Created by Юрий Шелест on 14.12.22.
//

import UIKit

class SecondVC: UIViewController {
    
    private var weather: Weather?
    
    init(weather: Weather) {
        self.weather = weather
        super.init(nibName: "\(SecondVC.self)", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("\(Self.self) was called by coder")
    }
    
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var temperatureLabel: UILabel!
    @IBOutlet private weak var statusLabel: UILabel!
    @IBOutlet private weak var tMinLabel: UILabel!
    @IBOutlet private weak var tMaxLabel: UILabel!
    @IBOutlet private weak var pressureLabel: UILabel!
    @IBOutlet private weak var windSpeedLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    private func setup() {
        nameLabel.text = weather?.name
        temperatureLabel.text = weather?.temperatureString
        statusLabel.text = weather?.conditionalStrig
        tMinLabel.text = "\(weather?.tempMin ?? 0)"
        tMaxLabel.text = "\(weather?.tempMax ?? 0)"
        pressureLabel.text = "\(weather?.presureMm ?? 0)"
        windSpeedLabel.text = "\(weather?.windSpeed ?? 0)"
       
        view.backgroundColor = .projectBackgroundColor
        let navigationBar = self.navigationController?.navigationBar
        navigationBar?.tintColor = .white
    }
}
