//
//  ListTVC.swift
//  Prognoz
//
//  Created by macbookp on 20.06.2021.
//
import CoreLocation
import UIKit

class ListTVC: UITableViewController {
    
    private var nameCitiesArray = ["Москва", "Петербург", "Новосибирск"]
    private var filterWeatherCityArray = [Weather]()
    private var weatherCityArray = [Weather]()
    private let searchController = UISearchController(searchResultsController: nil)
    
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    
    private var isFiltering: Bool {
        searchController.isActive && !searchBarIsEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addCities()
        createSearchController()
    }
    
    private func addCities() {
        WeatherManager.shared.getCitiesWeather(cityesArray: nameCitiesArray) { [self] weathers in
            self.weatherCityArray = weathers.sorted { $0.name < $1.name }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    private func createSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Поиск"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail" {
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let cityWeather: Weather?
            if isFiltering {
                cityWeather = filterWeatherCityArray[indexPath.row]
            } else {
                cityWeather = weatherCityArray[indexPath.row]
            }
            let destinationVC = segue.destination as! DetailVC
            destinationVC.weatherModel = cityWeather!
        }
    }
    
    //MARK: - IBActions
    @IBAction func plusButtinPressed(_ sender: UIBarButtonItem) {
        alertPlusCity(name: "Город", placeholder: "Введите название города") { cityName in
            if cityName != "" {
                if self.nameCitiesArray.contains(where: { city in
                    city.lowercased() == cityName.lowercased()
                }) {
                    self.alertWrongCity(title: "Этот город уже есть в списке")
                } else {
                    self.nameCitiesArray.append(cityName)
                    self.addCities()
                }
            } else {
                self.alertWrongCity(title: "Введите название города")
            }
        }
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filterWeatherCityArray.count
        }
        return weatherCityArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ListCell
        if isFiltering {
            cell.configure(weather: filterWeatherCityArray[indexPath.row])
        } else {
            cell.configure(weather: weatherCityArray[indexPath.row])
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Удалить") { [self] _, _, completionHandler in
            let index = indexPath.row
            if self.isFiltering {
                self.filterWeatherCityArray.remove(at: index)
            } else {
                self.weatherCityArray.remove(at: index)
                self.nameCitiesArray.sort { $0 < $1 }
                self.nameCitiesArray.remove(at: index)
            }
            tableView.reloadData()
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
}

//MARK: - ProtocolUISearchResultsUpdating
extension ListTVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        filterWeatherCityArray = weatherCityArray.filter {
            $0.name.contains(searchText)
        }
        tableView.reloadData()
    }
}
