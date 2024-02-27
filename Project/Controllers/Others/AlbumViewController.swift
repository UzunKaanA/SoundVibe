//
//  AlbumViewController.swift
//  Project
//
//  Created by Kaan Uzun on 23.02.2024.
//

import UIKit

class AlbumViewController: UIViewController {
  
  private let album: Album

  init (album: Album) {
    self.album = album
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
        super.viewDidLoad()
      title = album.name
      view.backgroundColor = .systemBackground

    APICaller.shared.getAlbumDetails(for: album) { result in
      DispatchQueue.main.sync {
        switch result{
        case .success(let model):
          break
        case .failure(let error):
          break
        }
      }
    }
  }
}
