//
//  Death.swift
//  BBQuotes
//
//  Created by Gina on 06.03.26.
//
import Foundation

struct Death: Decodable {
    let character: String
    let image: URL // not working for some reason
    let details: String
    let lastWords: String
}
