//
//  PlayerViewController.swift
//  Jacamole
//
//  Created by ALEKSEY SUSLOV on 28.09.2022.
//

import UIKit

class PlayerViewController: UIViewController {
    
    private lazy var posterImage: UIImageView = {
        let posterImage = UIImageView(image: #imageLiteral(resourceName: "guacamole-vectorportal"))
//        let posterImage = UIImageView()
        posterImage.clipsToBounds = true
        posterImage.layer.cornerRadius = 16
        posterImage.sizeToFit()
        posterImage.contentMode = .scaleAspectFill
        posterImage.backgroundColor = .gray
        posterImage.translatesAutoresizingMaskIntoConstraints = false
        return posterImage
    }()
    
    private lazy var artistTitle: UILabel = {
        let artistTitle = UILabel()
        artistTitle.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        artistTitle.textColor = UIColor(named: "TextColor")
        artistTitle.text = "Artist Title"
        artistTitle.translatesAutoresizingMaskIntoConstraints = false
        return artistTitle
    }()
    
    private lazy var songTitle: UILabel = {
        let songTitle = UILabel()
        songTitle.font = .systemFont(ofSize: 12, weight: .light)
        songTitle.textColor = UIColor(named: "TextColor")
        songTitle.text = "Song Title"
        songTitle.translatesAutoresizingMaskIntoConstraints = false
        return songTitle
    }()
    
    private lazy var vStack: UIStackView = {
        let vStack = UIStackView()
        vStack.axis = .vertical
        vStack.distribution = .fillEqually
        vStack.alignment = .center
        vStack.spacing = 16
        vStack.backgroundColor = .gray
        vStack.translatesAutoresizingMaskIntoConstraints = false
        return vStack
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        configureVStack()
        setConstraints()
    }
    
    private func setupViews() {
        view.addSubview(vStack)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            vStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                        constant: 0),
            vStack.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                            constant: 0),
            vStack.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                             constant: 0),
            vStack.bottomAnchor.constraint(equalTo: view.bottomAnchor,
                                           constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            posterImage.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            posterImage.heightAnchor.constraint(equalTo: posterImage.widthAnchor)
        ])
    }
    
    private func configureVStack() {
        vStack.addArrangedSubview(posterImage)
        vStack.addArrangedSubview(artistTitle)
        vStack.addArrangedSubview(songTitle)
    }
}
