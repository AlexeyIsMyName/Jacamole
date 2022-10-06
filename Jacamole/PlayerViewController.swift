//
//  PlayerViewController.swift
//  Jacamole
//
//  Created by ALEKSEY SUSLOV on 28.09.2022.
//

import UIKit

class PlayerViewController: UIViewController {
    
    private let textColor = UIColor(named: "TextColor")!
    
    private lazy var nowPlayingLabel: UILabel = {
        let nowPlayingLabel = UILabel()
        nowPlayingLabel.font = .systemFont(ofSize: 28, weight: .medium)
        nowPlayingLabel.textColor = textColor
        nowPlayingLabel.text = "Now Playing"
        return nowPlayingLabel
    }()
    
     private lazy var heartButton: UIButton = {
         let btn = UIButton()
         let config = UIImage.SymbolConfiguration(pointSize: 25.0,
                                                  weight: .light,
                                                  scale: .default)
       
         btn.setImage( UIImage.init(systemName: "heart", withConfiguration: config), for: .normal)
         btn.setImage( UIImage.init(systemName: "heart.fill", withConfiguration: config), for: .selected)
         btn.tintColor = UIColor(named: "TextColor")
         btn.setTitleColor(.red, for: .selected)
         btn.addTarget(self, action: #selector(heartButtonPressed), for: .touchUpInside)
         
         return btn
     }()
    
    private lazy var headerHStack: UIStackView = {
        let headerHStack = UIStackView(arrangedSubviews: [
            nowPlayingLabel,
            heartButton
        ])
        headerHStack.axis = .horizontal
        headerHStack.distribution = .fill
        headerHStack.alignment = .center
        headerHStack.spacing = 16
        headerHStack.backgroundColor = UIColor(named: "BackgroungColor")
        return headerHStack
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
    
    var posterViewWidthAnchor: NSLayoutConstraint?
    var posterViewHeightAnchor: NSLayoutConstraint?
    private lazy var posterView: PosterView = {
        let posterView = PosterView()
        posterView.translatesAutoresizingMaskIntoConstraints = false
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
        artistTitle.textColor = textColor
        artistTitle.text = "Artist Title"
        return artistTitle
    }()
    
    private lazy var songTitle: UILabel = {
        let songTitle = UILabel()
        songTitle.font = .systemFont(ofSize: 12, weight: .light)
        songTitle.textColor = textColor
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
        songZeroTimeTitle.textColor = textColor
        songZeroTimeTitle.text = "0.00"
        return songZeroTimeTitle
    }()
    
    private lazy var songTimeTitle: UILabel = {
        let songTimeTitle = UILabel()
        songTimeTitle.font = .systemFont(ofSize: 12, weight: .light)
        songTimeTitle.textColor = textColor
        songTimeTitle.text = "0.00"
        return songTimeTitle
    }()
    
    private var isSongDurationSliderInteracting = false
    private lazy var songDuartionSlider: UISlider = {
        let sdSlider = UISlider()
        sdSlider.tintColor = textColor
        sdSlider.addTarget(self,
                           action: #selector(songDuartionSliderChanged),
                           for: .touchUpInside)
        sdSlider.addTarget(self,
                           action: #selector(songDuartionSliderChanged),
                           for: .touchUpOutside)
        sdSlider.addTarget(self,
                           action: #selector(songSliderInteracting),
                           for: .touchDown)
        return sdSlider
    }()
    
    @objc private func songSliderInteracting() {
        isSongDurationSliderInteracting.toggle()
    }
    
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
        
        let config = UIImage.SymbolConfiguration(pointSize: 25.0,
                                                 weight: .light,
                                                 scale: .default)
        
        let image =  UIImage.init(systemName: "backward.fill", withConfiguration: config)!
        
        
        backwardButton.setImage(image.withTintColor(textColor,
                                                        renderingMode: .alwaysOriginal),
                                    for: .normal)
        
        backwardButton.setImage(image.withTintColor(textColor.withAlphaComponent(0.4),
                                                        renderingMode: .alwaysOriginal),
                                    for: .highlighted)
        backwardButton.addTarget(self,
                                 action: #selector(backwardButtonPressed),
                                 for: .touchUpInside)
        return backwardButton
    }()
    
    private lazy var playAndPauseButton: UIButton = {
        let playAndPauseButton = UIButton()
        
        let config = UIImage.SymbolConfiguration(pointSize: 25.0,
                                                 weight: .light,
                                                 scale: .default)
        
        let image =  UIImage.init(systemName: "play.fill", withConfiguration: config)!
        
        playAndPauseButton.setImage(image.withTintColor(textColor,
                                                        renderingMode: .alwaysOriginal),
                                    for: .normal)

        playAndPauseButton.setImage(image.withTintColor(textColor.withAlphaComponent(0.4),
                                                        renderingMode: .alwaysOriginal),
                                    for: .highlighted)
        playAndPauseButton.addTarget(self,
                                     action: #selector(playPauseButtonPressed),
                                     for: .touchUpInside)
        return playAndPauseButton
    }()
    
    private lazy var forwardButton: UIButton = {
        let forwardButton = UIButton()
        
        let config = UIImage.SymbolConfiguration(pointSize: 25.0,
                                                 weight: .light,
                                                 scale: .default)
        
        let image =  UIImage.init(systemName: "forward.fill", withConfiguration: config)!
        
        forwardButton.setImage(image.withTintColor(textColor,
                                                        renderingMode: .alwaysOriginal),
                                    for: .normal)
        
        forwardButton.setImage(image.withTintColor(textColor.withAlphaComponent(0.4),
                                                        renderingMode: .alwaysOriginal),
                                    for: .highlighted)
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
        controlsHStack.distribution = .equalCentering
        controlsHStack.alignment = .center
        controlsHStack.spacing = 0
        controlsHStack.backgroundColor = UIColor(named: "BackgroungColor")
        return controlsHStack
    }()
    
    private lazy var volumeControlSlider: UISlider = {
        let vcSlider = UISlider()
        vcSlider.tintColor = textColor
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
            headerHStack,
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
    
    var audioManager = AudioManager()
    var songs: [Song]!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupHeartButton()
    }
    
    private func setupView() {
        view.backgroundColor = UIColor(named: "BackgroungColor")
        view.addSubview(mainVStack)
        
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
         
        posterViewWidthAnchor = posterView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7)
        posterViewHeightAnchor = posterView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7)
        posterViewWidthAnchor?.isActive = true
        posterViewHeightAnchor?.isActive = true
    }
    
    private func setupHeartButton() {
        let song = songs[audioManager.currentItemIndex]
        if StorageManager.shared.isFavourite(songID: song.id) {
            heartButton.isSelected = true
        } else {
            heartButton.isSelected = false
        }
        heartButton.tintColor = heartButton.isSelected ? .red : UIColor(named: "TextColor")
    }
    
    private func setupAudioManager(with songs: [Song], and startIndex: Int) {
        audioManager.setupPlayer(with: songs, startFrom: startIndex)
        
        audioManager.durationHandler = { [weak self] time in
            if let self = self {
                if !self.isSongDurationSliderInteracting {
                    self.songDuartionSlider.value = Float(time.seconds)
                }
            }
        }
        
        audioManager.newSongHandler = { [weak self] stringDuration, duration, songIndex in
            if let self = self {
                self.updateUI(with: stringDuration, duration: duration, and: songIndex)
            }
        }
    }
    
    private func updateUI(with stringDuration: String, duration: Float, and songIndex: Int) {
        // можно добавить анимации
        songDuartionSlider.maximumValue = duration
        songTimeTitle.text = stringDuration
        posterImage.load(urlAdress: songs[songIndex].image)
        songTitle.text = songs[songIndex].name
        artistTitle.text = songs[songIndex].artistName
    }
    
    @objc private func changePlayPauseButtonImage() {
        
        let config = UIImage.SymbolConfiguration(pointSize: 25.0,
                                                 weight: .light,
                                                 scale: .default)
        
        var image =  UIImage.init(systemName: "pause.fill", withConfiguration: config)!
        
        posterViewWidthAnchor?.isActive = false
        
        if audioManager.isPlaying {
            image =  UIImage.init(systemName: "play.fill", withConfiguration: config)!
            posterViewWidthAnchor = posterView.widthAnchor.constraint(equalTo: view.widthAnchor,
                                                                      multiplier: 0.7)
        } else {
            posterViewWidthAnchor = posterView.widthAnchor.constraint(equalTo: view.widthAnchor,
                                                                      multiplier: 0.73)
        }
        
        posterViewWidthAnchor?.isActive = true
        UIView.animate(withDuration: 0.5) { [weak self] in
            guard let self = self else { return }
            self.posterView.layoutIfNeeded()
        }
        
        playAndPauseButton.setImage(image.withTintColor(textColor,
                                                        renderingMode: .alwaysOriginal),
                                    for: .normal)
        
        playAndPauseButton.setImage(image.withTintColor(textColor.withAlphaComponent(0.4),
                                                        renderingMode: .alwaysOriginal),
                                    for: .highlighted)
    }
    
    func setSongs(_ songs: [Song], startIndex: Int) {
        self.songs = songs
        setupAudioManager(with: songs, and: startIndex)
    }
    
    @objc private func playPauseButtonPressed() {
        audioManager.playOrPause()
        perform(#selector(changePlayPauseButtonImage),
                with: nil,
                afterDelay: 0.02)
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
    
    @objc private func songDuartionSliderChanged() {
        perform(#selector(songSliderInteracting),
                with: nil,
                afterDelay: 0.02)
        audioManager.seek(to: songDuartionSlider.value)
    }
    
    @objc func heartButtonPressed() {
        // saving song in favorites
        let song = songs[audioManager.currentItemIndex]
        if StorageManager.shared.isFavourite(songID: song.id) {
            // если есть - удаляем
            print(StorageManager.shared.delete(song, from: .favourite))
        } else {
            // если нет - сохраняем
            StorageManager.shared.save(song, in: .favourite)
        }
        
        setupHeartButton()
    }
    
    deinit {
        print("deinit - PlayerViewController")
    }
}
