//
//  ApexPredator.swift
//  JPApexPredators
//
//  Created by Gina on 30.01.26.
//

// scope of this file is one single apex predator

import SwiftUI

struct ApexPredator: Decodable, Identifiable {
    // we need to define our properties
    let id: Int
    let name: String
    let type: APType
    let latitude: Double
    let longitude: Double
    let movies: [String]
    let movieScenes: [MovieScene]
    let link: String
    
    var image: String {
        name.lowercased().replacingOccurrences(of: " ", with: "")
    }
    
    // another model for the movie_scenes array
    struct MovieScene: Decodable {
        let id: Int
        let movie: String
        let sceneDescription: String
    }
    
    enum APType: String, Decodable {
        case land
        case air
        case sea
        
        var background: Color {
            switch self {
            case .land:
                .brown
            case .air:
                .teal
            case .sea:
                .blue
            }
        }
    }
}
