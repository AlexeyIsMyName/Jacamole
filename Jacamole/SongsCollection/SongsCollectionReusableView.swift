//
//  SongsCollectionReusableView.swift
//  Jacamole
//
//  Created by ALEKSEY SUSLOV on 21.09.2022.
//

import UIKit

class SongsCollectionReusableView: UICollectionReusableView {
    
    private lazy var title: UILabel = {
        let title = UILabel()
        title.font = UIFont.systemFont(ofSize: 26, weight: .semibold)
        title.textColor = UIColor(named: "TextColor")
        title.text = "Title"
        title.textAlignment = .left
        return title
    }()
    
    private lazy var chevronImage: UIImageView = {
        let chevronImage = UIImageView()
        chevronImage.image = .init(systemName: "chevron.right")
        chevronImage.tintColor = UIColor(named: "TextColor")
        chevronImage.clipsToBounds = true
        chevronImage.sizeToFit()
        chevronImage.contentMode = .scaleAspectFill
        chevronImage.translatesAutoresizingMaskIntoConstraints = false
        return chevronImage
    }()
    
    public func configure(with title: String, isTappable: Bool = false) {
        self.title.text = title
        self.chevronImage.isHidden = !isTappable
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(title)
        addSubview(chevronImage)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraints() {
        title.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: topAnchor,
                                               constant: 0),
            title.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                   constant: 0),
            title.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                    constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            chevronImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            chevronImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ])
    }
}
