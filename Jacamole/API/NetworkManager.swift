import Foundation

enum APIEndpoints: String {
    case songs = "/v3.0//tracks"
    case artist = "/v3.0/artists/tracks"
    case alboms = "/v3.0/albums/tracks"
}

class SongsAPIConstructor {
    let baseUrl = "api.jamendo.com"
    let clientId = "676da3fb"
    
}

class NetworkManager {
    let apiConstructor = SongsAPIConstructor()
    private let session = URLSession(configuration: .default)
    
    func request<D: Decodable>(
        apiEnpoint: APIEndpoints,
        params: [String: String]? = nil,
        for dataModel: D.Type,
        completion: @escaping (Result<D, Error>) -> Void
    ) {
        var components = URLComponents()
        components.scheme = "https"
        components.host = apiConstructor.baseUrl
        components.path = apiEnpoint.rawValue
        
        if let params = params {
            components.queryItems = params.map { URLQueryItem(name: $0.key, value: $0.value) }
        }
    
        components.queryItems?.append(
            URLQueryItem(name: "client_id", value: apiConstructor.clientId)
        )
        
        let url = components.url!
//        print("___url: \(url)")
//        print("clientId: \(apiConstructor.clientId)")
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
              let model = parseJSON(data, to: D.self) else {
            completion(.failure(NSError(domain: "NetworkManager", code: 1)))
            return
        }
        
        DispatchQueue.main.async {
            completion(.success(model))
        }
    }
    
    func parseJSON<D: Decodable>(_ data: Data, to model: D.Type) -> D? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            return try decoder.decode(model, from: data)
        } catch {
            print("parse error: \(error)")
            return nil
        }
    }
}

