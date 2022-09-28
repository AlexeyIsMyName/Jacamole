import Foundation

struct AlbomAPIResult: Decodable {
    let results: [AlbomInfo]
}

struct AlbomInfo: Decodable {
    let id: String
    let name: String
    let artist_id: String
    let artist_name: String
    let image: String
    let tracks: [AlbomTrack]
}

struct AlbomTrack: Decodable {
    let id: String
    let position: String
    let name: String
    let duration: String
    let audio: String
    let audiodownload: String
    let audiodownload_allowed: Bool
}
