//
//  GenericModel.swift
//  ExamenMoviles
//
//  Created by Arturo Sanchez on 07/10/24.
//


import Foundation

struct CharacterModel: Identifiable, Decodable {
    let id: Int
    let name: String
    let ki: String
    let maxKi: String
    let race: String
    let gender: String
    let description: String
    let image: String
    let affiliation: String
    let planetId: Int?
}


