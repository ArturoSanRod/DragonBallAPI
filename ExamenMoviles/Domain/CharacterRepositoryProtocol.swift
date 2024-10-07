//
//  CharacterRepositoryProtocol.swift
//  ExamenMoviles
//
//  Created by Arturo Sanchez on 07/10/24.
//


protocol CharacterRepositoryProtocol {
    func getAllCharacters(page: Int, completion: @escaping (Result<[CharacterModel], Error>) -> Void)
}
