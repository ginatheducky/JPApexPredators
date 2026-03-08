//
//  ViewModel.swift
//  BBQuotes
//
//  Created by Gina on 08.03.26.
//

import Foundation

@Observable
@MainActor
class ViewModel {
    enum FetchStatus {
        case notStarted
        case fetching
        case success
        case failed(error: Error)
    }
    
    // private(set) is only partially private, we can only change the property in this class
    private(set) var status: FetchStatus = .notStarted
    private let fetcher = FetchService()
    
    var quote: Quote
    var character: Char
    
    init() {
        
    }
}
