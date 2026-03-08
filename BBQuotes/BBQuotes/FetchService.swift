//
//  FetchService.swift
//  BBQuotes
//
//  Created by Gina on 06.03.26.
//

import Foundation

struct FetchService {
    // security: nobody outside this fetch service needs the enum or the baseURL
    private enum FetchError: Error {
        case badResponse // the server doesn't give us the right data
    }
    
    private let baseURL = URL(string: "https://breaking-bad-api-six.vercel.app/api")!
    
    //https://breaking-bad-api-six.vercel.app/api/quotes/random?production=Breaking+Bad
    // ? is a query
    func fetchQuote(from show: String) async throws -> Quote {
        // build the fetch url
        let quoteURL = baseURL.appending(path: "quotes/random")
        let fetchURL = quoteURL.appending(queryItems: [URLQueryItem(name: "production", value: show)])
        
        // try and fetch the data from the url
        let (data, response) = try await URLSession.shared.data(from: fetchURL)
        
        // deal with the response from the server
        // we are asking if the response is the response from an online server, which is HTTPURLResponse
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw FetchError.badResponse
        }
        
        // if the response is good, decode the data and put it in quote model
        let quote = try JSONDecoder().decode(Quote.self, from: data)
        
        // return the quote
        return quote
    }
    
    func fetchCharacter(_ name: String) async throws -> Char {
        let charURL = baseURL.appending(path: "characters")
        let fetchURL = charURL.appending(queryItems: [URLQueryItem(name: "name", value: name)])
        
        let (data, response) = try await URLSession.shared.data(from: fetchURL)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw FetchError.badResponse
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let characters = try decoder.decode([Char].self, from: data)
        
        return characters[0]
    }
    
    func fetchDeath(for character: String) async throws -> Death? {
        let fetchURL = baseURL.appending(path: "deaths")
        
        let (data, response) = try await URLSession.shared.data(from: fetchURL)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw FetchError.badResponse
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let deaths = try decoder.decode([Death].self, from: data)
        
        for death in deaths {
            if death.character == character {
                return death
            }
        }
        
        return nil
        
    }
}
