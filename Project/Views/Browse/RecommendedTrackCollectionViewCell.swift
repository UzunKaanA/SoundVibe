//
//  RecommendedTrackCollectionViewCell.swift
//  Project
//
//  Created by Kaan Uzun on 19.02.2024.
//

import UIKit

class RecommendedTrackCollectionViewCell: UICollectionViewCell {
  static let identifier = "RecommendedTrackCollectionViewCell"

  private let albumCoverImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.layer.masksToBounds = true
    imageView.layer.cornerRadius = 8
    imageView.image = UIImage(systemName: "photo")
    imageView.contentMode = .scaleAspectFill
    return imageView
  }()

  private let trackNameLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    label.textAlignment = .center
    label.font = .systemFont(ofSize: 18, weight: .semibold)
    return label
  }()

  private let artistNameLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 15, weight: .thin)
    label.textAlignment = .center
    label.numberOfLines = 0
    return label
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = .secondarySystemBackground
    contentView.addSubview(albumCoverImageView)
    contentView.addSubview(trackNameLabel)
    contentView.addSubview(artistNameLabel)
    contentView.clipsToBounds = true
  }

  required init?(coder: NSCoder){
    fatalError()
  }

  override func layoutSubviews() {
    super.layoutSubviews()

    artistNameLabel.frame = CGRect(
      x: albumCoverImageView.right+10,
      y: contentView.height/2,
      width: contentView.width-albumCoverImageView.right-15,
      height: contentView.height/2
    )

    trackNameLabel.frame = CGRect(
      x: albumCoverImageView.right+10,
      y: 0,
      width: contentView.width-albumCoverImageView.right-15,
      height: contentView.height/2
    )

    albumCoverImageView.frame = CGRect(
      x: 5,
      y: 2,
      width: contentView.height-4,
      height: contentView.height-4
    )
  }

  override func prepareForReuse() {
    super.prepareForReuse()
    func configure(with viewModel: NewReleasesCellViewModel) {
      trackNameLabel.text = nil
      artistNameLabel.text = nil
      albumCoverImageView.image = nil
    }
  }

  func configure(with viewModel: RecommendedTrackCellViewModel) {
    trackNameLabel.text = viewModel.name
    artistNameLabel.text = viewModel.artistName
    albumCoverImageView.sd_setImage(with: viewModel.artWorkURL, completed: nil)
  }

}
