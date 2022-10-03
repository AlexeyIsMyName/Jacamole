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
        collectionView.backgroundColor = UIColor(named: "BackgroungColor")
        return collectionView
    }()
    
    private var viewModel: SongsCollectionViewModel!

    private var songs = [
        ["Top 10": ["Song One", "Song Two", "Song Three", "Song Four", "Song Five", "Song Six", "Song Seven", "Song Eight", "Song Nine", "Song Ten"]],
        ["Genre": ["Rap", "Pop", "Jazz"]]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewModel()
        setupViews()
        setupLayouts()
    }
}

// MARK: Setting up view model
extension SongsMainViewController {
    private func setupViewModel() {
        let viewModel = SongsCollectionViewModel(songsAPIClient: SongsAPIClient())
        
        viewModel.viewModelChanged = { [weak self] in
            guard let self = self else { return }
            self.collectionView.reloadData()
        }
        
        self.viewModel = viewModel
    }
}

// MARK: Setting up views and their layouts
extension SongsMainViewController {
    private func setupViews() {
        view.backgroundColor = UIColor(named: "BackgroungColor")
        view.addSubview(collectionView)

        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(SongCollectionViewCell.self,
                                forCellWithReuseIdentifier: "SongCollectionViewCell")
        
        collectionView.register(SongsCollectionReusableView.self,
                                forSupplementaryViewOfKind: "header",
                                withReuseIdentifier: "SongsCollectionReusableView")
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
}

// MARK: Providing compositional layout for collection view
extension SongsMainViewController {
    private func setupCompositionalLayout() -> UICollectionViewCompositionalLayout {
        let inset: CGFloat = 8
        
        // Item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        // Group
        let outerGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.4), heightDimension: .fractionalWidth(0.45))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: outerGroupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: inset, bottom: 0, trailing: inset)
        
        // Section
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
        section.orthogonalScrollingBehavior = .continuous
        
        // Supplementary Item - HEADER
        let headerItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(30))
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
        return viewModel.songsVM.count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SongsCollectionReusableView", for: indexPath) as? SongsCollectionReusableView else {
            return SongsCollectionReusableView()
        }
        
        let section = viewModel.songsVM[indexPath.section]
        let title = section.keys.first!
        
        if let _ = section[title] as? [Song] {
            headerView.configure(with: title, isTappable: true)
        } else {
            headerView.configure(with: title)
        }
        
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let section = viewModel.songsVM[section]
        return section.values.first?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SongCollectionViewCell", for: indexPath) as? SongCollectionViewCell else {
            return SongCollectionViewCell()
        }
    
        let section = viewModel.songsVM[indexPath.section]
        let items = section.values.first!
        
        if let songs = items as? [Song] {
            let song = songs[indexPath.row]
            cell.title.text = song.artistName
            cell.secondaryTitle.text = song.name
            cell.posterImage.load(urlAdress: song.image)
        } else if let genres = items as? [SongsCollectionGenres] {
            let genre = genres[indexPath.row]
            cell.title.text = genre.rawValue.uppercased()
            cell.posterImage.image = UIImage(named: genre.rawValue)
        }
        
        return cell
    }
}

// MARK: UICollectionViewDelegate
extension SongsMainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let section = viewModel.songsVM[indexPath.section]
        let items = section.values.first!
        
        if let songs = items as? [Song] {
            let playerVC = PlayerViewController()
            playerVC.modalPresentationStyle = .pageSheet
            playerVC.setSongs(songs, startIndex: indexPath.row)
            present(playerVC, animated: true)
            
            
            let song = songs[indexPath.row]
            print("\(song.artistName) - \(song.name)")
            
        } else if let genres = items as? [SongsCollectionGenres] {
            let genre = genres[indexPath.row]
            print(genre.rawValue)
        }
    }
}
