//
//  CityTableViewCell.swift
//  Test_Task_1
//
//  Created by Юрий Шелест on 16.12.22.
//

import UIKit
import SwiftSVG

class CityTableViewCell: UITableViewCell {

    var weather: Weather?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var statusLabel: UILabel!
    @IBOutlet private weak var valueLabel: UILabel!
    @IBOutlet private weak var statusView: UIView!
    
    func setup(weather: Weather) {
        let url = URL(string: "https://yastatic.net/weather/i/icons/funky/dark/\(weather.conditionCode).svg")
        let weatherImage = UIView(SVGURL: url!) { image in
            image.resizeToFit(self.statusView.bounds)
        }
        self.statusView?.addSubview(weatherImage)
        
        self.nameLabel.text = weather.name
        self.statusLabel.text = weather.conditionalStrig
        self.valueLabel.text = weather.temperatureString
    }
}
