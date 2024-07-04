//
//  ManagerAPI.swift
//  MeowAPI
//
//  Created by Alex Balla on 04.07.2024.
//

import Foundation

class ManagerAPI: ObservableObject {
    
    @Published var cat: Cat?
    static var apiKey = "live_9PAuLXluh8EMCawIgQpPqi7mMoGeBP1dFHCd286sPwWyZbWo4eMQIeCG0Od7tdFi" // Your API Key
    
    func fetchRandomCat(){
        let urlString = "https://api.thecatapi.com/v1/images/search?limit=1?api_key=\(ManagerAPI.apiKey)"
        guard let url = URL(string: urlString) else {
            print("Invalid URL fetching dish")
            return
        }
        
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    let decodedResponse = try JSONDecoder().decode([Cat].self, from: data)
                    DispatchQueue.main.async {
                        self.cat = decodedResponse.first
                    }
                } catch {
                    print("Decoding error: \(error)")
                }
            } else if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }.resume()
    }
}
