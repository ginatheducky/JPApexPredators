//
//  PredatorDetail.swift
//  JPApexPredators
//
//  Created by Gina on 19.02.26.
//

import SwiftUI

struct PredatorDetail: View {
    let predator: ApexPredator
    
    var body: some View {
        GeometryReader { geo in
            
            ScrollView {
                // background Image and dinosaur image
                ZStack(alignment: .bottomTrailing) {
                    // background image
                    Image(predator.type.rawValue)
                        .resizable()
                        .scaledToFit()
                    
                    // dino image
                    Image(predator.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width / 1.5, height: geo.size.height / 3.7)
                        .scaleEffect(x: -1) // doesn't change the placing
                        .shadow(color: .black, radius: 7)
                        .offset(y: 20)
                }
                
                // name
                
                // current location
                
                // appears in
                
                // movie scenes
                
                // link
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    PredatorDetail(predator: Predators().apexPredators[2])
        //.preferredColorScheme(.dark)
}
