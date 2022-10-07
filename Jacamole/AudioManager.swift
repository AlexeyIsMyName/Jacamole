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
    
    var durationHandler: ((CMTime) -> Void)! {
        didSet {
            player.addPeriodicTimeObserver(forInterval: CMTime(value: 1, timescale: 1),
                                           queue: DispatchQueue.main,
                                           using: durationHandler)
        }
    }
    
    var newSongHandler: ((String, Float, Int) -> Void)! {
        didSet {
            providePlayerData()
        }
    }

    private var player: AVPlayer!
    private var playerItems: [AVPlayerItem]?
    
    var currentItemIndex = 0 {
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
    
    var isPlaying: Bool {
        player.timeControlStatus == .playing ? true : false
    }
    
    init() {
        let audioSession: AVAudioSession = AVAudioSession.sharedInstance()
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
            addSongAutoSwitcherObserver()
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
    
    @objc func forward() {
        currentItemIndex += 1
        replaceCurrentPlayerItem()
    }
    
    func seek(to time: Float) {
        let cmDate = CMTime(value: CMTimeValue(time), timescale: 1)
        player.seek(to: cmDate)
    }
    
    private func replaceCurrentPlayerItem() {
        if let playerItems = playerItems {
            player?.replaceCurrentItem(with: playerItems[currentItemIndex])
            player?.seek(to: .zero)
            player?.play()
            providePlayerData()
            addSongAutoSwitcherObserver()
        }
    }
    
    private func addSongAutoSwitcherObserver() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(forward),
                                               name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
                                               object: player.currentItem)
    }
    
    private func providePlayerData() {
        let songDuration = player.currentItem?.asset.duration.seconds ?? 0.0
        let minutes = floor(songDuration / 60)
        let seconds = floor(((songDuration / 60) - minutes) * 60) / 100
        let total = minutes + seconds
        
        newSongHandler(String(format: "%.2f", total), Float(songDuration), currentItemIndex)
    }
}
