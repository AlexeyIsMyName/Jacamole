//
//  PlayerViewController.swift
//  Jacamole
//
//  Created by ALEKSEY SUSLOV on 28.09.2022.
//

import UIKit

class PlayerViewController: UIViewController {
    
    let audioManager = AudioManager()
    
    private lazy var nowPlayingLabel: UILabel = {
        let nowPlayingLabel = UILabel()
        nowPlayingLabel.font = .systemFont(ofSize: 28, weight: .medium)
        nowPlayingLabel.textColor = UIColor(named: "TextColor")
        nowPlayingLabel.text = "Now Playing"
        return nowPlayingLabel
    }()
    
    private lazy var posterImage: UIImageView = {
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
        
        return posterView
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
        let titlesVStack = UIStackView(arrangedSubviews: [
            artistTitle,
            songTitle
        ])
        
        titlesVStack.axis = .vertical
        titlesVStack.distribution = .fillProportionally
        titlesVStack.alignment = .center
        titlesVStack.spacing = 16
        titlesVStack.backgroundColor = UIColor(named: "BackgroungColor")
        return titlesVStack
    }()
    
    private lazy var imageAndTitlesVStack: UIStackView = {
        let imageAndTitlesVStack = UIStackView(arrangedSubviews: [
            posterView,
            titlesVStack
        ])
        
        imageAndTitlesVStack.axis = .vertical
        imageAndTitlesVStack.distribution = .equalCentering
        imageAndTitlesVStack.alignment = .center
        imageAndTitlesVStack.spacing = 16
        imageAndTitlesVStack.backgroundColor = UIColor(named: "BackgroungColor")
        return imageAndTitlesVStack
    }()
    
    private lazy var songZeroTimeTitle: UILabel = {
        let songZeroTimeTitle = UILabel()
        songZeroTimeTitle.font = .systemFont(ofSize: 12, weight: .light)
        songZeroTimeTitle.textColor = UIColor(named: "TextColor")
        songZeroTimeTitle.text = "0.00"
        return songZeroTimeTitle
    }()
    
    private lazy var songTimeTitle: UILabel = {
        let songTimeTitle = UILabel()
        songTimeTitle.font = .systemFont(ofSize: 12, weight: .light)
        songTimeTitle.textColor = UIColor(named: "TextColor")
        songTimeTitle.text = "0.00"
        return songTimeTitle
    }()
    
    private lazy var songDuartionSlider: UISlider = {
        let sdSlider = UISlider()
        sdSlider.tintColor = UIColor(named: "TextColor")
        return sdSlider
    }()
    
    private lazy var songDurationHStack: UIStackView = {
        let songDurationHStack = UIStackView(arrangedSubviews: [
            songZeroTimeTitle,
            songDuartionSlider,
            songTimeTitle
        ])
        songDurationHStack.axis = .horizontal
        songDurationHStack.distribution = .fill
        songDurationHStack.alignment = .center
        songDurationHStack.spacing = 16
        songDurationHStack.backgroundColor = UIColor(named: "BackgroungColor")
        return songDurationHStack
    }()
    
    private lazy var backwardButton: UIButton = {
        let backwardButton = UIButton()
        backwardButton.tintColor = UIColor(named: "TextColor")
        backwardButton.setImage(UIImage(systemName: "backward.fill"),
                                for: .normal)
        backwardButton.addTarget(self,
                                 action: #selector(backwardButtonPressed),
                                 for: .touchUpInside)
        return backwardButton
    }()
    
    private lazy var playAndPauseButton: UIButton = {
        let playAndPauseButton = UIButton()
        playAndPauseButton.tintColor = UIColor(named: "TextColor")
        playAndPauseButton.setImage(UIImage(systemName: "playpause.fill"),
                                    for: .normal)
        playAndPauseButton.addTarget(self,
                                     action: #selector(playPauseButtonPressed),
                                     for: .touchUpInside)
        
        return playAndPauseButton
    }()
    
    private lazy var forwardButton: UIButton = {
        let forwardButton = UIButton()
        forwardButton.tintColor = UIColor(named: "TextColor")
        forwardButton.setImage(UIImage(systemName: "forward.fill"),
                               for: .normal)
        forwardButton.addTarget(self,
                                action: #selector(forwardButtonPressed),
                                for: .touchUpInside)
        return forwardButton
    }()
    
    private lazy var controlsHStack: UIStackView = {
        let controlsHStack = UIStackView(arrangedSubviews: [
            backwardButton,
            playAndPauseButton,
            forwardButton
        ])
        controlsHStack.axis = .horizontal
        controlsHStack.distribution = .fillEqually
        controlsHStack.alignment = .center
        controlsHStack.spacing = 16
        controlsHStack.backgroundColor = UIColor(named: "BackgroungColor")
        return controlsHStack
    }()
    
    private lazy var volumeControlSlider: UISlider = {
        let vcSlider = UISlider()
        vcSlider.tintColor = UIColor(named: "TextColor")
        vcSlider.minimumValueImage = UIImage(systemName: "speaker.1")
        vcSlider.maximumValueImage = UIImage(systemName: "speaker.3")
        vcSlider.value = audioManager.volume
        vcSlider.addTarget(self,
                           action: #selector(volumeSliderChanged),
                           for: .valueChanged)
        return vcSlider
    }()
    
    private lazy var allControlsVStack: UIStackView = {
        let allControlsVStack = UIStackView(arrangedSubviews: [
            songDurationHStack,
            controlsHStack,
            volumeControlSlider
        ])
        
        allControlsVStack.axis = .vertical
        allControlsVStack.distribution = .equalSpacing
        allControlsVStack.alignment = .fill
        allControlsVStack.spacing = 64
        allControlsVStack.backgroundColor = UIColor(named: "BackgroungColor")
        return allControlsVStack
    }()
    
    private lazy var mainVStack: UIStackView = {
        let mainVStack = UIStackView(arrangedSubviews: [
            nowPlayingLabel,
            imageAndTitlesVStack,
            allControlsVStack
        ])
        
        mainVStack.axis = .vertical
        mainVStack.distribution = .equalSpacing
        mainVStack.alignment = .fill
        mainVStack.spacing = 16
        mainVStack.backgroundColor = UIColor(named: "BackgroungColor")
        mainVStack.translatesAutoresizingMaskIntoConstraints = false
        return mainVStack
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "BackgroungColor")
        setupViews()
        setConstraints()
        
        audioManager.setupPlayer()
        songDuartionSlider.maximumValue = Float(audioManager.currentItem.asset.duration.seconds)
        audioManager.durationHandler = { time in
            self.songDuartionSlider.value = Float(time.seconds)
        }
    }
    
    private func setupViews() {
        view.addSubview(mainVStack)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            mainVStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                        constant: 10),
            mainVStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                                            constant: 20),
            mainVStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                                             constant: -20),
            mainVStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                                           constant: -30)
        ])
        
        NSLayoutConstraint.activate([
            posterView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            posterView.heightAnchor.constraint(equalTo: posterView.widthAnchor)
        ])
    }
    
    @objc private func playPauseButtonPressed() {
        audioManager.playOrPause()
    }
    
    @objc private func backwardButtonPressed() {
        audioManager.backward()
    }
    
    @objc private func forwardButtonPressed() {
        audioManager.forward()
    }
    
    @objc private func volumeSliderChanged() {
        audioManager.volume = volumeControlSlider.value
    }
}
