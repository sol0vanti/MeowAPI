//
//  ContentView.swift
//  MeowAPI
//
//  Created by Alex Balla on 04.07.2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var managerAPI = ManagerAPI()
    
    var body: some View {
        NavigationStack {
            Form {
                Section(managerAPI.cat?.id ?? "ID") {
                    if let data = managerAPI.cat?.url {
                        AsyncImage(url: URL(string: data)){ result in
                            result.image?
                                .resizable()
                                .scaledToFill()
                                .cornerRadius(5)
                        }
                        .frame(width: 200, height: 200)
                    }
                    else {
                        Text("Loading...")
                    }
                    Button("Refresh") {
                        print(managerAPI.fetchRandomCat())
                    }
                }
                .frame(maxWidth: .infinity)
            }
            .navigationTitle("Random Cat")
            .onAppear {
                managerAPI.fetchRandomCat()
            }
        }
    }
}

#Preview {
    ContentView()
}
