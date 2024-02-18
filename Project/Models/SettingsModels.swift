//
//  SettingsModels.swift
//  Project
//
//  Created by Kaan Uzun on 1.02.2024.
//

import Foundation

struct Section {
  let title: String
  let options: [Option]
}

struct Option {
  let title: String
  let handler: () -> Void
}
