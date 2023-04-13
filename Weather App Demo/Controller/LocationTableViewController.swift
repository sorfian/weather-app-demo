//
//  LocationTableViewController.swift
//  Weather App Demo
//
//  Created by Sorfian on 13/04/23.
//

import UIKit
import WidgetKit

class LocationTableViewController: UITableViewController {
    
    let locations = ["Paris, France", "Kyoto, Japan", "Sydney, Australia", "Seattle, U.S.", "New York, U.S.", "Hong Kong, Hong Kong", "Taipei, Taiwan", "London, U.K.", "Vancouver, Canada"]
    
    private (set) var selectedCity = ""
    private (set) var selectedCountry = ""
    
    var selectedLocation = "" {
        didSet {
            let locations = selectedLocation.split(separator: ",").map { string in
                String(string)
            }
            selectedCity = locations[0]
            selectedCountry = locations[1].trimmingCharacters(in: .whitespacesAndNewlines)
            
        }
    }
    
    var defaults = UserDefaults(suiteName: "group.id.signal.Weather-App-Demo")

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return locations.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
//        Configure the cell
        var content = cell.defaultContentConfiguration()
        content.text = locations[indexPath.row]
        cell.accessoryType = (locations[indexPath.row] == selectedLocation) ? .checkmark : .none
        cell.contentConfiguration = content
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        var content = cell?.defaultContentConfiguration()
        cell?.accessoryType = .checkmark
        content?.text = locations[indexPath.row]
        
        if let location = content?.text {
            selectedLocation = location
            
            defaults?.setValue(selectedCity, forKey: "city")
        }
        
        WidgetCenter.shared.reloadAllTimelines()
        tableView.reloadData()
        
    }

}
