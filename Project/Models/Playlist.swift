//
//  Playlist.swift
//  Project
//
//  Created by Kaan Uzun on 23.01.2024.
//

import Foundation

struct Playlist: Codable {
  let description: String
  let external_urls: [String: String]
  let id: String
  let images: [APIImage]
  let name: String
  let owner: User
}
