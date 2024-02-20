//
//  NewReleasesResponse.swift
//  Project
//
//  Created by Kaan Uzun on 6.02.2024.
//

import Foundation

struct NewReleasesResponse: Codable {
  let albums: AlbumsResponse
}

struct AlbumsResponse: Codable {
  let items: [Album]
}

struct Album: Codable {
  let album_type: String
  let artists: [Artist]
  let available_markets: [String]
  let id: String 
  let images: [APIImage]
  let name: String
  let release_date: String
  let total_tracks: Int
}
