import Foundation

//https://api.jamendo.com/v3.0/tracks/?client_id=676da3fb&include=musicinfo+lyrics&order=popularity_month

//https://api.jamendo.com/v3.0/tracks/?client_id=676da3fb&include=musicinfo+lyrics&order=popularity_month&tags=rock

//https://api.jamendo.com/v3.0/artists?client_id=676da3fb&namesearch=adele

//https://api.jamendo.com/v3.0/tracks/?client_id=676da3fb&namesearch=adele

class SongsAPIClient {
    private let networkManager = NetworkManager()
    
    func loadPopularMonthSongs(tag: String, complition: @escaping ([Song]) -> Void) {
        let api = APIEndpoints.songs
        
        let params = [
            "include": "musicinfo+lyrics",
            "order": "popularity_month",
            "tags": tag
        ]
        
        networkManager.request(apiEnpoint: api, params: params, for: SongsAPIResult.self) { result in
            switch result {
            case .success(let songs):
                complition(songs.results)
            case .failure(let error):
                print("loadPopularMonthSongs: \(error)")
                complition([])
            }
        }
    }
}
