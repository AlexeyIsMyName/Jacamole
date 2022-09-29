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
    let albumId: String
    let albumName: String
    let id: String
    let name: String
    let duration: String
    let albumImage: String
    let image: String
    let audio: String
    let audiodownload: String
    let audiodownloadAllowed: Bool
}
