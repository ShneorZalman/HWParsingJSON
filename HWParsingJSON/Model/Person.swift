//
//  Person.swift
//  HWParsingJSON
//
//  Created by Zalman Zoteev on 18/06/2023.
//

import Foundation

struct Person: Decodable {
    let icon_url: String
    let id: String
    let url: String
    let value: String
}
