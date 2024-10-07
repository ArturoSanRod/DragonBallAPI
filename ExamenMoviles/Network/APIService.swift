//
//  APIService.swift
//  ExamenMoviles
//
//  Created by Arturo Sanchez on 07/10/24.
//

import Foundation

class APIService {
    func fetchCharacters(page: Int, completion: @escaping (Result<[CharacterModel], Error>) -> Void) {
        let urlString = "https://dragonball-api.com/api/characters?page=\(page)&limit=10"
        print("Buscando personajes desde la URL: \(urlString)") 
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            completion(.failure(NSError(domain: "Invalid URL", code: 404, userInfo: nil)))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                completion(.failure(error))
                return
            }

            guard let data = data else {
                print("Sin información del servidor")
                completion(.failure(NSError(domain: "No Data", code: 500, userInfo: nil)))
                return
            }

            do {
                let result = try JSONDecoder().decode(CharacterResponse.self, from: data)
                print("Éxito: \(result.items.count) characters")
                completion(.success(result.items))
            } catch {
                print("Error: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }.resume()
    }
}

struct CharacterResponse: Decodable {
    let items: [CharacterModel] // Lista de personajes
}
