import Foundation

struct ArtistAPIResult: Decodable {
    let results: [ArtistInfo]
}

struct ArtistInfo: Decodable {
    let id: String
    let name: String
    let image: String
    let tracks: [Track]
}

struct Track: Decodable {
    let album_id: String
    let album_name: String
    let id: String
    let name: String
    let duration: String
    let album_image: String
    let image: String
    let audio: String
    let audiodownload: String
    let audiodownload_allowed: Bool
}
