//
//  Predators.swift
//  JPApexPredators
//
//  Created by Gina on 30.01.26.
//

import Foundation

class Predators {
    // store all predators once they are decoded
    var allApexPredators: [ApexPredator] = []
    var apexPredators: [ApexPredator] = []
    
    init() {
        // automatically decodes the dinos when we instantialize the class
        decodeApexPredatorData()
    }
    
    // decode function
    func decodeApexPredatorData() {
        if let url = Bundle.main.url(forResource: "jpapexpredators", withExtension: "json") {
            do {
                // try and get the data from the json file
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                allApexPredators = try decoder.decode([ApexPredator].self, from: data)
                apexPredators = allApexPredators
            } catch {
                // errors are going here
                print("Error decoding JSON Data: \(error)")
            }
        }
    }
    
    func search(for searchTerm: String) -> [ApexPredator] {
        // if there is a search term, only show the list of those dinos
        if searchTerm.isEmpty {
            return apexPredators
        } else {
            // use function filter
            return apexPredators.filter { predator in
                predator.name.localizedCaseInsensitiveContains(searchTerm)
            }
        }
    }
    
    func sort(by alphabetical: Bool) {
        // sort the data
        apexPredators.sort { predator1, predator2 in
            // we are comparing the predators to each other
            if alphabetical {
                // sorting in swift is that a is the lowest letter
                predator1.name < predator2.name
            } else {
                predator1.id < predator2.id
            }
        }
    }
    
    func filter(by type: APType) {
        if type == .all {
            // don't filter anything and reset apexPredators
            apexPredators = allApexPredators
        } else {
            apexPredators = allApexPredators.filter { predator in
                predator.type == type
            }
        }
    }
}
