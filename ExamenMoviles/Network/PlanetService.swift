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
            print("URL inválido")
            completion(.failure(NSError(domain: "URL inválido", code: 404, userInfo: nil)))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                completion(.failure(error))
                return
            }

            guard let data = data else {
                print("No hubo información del servidor")
                completion(.failure(NSError(domain: "Sin Data", code: 500, userInfo: nil)))
                return
            }

            do {
                let result = try JSONDecoder().decode(PlanetResponse.self, from: data)
                print("Éxito: \(result.items.count) planetas")
                completion(.success(result.items))
            } catch {
                print("Error: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }.resume()
    }
}
