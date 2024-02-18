//
//  Artist.swift
//  Project
//
//  Created by Kaan Uzun on 23.01.2024.
//

import Foundation


struct Artist: Codable {
  let id: String
  let name: String
  let type: String
  let external_urls: [String: String]
}
