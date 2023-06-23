//
//  Person.swift
//  HWParsingJSON
//
//  Created by Zalman Zoteev on 18/06/2023.
//

import Foundation

struct Person: Decodable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let image: String
    let url: String
    let created: String
}
