//
//  AudioManager.swift
//  Jacamole
//
//  Created by ALEKSEY SUSLOV on 02.10.2022.
//

import Foundation
import AVFoundation

class AudioManager {
    
    var volume: Float = 0.5 {
        didSet {
            player.volume = volume
        }
    }
    
    var currentItem: AVPlayerItem! {
        player.currentItem
    }
    
    var durationHandler: ((CMTime) -> Void)! {
        didSet {
            player.addPeriodicTimeObserver(forInterval: CMTime(value: 1, timescale: 1),
                                           queue: DispatchQueue.main,
                                           using: durationHandler)
        }
    }
    
    var newSongHandler: ((Double, Int) -> Void)! {
        didSet {
            provideDuration()
        }
    }
    
    private var audioSession: AVAudioSession = AVAudioSession.sharedInstance()
    
    private var player: AVPlayer!
    private var playerItems: [AVPlayerItem]?
    
    private var currentItemIndex = 0 {
        didSet {
            guard let itemsCount = playerItems?.count else {
                return
            }

            if currentItemIndex >= itemsCount {
                currentItemIndex = 0
            } else if currentItemIndex < 0 {
                currentItemIndex = itemsCount - 1
            }
        }
    }
    
    private var isPlaying: Bool {
        player.timeControlStatus == .playing ? true : false
    }
    
    init() {
        do {
            try audioSession.setCategory(.playback, mode: .default, options: [])
            try audioSession.setActive(true)
        } catch {
            print("ERROR SETTING AUDIO SESSION")
        }

    }
    
    func setupPlayer(with songs: [Song], startFrom songNumber: Int) {
        let urls = songs.compactMap() { URL(string: $0.audio) }
        let assets = urls.map() { AVAsset(url: $0) }
        playerItems = assets.map() { AVPlayerItem(asset: $0) }
        currentItemIndex = songNumber
        
        if let playerItems = playerItems {
            player = AVPlayer(playerItem: playerItems[currentItemIndex])
            player?.volume = volume
            playOrPause()
        }
    }
    
    func playOrPause() {
        if player?.timeControlStatus == .playing {
            player?.pause()
        } else {
            player?.play()
        }
    }
    
    func backward() {
        currentItemIndex -= 1
        replaceCurrentPlayerItem()
    }
    
    func forward() {
        currentItemIndex += 1
        replaceCurrentPlayerItem()
    }
    
    private func replaceCurrentPlayerItem() {
        if let playerItems = playerItems {
            player?.replaceCurrentItem(with: playerItems[currentItemIndex])
            player?.seek(to: .zero)
            player?.play()
            provideDuration()
            
            NotificationCenter.default.addObserver(self,
                                                   selector: #selector(playerDidFinishPlaying),
                                                   name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
                                                   object: player.currentItem)
        }
    }
    
    private func provideDuration() {
        let songDuration = currentItem.asset.duration.seconds
        let minutes = floor(songDuration / 60)
        let seconds = floor(((songDuration / 60) - minutes) * 100) / 100
        newSongHandler(minutes + seconds, currentItemIndex)
    }
    
    func seek(to time: Float) {
        let cmDate = CMTime(value: CMTimeValue(time), timescale: 1)
        player.seek(to: cmDate)
    }
    
    @objc private func playerDidFinishPlaying(note: NSNotification) {
        forward()
    }
}
