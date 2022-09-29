//
//  SongsMainViewController.swift
//  Jacamole
//
//  Created by ALEKSEY SUSLOV on 29.09.2022.
//

import UIKit

class SongsMainViewController: UIViewController {
    
    private lazy var collectionView: UICollectionView = {
        let viewLayout = setupCompositionalLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        collectionView.backgroundColor = .white
        return collectionView
    }()

    private var songs = [
        ["Top 10": ["Song One", "Song Two", "Song Three", "Song Four", "Song Five", "Song Six", "Song Seven", "Song Eight", "Song Nine", "Song Ten"]],
        ["Recently Played": ["One", "Two", "Three", "Four", "Five"]],
        ["Genre": ["Rap", "Pop", "Jazz"]]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupLayouts()
    }
    
    private func setupViews() {
        view.backgroundColor = UIColor(named: "BackgroungColor")
        collectionView.backgroundColor = UIColor(named: "BackgroungColor")
        
        view.addSubview(collectionView)

        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(SongCollectionViewCell.self,
                                forCellWithReuseIdentifier: "SongCollectionViewCell")
        
        collectionView.register(HeaderCollectionReusableView.self,
                                forSupplementaryViewOfKind: "header",
                                withReuseIdentifier: "HeaderCollectionReusableView")
    }
    
    private func setupLayouts() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        // Layout constraints for `collectionView`
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
        ])
    }
    
    private func setupCompositionalLayout() -> UICollectionViewCompositionalLayout {
        let inset: CGFloat = 8
        
        // Item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        // Group
        let outerGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.4), heightDimension: .fractionalHeight(0.21))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: outerGroupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: inset, bottom: 0, trailing: inset)
        
        // Section
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
        section.orthogonalScrollingBehavior = .continuous
        
        // Supplementary Item - HEADER
        let headerItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50))
        let headerItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerItemSize, elementKind: "header", alignment: .top)
        headerItem.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: inset, bottom: 8, trailing: inset)
        section.boundarySupplementaryItems = [headerItem]
        
        // Section Configuration
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 20
        
        // Make UICollectionViewCompositionalLayout
        let layout = UICollectionViewCompositionalLayout(section: section, configuration: config)
        
        return layout
    }

}

// MARK: UICollectionViewDataSource
extension SongsMainViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return songs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderCollectionReusableView", for: indexPath) as? HeaderCollectionReusableView else {
            return HeaderCollectionReusableView()
        }
        
        let section = songs[indexPath.section]
        let title = section.keys.first!
        headerView.configure(with: title)
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let section = songs[section]
        return section.values.first?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SongCollectionViewCell", for: indexPath) as? SongCollectionViewCell else {
            return SongCollectionViewCell()
        }
    
        let section = songs[indexPath.section]
        let songs = section.values.first ?? [""]
        let title = songs[indexPath.row]
        cell.configure(with: title)
    
        return cell
    }

}

// MARK: UICollectionViewDelegate
extension SongsMainViewController: UICollectionViewDelegate {
    
}
