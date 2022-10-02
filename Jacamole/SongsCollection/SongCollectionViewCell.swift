//
//  SongCollectionViewCell.swift
//  Jacamole
//
//  Created by ALEKSEY SUSLOV on 21.09.2022.
//

import UIKit

class SongCollectionViewCell: UICollectionViewCell {
    
    lazy var posterImage: UIImageView = {
        let posterImage = UIImageView()
        posterImage.image = UIImage(named: "guacamole-vectorportal")
        posterImage.sizeToFit()
        posterImage.contentMode = .scaleAspectFill
        
        posterImage.layer.cornerRadius = 12
        posterImage.layer.masksToBounds = true
        
        posterImage.translatesAutoresizingMaskIntoConstraints = false
        return posterImage
    }()
    
    private lazy var posterView: PosterView = {
        let posterView = PosterView()
        posterView.addSubview(posterImage)
        
        NSLayoutConstraint.activate([
            posterImage.topAnchor.constraint(equalTo: posterView.topAnchor),
            posterImage.leadingAnchor.constraint(equalTo: posterView.leadingAnchor),
            posterImage.trailingAnchor.constraint(equalTo: posterView.trailingAnchor),
            posterImage.bottomAnchor.constraint(equalTo: posterView.bottomAnchor)
        ])
        
        posterView.translatesAutoresizingMaskIntoConstraints = false
        return posterView
    }()
    
    lazy var title: UILabel = {
        let title = UILabel()
        title.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        title.textColor = UIColor(named: "TextColor")
        title.text = "Title"
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    lazy var secondaryTitle: UILabel = {
        let secondaryTitle = UILabel()
        secondaryTitle.font = .systemFont(ofSize: 12, weight: .light)
        secondaryTitle.textColor = UIColor(named: "TextColor")
        secondaryTitle.translatesAutoresizingMaskIntoConstraints = false
        return secondaryTitle
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(posterView)
        contentView.addSubview(title)
        contentView.addSubview(secondaryTitle)
    }
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            posterView.heightAnchor.constraint(equalTo: contentView.widthAnchor),
            posterView.topAnchor.constraint(equalTo: contentView.topAnchor,
                                               constant: 0),
            posterView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                                   constant: 0),
            posterView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                                    constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: posterImage.bottomAnchor,
                                               constant: 0),
            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                                   constant: 0),
            title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                                    constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            secondaryTitle.topAnchor.constraint(equalTo: title.bottomAnchor,
                                               constant: 0),
            secondaryTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                                   constant: 0),
            secondaryTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                                    constant: 0)
        ])
    }
}
