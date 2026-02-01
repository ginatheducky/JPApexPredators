//
//  ContentView.swift
//  JPApexPredators
//
//  Created by Gina on 30.01.26.
//

import SwiftUI

struct ContentView: View {
    let predators = Predators()
    
    @State var searchText = ""
    
    var filteredDinos: [ApexPredator] {
        // if there is a search term, only show the list of those dinos
        if searchText.isEmpty {
            return predators.apexPredators
        } else {
            // use function filter
            return predators.apexPredators.filter {
                predator in predator.name.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            // use your new dinos list to display the navigation stack
            List(filteredDinos) { predator in
                NavigationLink {
                    Image(predator.image)
                        .resizable()
                        .scaledToFit()
                } label: {
                    HStack {
                        // Dinosaur Image
                        Image(predator.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .shadow(color: .white, radius: 1)
                        
                        VStack(alignment: .leading) {
                            // name
                            Text(predator.name)
                                .fontWeight(.bold)
                            
                            // type
                            Text(predator.type.rawValue.capitalized)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .padding(.horizontal, 13)
                                .padding(.vertical, 5)
                                .background(predator.type.background)
                                .clipShape(.capsule)
                        }
                    }
                }
            }
            .navigationTitle("Apex Predators")
            .searchable(text: $searchText)
            .autocorrectionDisabled(true)
            .animation(.default, value: searchText) // whenever search text changes this animation will animate the stuff
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
