//
//  FirstVC.swift
//  Test_Task_1
//
//  Created by Юрий Шелест on 14.12.22.
//

import UIKit


class FirstVC: UIViewController {
    
    init() {
        super.init(nibName: "\(FirstVC.self)", bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("\(Self.self) was called by coder")
    }
    
    @IBOutlet private weak var tableView: UITableView! {
            didSet {
                tableView.dataSource = self
                tableView.delegate = self
                tableView.backgroundColor = .clear
            }
    }

    let searchContoller = UISearchController(searchResultsController: nil)
    
    var searchBarIsEmpty: Bool {
        guard let text = self.searchContoller.searchBar.text else { return false }
        return text.isEmpty
    }
    
    var isFitred: Bool {
        return searchContoller.isActive && !searchBarIsEmpty
    }
    
    let emptyCity = Weather()
    
    let arrayCities = ["Минск", "Вильнюс", "Гданьск", "Мюнхен", "Орша", "Краков", "Витебск", "Киев", "Дрезден", "Пинск"]
    var cities = [Weather]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    var filtredCities = [Weather]()
    
    let networkService = NetworkService()
    let getCityWeatherService = GetCityWeatherService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .projectBackgroundColor
        
        let nibCity = UINib(nibName: "\(CityTableViewCell.self)", bundle: nil)
        tableView.register(nibCity, forCellReuseIdentifier: "\(CityTableViewCell.self)")
        
        if cities.isEmpty {
            cities = Array(repeating: emptyCity, count: arrayCities.count)
        }
        
        setupCities()
        searchContoller.searchResultsUpdater = self
        searchContoller.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchContoller
        definesPresentationContext = true
        navigationItem.hidesSearchBarWhenScrolling = false
        searchContoller.searchBar.tintColor = .white
    }
    
    func setupCities() {
        getCityWeatherService.getCityWeather(citiesArray: arrayCities) { index, weather in
            self.cities[index] = weather
            self.cities[index].name = self.arrayCities[index]
        }
    }
}


//MARK: -   UITableViewDelegate
extension FirstVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFitred {
            return filtredCities.count
        }
        return cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(CityTableViewCell.self)", for: indexPath) as? CityTableViewCell
        var weather = Weather()
        if isFitred {
            weather = filtredCities[indexPath.row]
        } else {
            weather = cities[indexPath.row]
        }
        cell?.setup(weather: weather)
        return cell ?? .init()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        var weather = Weather()
        if isFitred {
            weather = filtredCities[indexPath.row]
        } else {
            weather = cities[indexPath.row]
        }
        
        let nextVC = SecondVC(weather: weather)
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75.0
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { _, _, comletion in
            let editingRow = self.arrayCities[indexPath.row]
            if let index = self.arrayCities.firstIndex(of: editingRow) {
                if self.isFitred {
                    self.filtredCities.remove(at: index)
                } else {
                    self.cities.remove(at: index)
                }
            }
            tableView.reloadData()
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

//MARK: - UISearchResultsUpdating

extension FirstVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filter(searchController.searchBar.text!)
    }
    
    private func filter(_ text: String) {
        filtredCities = cities.filter {
            $0.name.contains(text)
        }
        tableView.reloadData()
    }
    
}
