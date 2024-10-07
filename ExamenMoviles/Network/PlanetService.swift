//
//  PlanetService.swift
//  ExamenMoviles
//
//  Created by Arturo Sanchez on 07/10/24.
//


import Foundation

class PlanetService {
    func fetchPlanets(completion: @escaping (Result<[PlanetModel], Error>) -> Void) {
        let urlString = "https://dragonball-api.com/api/planets" 
        print("Fetching planets from URL: \(urlString)")
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            completion(.failure(NSError(domain: "Invalid URL", code: 404, userInfo: nil)))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching planets: \(error.localizedDescription)")
                completion(.failure(error))
                return
            }

            guard let data = data else {
                print("No data returned from the server")
                completion(.failure(NSError(domain: "No Data", code: 500, userInfo: nil)))
                return
            }

            do {
                let result = try JSONDecoder().decode(PlanetResponse.self, from: data)
                print("Data successfully decoded: \(result.items.count) planets")
                completion(.success(result.items))
            } catch {
                print("Error decoding planet data: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }.resume()
    }
}
