//
//  DetailVC.swift
//  Prognoz
//
//  Created by macbookp on 26.06.2021.
//

import UIKit
import SwiftSVG

class DetailVC: UIViewController {
    
    var weatherModel: Weather?
    
    @IBOutlet weak var nameCityLabel: UILabel!
    @IBOutlet weak var viewCity: UIView!
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var tempCityLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshLabels()
        refreshImage()
    }
    
    func refreshLabels() {
        nameCityLabel.text = weatherModel?.name
        conditionLabel.text = weatherModel?.conditionString
        tempCityLabel.text = "\((weatherModel?.temperature) ?? 0)˚C"
        pressureLabel.text = "\((weatherModel?.pressure) ?? 0) мм.рт.ст."
        windSpeedLabel.text = "\((weatherModel?.windSpeed) ?? 0) м/c"
        minTempLabel.text = "\((weatherModel?.tempMin) ?? 0)˚C"
        maxTempLabel.text = "\((weatherModel?.tempMax) ?? 0)˚C"
        
    }
    
    func refreshImage() {
        guard let url = URL(string: "https://yastatic.net/weather/i/icons/blueye/color/svg/\(weatherModel!.conditionCode).svg")
        else { return }
        let weatherImage = UIView(SVGURL: url) { image in
            image.resizeToFit(CGRect(x: 0, y: 0, width: 170, height: 170))
        }
        viewCity.addSubview(weatherImage)
        viewCity.layer.masksToBounds = true
    }
}
