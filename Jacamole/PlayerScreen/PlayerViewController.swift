//
//  PlayerViewController.swift
//  Jacamole
//
//  Created by ALEKSEY SUSLOV on 28.09.2022.
//

import UIKit

class PlayerViewController: UIViewController {
    
    let viewModel: PlayerViewModel!
    
    let textColor = UIColor(named: "TextColor")!
    
    var nowPlayingLabel: UILabel!
    var heartButton: UIButton!
    var headerHStack: UIStackView!
    
    private var posterViewWidthAnchor: NSLayoutConstraint?
    private var posterViewHeightAnchor: NSLayoutConstraint?
    var posterView: PosterView!
    var posterImage: UIImageView!
    
    var artistTitle: UILabel!
    var songTitle: UILabel!
    var titlesVStack: UIStackView!
    var imageAndTitlesVStack: UIStackView!
    
    var songZeroTimeTitle: UILabel!
    var songTimeTitle: UILabel!
    var songDuartionSlider: UISlider!
    var songDurationHStack: UIStackView!
    
    var backwardButton: UIButton!
    var playAndPauseButton: UIButton!
    var forwardButton: UIButton!
    var playerControlsHStack: UIStackView!
    
    var volumeControlSlider: UISlider!
    var allControlsVStack: UIStackView!
    
    var mainVStack: UIStackView!
    
    override func loadView() {
        super.loadView()
        setupSubViews()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTargets()
        
        self.viewModel.timePointChanged = { [weak self] timePoint in
            guard let self = self else { return }
            self.songDuartionSlider.value = timePoint
        }
        
        self.viewModel.songModelChanged = { [weak self] songModel in
            guard let self = self else { return }
            
            self.songDuartionSlider.maximumValue = songModel.floatDuration
            self.songTimeTitle.text = songModel.stringDuration
            self.posterImage.load(urlAdress: songModel.posterImageURL)
            self.songTitle.text = songModel.title
            self.artistTitle.text = songModel.artist
            self.setupHeartButton(with: songModel.isFavourite)
        }
    }
    
    init(viewModel: PlayerViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    
    private func setupHeartButton(with condition: Bool) {
        if condition {
            heartButton.isSelected = true
        } else {
            heartButton.isSelected = false
        }
        
        heartButton.tintColor = heartButton.isSelected ? .red : UIColor(named: "TextColor")
    }
    
    private func setupTargets() {
        heartButton.addTarget(self,
                              action: #selector(heartButtonPressed),
                              for: .touchUpInside)
        
        songDuartionSlider.addTarget(self,
                                     action: #selector(songDuartionSliderChanged),
                                     for: .touchUpInside)
        songDuartionSlider.addTarget(self,
                                     action: #selector(songDuartionSliderChanged),
                                     for: .touchUpOutside)
        songDuartionSlider.addTarget(self,
                                     action: #selector(songSliderInteracting),
                                     for: .touchDown)
        
        backwardButton.addTarget(self,
                                 action: #selector(backwardButtonPressed),
                                 for: .touchUpInside)
        
        playAndPauseButton.addTarget(self,
                                     action: #selector(playPauseButtonPressed),
                                     for: .touchUpInside)
        
        forwardButton.addTarget(self,
                                action: #selector(forwardButtonPressed),
                                for: .touchUpInside)
        
        volumeControlSlider.addTarget(self,
                                      action: #selector(volumeSliderChanged),
                                      for: .valueChanged)
    }
    
    @objc private func changePlayPauseButtonImage() {
        
        let config = UIImage.SymbolConfiguration(pointSize: 25.0,
                                                 weight: .light,
                                                 scale: .default)
        
        var image =  UIImage.init(systemName: "pause.fill", withConfiguration: config)!
        
        posterViewWidthAnchor?.isActive = false
        
        if viewModel.isPlaying {
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
    
    @objc private func playPauseButtonPressed() {
        viewModel.playOrPause()
        perform(#selector(changePlayPauseButtonImage),
                with: nil,
                afterDelay: 0.02)
    }
    
    @objc private func backwardButtonPressed() {
        viewModel.backward()
    }
    
    @objc private func forwardButtonPressed() {
        viewModel.forward()
    }
    
    @objc private func volumeSliderChanged() {
        viewModel.volume = volumeControlSlider.value
    }
    
    @objc private func songDuartionSliderChanged() {
        perform(#selector(songSliderInteracting),
                with: nil,
                afterDelay: 0.02)
        viewModel.seek(to: songDuartionSlider.value)
    }
    
    @objc func heartButtonPressed() {
        let condition = viewModel.heartButtonPressed()
        setupHeartButton(with: condition)
    }
    
    @objc private func songSliderInteracting() {
        viewModel.isTimeSeeking.toggle()
    }
    
    deinit {
        print("deinit - PlayerViewController")
    }
}
