//
//  FeaturedPlaylistCollectionViewCell.swift
//  Project
//
//  Created by Kaan Uzun on 19.02.2024.
//

import UIKit

class FeaturedPlaylistCollectionViewCell: UICollectionViewCell {
  static let identifier = "FeaturedPlaylistCollectionViewCell"
  
  private let playlistCoverImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.layer.masksToBounds = true
    imageView.layer.cornerRadius = 8
    imageView.image = UIImage(systemName: "photo")
    imageView.contentMode = .scaleAspectFill
    return imageView
  }()

  private let playlistNameLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    label.textAlignment = .center
    label.font = .systemFont(ofSize: 18, weight: .semibold)
    return label
  }()

  private let creatorNameLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 15, weight: .thin)
    label.textAlignment = .center
    label.numberOfLines = 0
    return label
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = .secondarySystemBackground
    contentView.addSubview(playlistCoverImageView)
    contentView.addSubview(playlistNameLabel)
    contentView.addSubview(creatorNameLabel)
    contentView.clipsToBounds = true
  }

  required init?(coder: NSCoder){
    fatalError()
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    creatorNameLabel.frame = CGRect(
      x: 3,
      y: contentView.height-44,
      width: contentView.width-6,
      height: 30
    )

    playlistNameLabel.frame = CGRect(
      x: 3,
      y: contentView.height-60,
      width: contentView.width-6,
      height: 30
    )

    let imageSize = contentView.height-70
    playlistCoverImageView.frame = CGRect(
      x: (contentView.width-imageSize)/2,
      y: 3 ,
      width: imageSize,
      height: imageSize
    )
  }

  override func prepareForReuse() {
    super.prepareForReuse()
    func configure(with viewModel: NewReleasesCellViewModel) {
      playlistNameLabel.text = nil
      creatorNameLabel.text = nil
      playlistCoverImageView.image = nil
    }
  }

  func configure(with viewModel: FeaturedPlaylistsCellViewModel) {
    playlistNameLabel.text = viewModel.name
    creatorNameLabel.text = viewModel.creatorName
    playlistCoverImageView.sd_setImage(with: viewModel.artworkURL, completed: nil)
  }


}
