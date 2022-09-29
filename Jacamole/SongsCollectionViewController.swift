//
//  SongsCollectionViewController.swift
//  Jacamole
//
//  Created by ALEKSEY SUSLOV on 21.09.2022.
//

import UIKit

class SongsCollectionViewController: UICollectionViewController {
    
    // MARK: - Private Properties
    private var songs = [
        ["Top 10": ["Song One", "Song Two", "Song Three", "Song Four", "Song Five", "Song Six", "Song Seven", "Song Eight", "Song Nine", "Song Ten"]],
        ["Recently Played": ["One", "Two", "Three", "Four", "Five"]],
        ["Genre": ["Rap", "Pop", "Jazz"]]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        collectionView.backgroundColor = UIColor(named: "BackgroungColor")
    }
    
    convenience init() {
        let compositionalLayout: UICollectionViewCompositionalLayout = {
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
            
            // Decoration Item - BACKGROUND
            // let backgroundItem = NSCollectionLayoutDecorationItem.background(elementKind: "background")
            // section.decorationItems = [backgroundItem]
            
            // Section Configuration
            let config = UICollectionViewCompositionalLayoutConfiguration()
            config.interSectionSpacing = 20
            
            // Make UICollectionViewCompositionalLayout
             let layout = UICollectionViewCompositionalLayout(section: section, configuration: config)
            // layout.register(BackgroundDecorationView.self, forDecorationViewOfKind: "background")
            
            return layout
        }()
        
        self.init(collectionViewLayout: compositionalLayout)
    }
    
    // MARK: - Private Methods
    private func registerCells() {
        collectionView.register(SongCollectionViewCell.self,
                                forCellWithReuseIdentifier: "SongCollectionViewCell")
        
        collectionView.register(HeaderCollectionReusableView.self,
                                forSupplementaryViewOfKind: "header",
                                withReuseIdentifier: "HeaderCollectionReusableView")
    }
}


// MARK: UICollectionViewDataSource
extension SongsCollectionViewController {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return songs.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderCollectionReusableView", for: indexPath) as? HeaderCollectionReusableView else {
            return HeaderCollectionReusableView()
        }
        
        let section = songs[indexPath.section]
        let title = section.keys.first!
        headerView.configure(with: title)
        return headerView
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let section = songs[section]
        return section.values.first?.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
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
extension SongsCollectionViewController {
    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
}
