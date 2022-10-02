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
            player?.volume = volume
        }
    }
    
    private var audioSession: AVAudioSession = AVAudioSession.sharedInstance()
    
    private var player: AVPlayer?
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
    
    private var isPlaying = false {
        didSet {
            print(isPlaying)
        }
    }
    
    private var seekFrame: AVAudioFramePosition = 0
    private var currentPosition: AVAudioFramePosition = 0
    private var audioLengthSamples: AVAudioFramePosition = 0
    
    private var displayLink: CADisplayLink?

    
    init() {
        do {
            try audioSession.setCategory(.playback, mode: .default, options: [])
            try audioSession.setActive(true)
        } catch {
            print("ERROR SETTING AUDIO SESSION")
        }
        
        setupDisplayLink()
    }
    
    func playOrPause() {
        if let aPlayer = player {
            DispatchQueue.main.async { [self] in
                if isPlaying {
                    aPlayer.pause()
                    isPlaying.toggle()
                } else {
                    aPlayer.play()
                    isPlaying.toggle()
                }
            }
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
            player?.play()
        }
    }
    
    // MARK: Audio adjustments
//    private func seek(to time: Double) {
//        guard let audioFile = audioFile else {
//            return
//        }
//
//        let offset = AVAudioFramePosition(time * audioSampleRate)
//        seekFrame = currentPosition + offset
//        seekFrame = max(seekFrame, 0)
//        seekFrame = min(seekFrame, audioLengthSamples)
//        currentPosition = seekFrame
//
//        let wasPlaying = player.isPlaying
//        player.stop()
//
//        if currentPosition < audioLengthSamples {
//            updateDisplay()
//            needsFileScheduled = false
//
//            let frameCount = AVAudioFrameCount(audioLengthSamples - seekFrame)
//            player.scheduleSegment(
//                audioFile,
//                startingFrame: seekFrame,
//                frameCount: frameCount,
//                at: nil
//            ) {
//                self.needsFileScheduled = true
//            }
//
//            if wasPlaying {
//                player.play()
//            }
//        }
//    }
    
    private func setupDisplayLink() {
//        displayLink = CADisplayLink(
//            target: self,
//            selector: #selector(updateDisplay))
//        displayLink?.add(to: .current, forMode: .default)
//        displayLink?.isPaused = true
    }
    
    @objc private func updateDisplay() {
//        currentPosition = currentFrame + seekFrame
//        currentPosition = max(currentPosition, 0)
//        currentPosition = min(currentPosition, audioLengthSamples)
//
//        if currentPosition >= audioLengthSamples {
//            player.stop()
//
//            seekFrame = 0
//            currentPosition = 0
//
//            isPlaying = false
//            displayLink?.isPaused = true
//
//            disconnectVolumeTap()
//        }
//
//        playerProgress = Double(currentPosition) / Double(audioLengthSamples)
//
//        let time = Double(currentPosition) / audioSampleRate
//        playerTime = PlayerTime(
//            elapsedTime: time,
//            remainingTime: audioLengthSeconds - time)
    }
}



// MARK: - TEMP CONFIGURATION METHODS
extension AudioManager {
    func setupPlayer() {
        let stringURLs = [
            "https://prod-1.storage.jamendo.com/?trackid=1886257&format=mp31&from=lfhKposUw1FEJDJ0GDwqyA%3D%3D%7CdNH%2F6n3wcji3rzz%2FhIq9Bg%3D%3D",
            "https://prod-1.storage.jamendo.com/?trackid=1684501&format=mp31&from=sJAeUjOyNWkcMY4vPsTVfw%3D%3D%7CGUftPe62gU6hMOnE%2Bm0sPQ%3D%3D",
            "https://prod-1.storage.jamendo.com/?trackid=1214935&format=mp31&from=f9%2FL4VRIsig5kQChSQ%2FCNg%3D%3D%7C5FLcnfFdtEkrT8ZpFPkPsQ%3D%3D",
            "https://prod-1.storage.jamendo.com/?trackid=1656722&format=mp31&from=s%2BJFREely86ApFB0YHxTjg%3D%3D%7C%2B0hi2Dtk%2BVIfSjXcXqhAGg%3D%3D",
            "https://prod-1.storage.jamendo.com/?trackid=849710&format=mp31&from=3X7Qyqh6QFabmCdYrUUziQ%3D%3D%7Cgxht0XIPRWtxUE06i%2FtvJw%3D%3D",
            "https://prod-1.storage.jamendo.com/?trackid=1884527&format=mp31&from=xNW%2B2ctn1xJIlWT%2FYf6UwQ%3D%3D%7CmFJvKqBX%2Bam3XRQF5Z5hvg%3D%3D",
            "https://prod-1.storage.jamendo.com/?trackid=1882761&format=mp31&from=mCXbttgurBLFc7K1IHdKpA%3D%3D%7CzeNoqM18DScrroD%2FEbVCMg%3D%3D",
            "https://prod-1.storage.jamendo.com/?trackid=1955723&format=mp31&from=qKFZdaLOoT4l81qF0vNVyw%3D%3D%7CX33uJuO7W7B6vNQCoE5VRA%3D%3D",
            "https://prod-1.storage.jamendo.com/?trackid=1141572&format=mp31&from=PsrNhJmDFD9OfIpx80uCTg%3D%3D%7C16ttaPmXnQa6c8fVU3YXaQ%3D%3D",
            "https://prod-1.storage.jamendo.com/?trackid=1204669&format=mp31&from=Bb%2FimpvtdUW64IOIyw9KiQ%3D%3D%7C5YWBaGxX58ldlleYnKTD%2Fw%3D%3D"
        ]
        
        let urls = stringURLs.compactMap() { URL(string: $0) }
        let assets = urls.map() { AVAsset(url: $0) }
        playerItems = assets.map() { AVPlayerItem(asset: $0) }
        currentItemIndex = 0
        
        if let playerItems = playerItems {
            player = AVPlayer(playerItem: playerItems[currentItemIndex])
            player?.play()
        }
    }
}
