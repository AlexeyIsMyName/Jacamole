//
//  SongCollectionViewCell.swift
//  Jacamole
//
//  Created by ALEKSEY SUSLOV on 21.09.2022.
//

import UIKit

class SongCollectionViewCell: UICollectionViewCell {
    
    private lazy var posterImage: UIImageView = {
        let posterImage = UIImageView(image: #imageLiteral(resourceName: "guacamole-vectorportal"))
//        let posterImage = UIImageView()
        posterImage.clipsToBounds = true
        posterImage.layer.cornerRadius = 16
        posterImage.sizeToFit()
        posterImage.contentMode = .scaleAspectFill
        posterImage.translatesAutoresizingMaskIntoConstraints = false
        posterImage.backgroundColor = .gray
        return posterImage
    }()
    
    private lazy var title: UILabel = {
        let title = UILabel()
        title.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        title.textColor = UIColor(named: "TextColor")
        title.text = "Title"
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    private lazy var secondaryTitle: UILabel = {
        let secondaryTitle = UILabel()
        secondaryTitle.font = .systemFont(ofSize: 12, weight: .light)
        secondaryTitle.textColor = UIColor(named: "TextColor")
        secondaryTitle.text = "Secondary Title"
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
        contentView.addSubview(posterImage)
        contentView.addSubview(title)
        contentView.addSubview(secondaryTitle)
    }
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            posterImage.heightAnchor.constraint(equalTo: contentView.widthAnchor),
            posterImage.topAnchor.constraint(equalTo: contentView.topAnchor,
                                               constant: 0),
            posterImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                                   constant: 0),
            posterImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
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
                                                    constant: 0),
            secondaryTitle.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                                   constant: 0)
        ])
        
    }
}
