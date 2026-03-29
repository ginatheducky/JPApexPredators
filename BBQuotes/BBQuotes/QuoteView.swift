//
//  QuoteView.swift
//  BBQuotes
//
//  Created by Gina on 24.02.26.
//

import SwiftUI
import Foundation

struct QuoteView: View {
    let vm = ViewModel()
    let show: String
    
    @State var showCharacterInfo = false
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Image(show.lowercased().replacingOccurrences(of: " ", with: ""))
                    .resizable()
                    .frame(width: geo.size.width * 2.7, height: geo.size.height * 1.2)
                
                VStack {
                    VStack {
                        Spacer(minLength: 60)
                        
                        switch vm.status {
                        case .notStarted:
                            EmptyView()
                        case .fetching:
                            ProgressView()
                        case .success:
                            Text("\"\(vm.quote.quote)\"")
                                .minimumScaleFactor(0.5) // scales the text down to up to 50%, but not smaller
                                .multilineTextAlignment(.center)
                                .foregroundStyle(.white)
                                .padding()
                                .background(.black.opacity(0.5))
                                .clipShape(.rect(cornerRadius: 25))
                                .padding(.horizontal)
                            
                            ZStack(alignment: .bottom) {
                                AsyncImage(url: vm.character.images[0]) { image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: geo.size.width/1.1, height: geo.size.height/1.8)
                                
                                Text(vm.quote.character)
                                    .foregroundStyle(.white)
                                    .padding(10)
                                    .frame(maxWidth: .infinity)
                                    .background(.ultraThinMaterial)
                            }
                            .frame(width: geo.size.width/1.1, height: geo.size.height/1.8)
                            .clipShape(.rect(cornerRadius: 50))
                            .onTapGesture {
                                showCharacterInfo.toggle()
                            }
                        case .failed(let error):
                            Text(error.localizedDescription)
                        }
                        
                        
                        Spacer()
                    }
                    
                    Button {
                        // btn action
                        Task { // Task is a unit of async task that we can run in a sync environement like the UI view
                            await vm.getData(for: show)
                        }
                    } label: {
                        Text("Get Random Quote")
                            .font(.title)
                            .foregroundStyle(.white)
                            .padding()
                            .background(Color("\(show.replacingOccurrences(of: " ", with: ""))Btn"))
                            .clipShape(.rect(cornerRadius: 7))
                            .shadow(color: Color("\(show.replacingOccurrences(of: " ", with: ""))Shadow"), radius: 3)
                    }
                    
                    Spacer(minLength: 95)
                }
                .frame(width: geo.size.width, height: geo.size.height)
            }
            .frame(width: geo.size.width, height: geo.size.height)
        }
        .ignoresSafeArea(.all)
        // sheet modifiers
        .sheet(isPresented: $showCharacterInfo) {
            CharacterView(character: vm.character, show: show)
        }
    }
}

#Preview {
    QuoteView(show: "Breaking Bad")
        .preferredColorScheme(.dark)
}
