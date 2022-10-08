import Foundation

//https://api.jamendo.com/v3.0/tracks/?client_id=676da3fb&include=musicinfo+lyrics&order=popularity_month

//https://api.jamendo.com/v3.0/tracks/?client_id=676da3fb&include=musicinfo+lyrics&order=popularity_month&tags=rock

//https://api.jamendo.com/v3.0/artists?client_id=676da3fb&namesearch=adele

//https://api.jamendo.com/v3.0/tracks/?client_id=676da3fb&namesearch=adele

//https://api.jamendo.com/v3.0/tracks?client_id=676da3fb&include=musicinfo+lyrics&order=popularity_month&offset=30

class SongsAPIClient {
    private let networkManager = NetworkManager()
    private var nextURL: URL?
    
    func loadPopularMonthSongs(tag: String, complition: @escaping ([Song]) -> Void) {
        let api = APIEndpoints.songs
        
        let params = [
            "include": "musicinfo+lyrics",
            "order": "popularity_month",
            "tags": tag
        ]
        
        networkManager.request(apiEnpoint: api, params: params, for: SongsAPIResult.self) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let songs):
                    self.nextURL = URL(string: songs.headers.next)
                    complition(songs.results)
                case .failure(let error):
                    print("loadPopularMonthSongs: \(error)")
                    complition([])
                }
            }
        }
    }
    
    func searchSongs(query: String, complition: @escaping ([Song]) -> Void) {
        let api = APIEndpoints.songs
        
        let params = [
            "namesearch": query
        ]
        
        networkManager.request(apiEnpoint: api, params: params, for: SongsAPIResult.self) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let songs):
                    complition(songs.results)
                case .failure(let error):
                    print("loadSearchSongs: \(error)")
                    complition([])
                }
            }
        }
    }
    
    func loadNextTenSongs(complition: @escaping ([Song]) -> Void) {
        guard let url = self.nextURL else {
            return
        }
        
        networkManager.request(for: url, for: SongsAPIResult.self) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let songs):
                    self.nextURL = URL(string: songs.headers.next)
                    print("___self.nextURL: \(self.nextURL)")
                    complition(songs.results)
                case .failure(let error):
                    print("loadSearchSongs: \(error)")
                    complition([])
                }
            }
        }
    }
}
