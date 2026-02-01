//
//  Predators.swift
//  JPApexPredators
//
//  Created by Gina on 30.01.26.
//

import Foundation

class Predators {
    // store all predators once they are decoded
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
                apexPredators = try decoder.decode([ApexPredator].self, from: data)
            } catch {
                // errors are going here
                print("Error decoding JSON Data: \(error)")
            }
        }
    }
}
