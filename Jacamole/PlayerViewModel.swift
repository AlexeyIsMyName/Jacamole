//
//  PlayerViewModel.swift
//  Jacamole
//
//  Created by ALEKSEY SUSLOV on 07.10.2022.
//

import Foundation

protocol PlayerViewModelDelegate {
    func songDurationInSecondsUpdated()
}

class PlayerViewModel {
    var audioManager: AudioManager!
    var songs: [Song]!
    
    var delegate: PlayerViewModelDelegate!
    
    var songDurationInSeconds: Float! {
        didSet {
            delegate.songDurationInSecondsUpdated()
        }
    }
    
    var songDurationInString: String! {
        didSet {
            
        }
    }
    
    var posterImageURL: String! {
        didSet {
            
        }
    }
    
    var songTitle: String! {
        didSet {
            
        }
    }
    
    var artistTitle: String! {
        didSet {
            
        }
    }
    
    
    
    
}
