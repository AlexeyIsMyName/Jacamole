//
//  PlayerViewController.swift
//  Jacamole
//
//  Created by ALEKSEY SUSLOV on 28.09.2022.
//

import UIKit

class PlayerViewController: UIViewController {
    
    private lazy var nowPlaying: UILabel = {
        let nowPlaying = UILabel()
        nowPlaying.font = .systemFont(ofSize: 28, weight: .medium)
        nowPlaying.textColor = UIColor(named: "TextColor")
        nowPlaying.text = "Now Playing"
        return nowPlaying
    }()
    
    private lazy var posterImage: UIImageView = {
        let posterImage = UIImageView(image: #imageLiteral(resourceName: "guacamole-vectorportal"))
//        let posterImage = UIImageView()
        posterImage.clipsToBounds = true
        posterImage.layer.cornerRadius = 16
        posterImage.sizeToFit()
        posterImage.contentMode = .scaleAspectFill
        posterImage.backgroundColor = .gray
        return posterImage
    }()
    
    private lazy var artistTitle: UILabel = {
        let artistTitle = UILabel()
        artistTitle.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        artistTitle.textColor = UIColor(named: "TextColor")
        artistTitle.text = "Artist Title"
        return artistTitle
    }()
    
    private lazy var songTitle: UILabel = {
        let songTitle = UILabel()
        songTitle.font = .systemFont(ofSize: 12, weight: .light)
        songTitle.textColor = UIColor(named: "TextColor")
        songTitle.text = "Song Title"
        return songTitle
    }()
    
    private lazy var titlesVStack: UIStackView = {
        let vStack = UIStackView(arrangedSubviews: [
            artistTitle,
            songTitle
        ])
        
        vStack.axis = .vertical
        vStack.distribution = .fillEqually
        vStack.alignment = .center
        vStack.spacing = 16
        vStack.backgroundColor = UIColor(named: "BackgroungColor")
        vStack.translatesAutoresizingMaskIntoConstraints = false
        return vStack
    }()
    
    private lazy var imageAndtitlesVStack: UIStackView = {
        let vStack = UIStackView(arrangedSubviews: [
            posterImage,
            titlesVStack
        ])
        
        vStack.axis = .vertical
        vStack.distribution = .fillEqually
        vStack.alignment = .center
        vStack.spacing = 16
        vStack.backgroundColor = UIColor(named: "BackgroungColor")
        vStack.translatesAutoresizingMaskIntoConstraints = false
        return vStack
    }()
    
    private lazy var backwardButton: UIButton = {
        let backwardButton = UIButton()
        backwardButton.tintColor = UIColor(named: "TextColor")
        backwardButton.setImage(UIImage(systemName: "backward.fill"),
                                for: .normal)
        return backwardButton
    }()
    
    private lazy var playAndPauseButton: UIButton = {
        let playAndPauseButton = UIButton()
        playAndPauseButton.tintColor = UIColor(named: "TextColor")
        playAndPauseButton.setImage(UIImage(systemName: "playpause.fill"),
                                    for: .normal)
        return playAndPauseButton
    }()
    
    private lazy var forwardButton: UIButton = {
        let forwardButton = UIButton()
        forwardButton.tintColor = UIColor(named: "TextColor")
        forwardButton.setImage(UIImage(systemName: "forward.fill"),
                               for: .normal)
        return forwardButton
    }()
    
    private lazy var songZeroTimeTitle: UILabel = {
        let songTimeZeroTitle = UILabel()
        songTimeZeroTitle.font = .systemFont(ofSize: 12, weight: .light)
        songTimeZeroTitle.textColor = UIColor(named: "TextColor")
        songTimeZeroTitle.text = "0.00"
        return songTimeZeroTitle
    }()
    
    private lazy var songTimeTitle: UILabel = {
        let songTimeZeroTitle = UILabel()
        songTimeZeroTitle.font = .systemFont(ofSize: 12, weight: .light)
        songTimeZeroTitle.textColor = UIColor(named: "TextColor")
        songTimeZeroTitle.text = "0.00"
        return songTimeZeroTitle
    }()
    
    private lazy var songDuartionSlider: UISlider = {
        let sdSlider = UISlider()
        sdSlider.tintColor = UIColor(named: "TextColor")
        return sdSlider
    }()
    
    private lazy var songDurationHStack: UIStackView = {
        let hStack = UIStackView(arrangedSubviews: [
            songZeroTimeTitle,
            songDuartionSlider,
            songTimeTitle
        ])
        hStack.axis = .horizontal
        hStack.distribution = .fill
        hStack.alignment = .center
        hStack.spacing = 16
        hStack.backgroundColor = UIColor(named: "BackgroungColor")
        return hStack
    }()
    
    private lazy var controlsHStack: UIStackView = {
        let hStack = UIStackView(arrangedSubviews: [
            backwardButton,
            playAndPauseButton,
            forwardButton
        ])
        hStack.axis = .horizontal
        hStack.distribution = .fillEqually
        hStack.alignment = .center
        hStack.spacing = 16
        hStack.backgroundColor = UIColor(named: "BackgroungColor")
        return hStack
    }()
    
    private lazy var volumeControlSlider: UISlider = {
        let vcSlider = UISlider()
        vcSlider.tintColor = UIColor(named: "TextColor")
        vcSlider.minimumValueImage = UIImage(systemName: "speaker.1")
        vcSlider.maximumValueImage = UIImage(systemName: "speaker.3")
        return vcSlider
    }()
    
    private lazy var mainVStack: UIStackView = {
        let vStack = UIStackView(arrangedSubviews: [
            nowPlaying,
            imageAndtitlesVStack,
            songDurationHStack,
            controlsHStack,
            volumeControlSlider
        ])
        
        vStack.axis = .vertical
        vStack.distribution = .equalCentering
        vStack.alignment = .fill
        vStack.spacing = 16
        vStack.backgroundColor = UIColor(named: "BackgroungColor")
        vStack.translatesAutoresizingMaskIntoConstraints = false
        return vStack
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "BackgroungColor")
        setupViews()
        setConstraints()
        
        // ТЕНЬ НЕ РАБОТАЕТ!!!
        posterImage.layer.shadowColor = UIColor.black.cgColor
        posterImage.layer.shadowOffset = .zero
        posterImage.layer.shadowRadius = 10
        posterImage.layer.shadowOpacity = 1
    }
    
    private func setupViews() {
        view.addSubview(mainVStack)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            mainVStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                        constant: 20),
            mainVStack.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                            constant: 20),
            mainVStack.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                             constant: -20),
            mainVStack.bottomAnchor.constraint(equalTo: view.bottomAnchor,
                                           constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            posterImage.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            posterImage.heightAnchor.constraint(equalTo: posterImage.widthAnchor),
            posterImage.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
