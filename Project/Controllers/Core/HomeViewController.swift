//
//  ViewController.swift
//  Project
//
//  Created by Kaan Uzun on 23.01.2024.
//

import UIKit

class HomeViewController: UIViewController {

  private var collectionView: UICollectionView = UICollectionView(
    frame: .zero,
    collectionViewLayout: UICollectionViewCompositionalLayout { sectionIndex, _ -> NSCollectionLayoutSection? in
      return HomeViewController.createSectionLayout(section: sectionIndex)
     }
  )

  private let spinner: UIActivityIndicatorView = {
    let spinner = UIActivityIndicatorView()
    spinner.tintColor = .label
    spinner.hidesWhenStopped = true
    return spinner
  }()

  override func viewDidLoad() {
    super.viewDidLoad()

    title = "Browse"
    view.backgroundColor = .systemBackground
    navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"),
                                                        style: .done,
                                                        target: self,
                                                        action: #selector(didTapSettings)
    )
    configureCollectionView()
    view.addSubview(spinner)
    fetchData()

  }

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    collectionView.frame = view.bounds
  }


  private func configureCollectionView() {
    view.addSubview(collectionView)
    collectionView.register(UICollectionViewListCell.self,
                            forCellWithReuseIdentifier: "cell")
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.backgroundColor = .systemBackground

  }

  private static func createSectionLayout(section: Int) -> NSCollectionLayoutSection{
    //Item
    let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
                                      widthDimension: .fractionalWidth(1.0),
                                      heightDimension: .fractionalHeight(1.0))
                                      )

    item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)

    //Vertical Group inside Horizontal Group
    let verticalGroup = NSCollectionLayoutGroup.vertical(
        layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .absolute(120)
        ),
        subitem: item,
        count: 3
    )

    let horizontalGroup = NSCollectionLayoutGroup.horizontal(
        layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .absolute(120)
        ),
        subitem: verticalGroup,
        count: 1
    )
    //Section
    let section = NSCollectionLayoutSection(group: horizontalGroup)
    section.orthogonalScrollingBehavior = .continuous
    return section
  }

  private func fetchData(){
    //First, New Releases
    //Second, Featured Playlists
    //Third, Recomended Tracks
    APICaller.shared.getRecommendedGenres { result in
      switch result {
      case.success(let model):
        let genres = model.genres
        var seeds = Set<String>()
        while seeds.count < 5 {
          if let random = genres.randomElement() {
            seeds.insert(random)
          }
        }
        APICaller.shared.getRecommendations(genres: seeds) { _ in

        }

      case .failure(let error): break
      }
    }
  }

  @objc func didTapSettings() {
    let vc = SettingsViewController()
    vc.title = "Settings"
    vc.navigationItem.largeTitleDisplayMode = .never
    navigationController?.pushViewController(vc, animated: true)

  }

}


extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    20
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
    cell.backgroundColor = .systemGreen
    return cell
  }
}