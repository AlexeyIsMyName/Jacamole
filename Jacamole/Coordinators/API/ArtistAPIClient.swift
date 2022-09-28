import Foundation

//https://api.jamendo.com/v3.0/artists/tracks/?client_id=676da3fb&id=463402
//где &id=463402 - идентификатор артиста

class ArtistAPIClient {
    private let networkManager = NetworkManager()
    
    func loadArtistSongs(artistID: String, complition: @escaping ([ArtistInfo]) -> Void) {
        let api = APIEndpoints.artist
        let params = [
            "id": artistID
        ]
        
        self.networkManager.request(apiEnpoint: api, params: params, for: ArtistAPIResult.self) { result in
            switch result {
            case .success(let artist):
                complition(artist.results)
            case .failure(let error):
                print("loadPopularMonthSongs: \(error)")
                complition([])
            }
        }
    }
}
