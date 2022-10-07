//
//  ExtensionPlayerVCSetupSubviews.swift
//  Jacamole
//
//  Created by ALEKSEY SUSLOV on 08.10.2022.
//

import UIKit

extension PlayerViewController {
    func setupSubViews() {
        nowPlayingLabel = {
            let nowPlayingLabel = UILabel()
            nowPlayingLabel.font = .systemFont(ofSize: 28, weight: .medium)
            nowPlayingLabel.textColor = textColor
            nowPlayingLabel.text = "Now Playing"
            return nowPlayingLabel
        }()
        
        heartButton = {
            let btn = UIButton()
            let config = UIImage.SymbolConfiguration(pointSize: 25.0,
                                                     weight: .light,
                                                     scale: .default)
          
            btn.setImage( UIImage.init(systemName: "heart", withConfiguration: config), for: .normal)
            btn.setImage( UIImage.init(systemName: "heart.fill", withConfiguration: config), for: .selected)
            btn.tintColor = UIColor(named: "TextColor")
            btn.setTitleColor(.red, for: .selected)
            return btn
        }()
        
        headerHStack = {
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
        
        posterImage = {
            let posterImage = UIImageView()
            posterImage.image = UIImage(named: "guacamole-vectorportal")
            posterImage.sizeToFit()
            posterImage.contentMode = .scaleAspectFill
            
            posterImage.layer.cornerRadius = 12
            posterImage.layer.masksToBounds = true
            
            posterImage.translatesAutoresizingMaskIntoConstraints = false
            return posterImage
        }()
        
        posterView = {
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
        
        artistTitle = {
            let artistTitle = UILabel()
            artistTitle.font = UIFont.systemFont(ofSize: 16, weight: .medium)
            artistTitle.textColor = textColor
            artistTitle.text = "Artist Title"
            return artistTitle
        }()
        
        songTitle = {
            let songTitle = UILabel()
            songTitle.font = .systemFont(ofSize: 12, weight: .light)
            songTitle.textColor = textColor
            songTitle.text = "Song Title"
            return songTitle
        }()
        
        titlesVStack = {
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
        
        imageAndTitlesVStack = {
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
        
        songZeroTimeTitle = {
            let songZeroTimeTitle = UILabel()
            songZeroTimeTitle.font = .systemFont(ofSize: 12, weight: .light)
            songZeroTimeTitle.textColor = textColor
            songZeroTimeTitle.text = "0.00"
            return songZeroTimeTitle
        }()
        
        songTimeTitle = {
            let songTimeTitle = UILabel()
            songTimeTitle.font = .systemFont(ofSize: 12, weight: .light)
            songTimeTitle.textColor = textColor
            songTimeTitle.text = "0.00"
            return songTimeTitle
        }()
        
        songDuartionSlider = {
            let sdSlider = UISlider()
            sdSlider.tintColor = textColor
            return sdSlider
        }()
        
        songDurationHStack = {
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
        
        backwardButton = {
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
            return backwardButton
        }()
        
        playAndPauseButton = {
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
            return playAndPauseButton
        }()
        
        forwardButton = {
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
            return forwardButton
        }()
        
        playerControlsHStack = {
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
        
        volumeControlSlider = {
            let vcSlider = UISlider()
            vcSlider.tintColor = textColor
            vcSlider.minimumValueImage = UIImage(systemName: "speaker.1")
            vcSlider.maximumValueImage = UIImage(systemName: "speaker.3")
            vcSlider.value = viewModel.volume
            return vcSlider
        }()
        
        allControlsVStack = {
            let allControlsVStack = UIStackView(arrangedSubviews: [
                songDurationHStack,
                playerControlsHStack,
                volumeControlSlider
            ])
            
            allControlsVStack.axis = .vertical
            allControlsVStack.distribution = .equalSpacing
            allControlsVStack.alignment = .fill
            allControlsVStack.spacing = 64
            allControlsVStack.backgroundColor = UIColor(named: "BackgroungColor")
            return allControlsVStack
        }()
        
        mainVStack = {
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
    }
}
