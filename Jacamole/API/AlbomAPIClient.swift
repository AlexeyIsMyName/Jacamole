import Foundation

//https://api.jamendo.com/v3.0/albums/tracks/?client_id=676da3fb&id=144705
//где [&id=144705] - идентификатор альбома

class AlbomAPIClient {
    private let networkManager = NetworkManager()
    
    func loadAlbomSongs(albomID: String, complition: @escaping ([AlbomInfo]) -> Void) {
        let api = APIEndpoints.alboms
        let params = [
            "id": albomID
        ]
        
        networkManager.request(apiEnpoint: api, params: params, for: AlbomAPIResult.self) { result in
            switch result {
            case .success(let alboms):
                complition(alboms.results)
            case .failure(let error):
                print("loadPopularMonthSongs: \(error)")
                complition([])
            }
        }
    }
}
