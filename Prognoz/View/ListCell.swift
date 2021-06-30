//
//  ListCell.swift
//  Prognoz
//
//  Created by macbookp on 25.06.2021.
//

import UIKit

class ListCell: UITableViewCell {
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var nameCityLabel: UILabel!
    
    func configure(weather: Weather) {
        nameCityLabel.text = weather.name
        tempLabel.text = "\(weather.temperature)˚C"
        statusLabel.text = weather.conditionString
    }
    
}
