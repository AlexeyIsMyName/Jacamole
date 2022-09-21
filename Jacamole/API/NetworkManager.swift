import UIKit

class SongsAPIConstructor {
    
    private let baseUrl = "https://api.jamendo.com/v3.0/"
    private let clientId = "676da3fb"
    
    // api example: https://api.jamendo.com/v3.0/tracks/?client_id=676da3fb&format=json&limit=10&include=musicinfo+lyrics&groupby=artist_id
    // this returns random list of ten tracks, /tracks/ - is a changable thing
    // to get specific album must be changed to /albums/ ...
    
    func makeURL() -> URL? {
        let urlString = "\(self.baseUrl)/tracks/?client_id=\(self.clientId)"
        return URL(string: urlString)
    }
}

class NetworkManager {
    let apiConstructor = SongsAPIConstructor()
    private let session = URLSession(configuration: .default)
    
    func request<D: Decodable>(
        for dataModel: D.Type,
        completion: @escaping (Result<D, Error>) -> Void
    ) {
        guard let url = self.apiConstructor.makeURL() else { return }
        self.request(for: url, for: dataModel, completion: completion)
    }
    
    func request<D: Decodable>(
        for url: URL,
        for dataModel: D.Type,
        completion: @escaping (Result<D, Error>) -> Void
    ) {
        self.session.dataTask(with: url) {
            [weak self] (data, _, error) in
            guard let self = self else { return }
            self.handleResponse(with: data, error: error, completion: completion)
        }.resume()
    }
}

private extension NetworkManager {
    
    func handleResponse<D: Decodable>(with data: Data?, error: Error?, completion: @escaping  (Result<D, Error>) -> Void) {
        if let error = error {
            completion(.failure(error))
            return
        }
       
        guard let data = data,
              let model = self.parseJSON(data, to: D.self) else {
            completion(.failure(NSError(domain: "NetworkManager", code: 1)))
            return
        }
        
        DispatchQueue.main.async {
            completion(.success(model))
        }
    }
    
    func parseJSON<D: Decodable>(_ data: Data, to model: D.Type) -> D? {
        let decoder = JSONDecoder()
        do {
            return try decoder.decode(model, from: data)
        } catch {
            print("parse error: \(error)")
            return nil
        }
    }
}
