import Foundation

//Модель подходит как для запроса популярных песен, так и для запроса популярных песен по жанрам. Для получения списка самых поплуярных указываем teg=""

struct SongsAPIResult: Decodable {
    let results: [Song]
    let headers: Headers
}

struct Song: Decodable {
    let id: String
    let name: String
    let duration: Int
    let artist_id: String
    let artist_name: String
    let album_name: String
    let album_id: String
    let position: Int
    let audio: String
    let audiodownload: String
    let image: String
    let musicinfo: Musicinfo
}

struct Headers: Decodable {
    let next: String
}

struct Musicinfo: Decodable {
    let tags: Tags
}

struct Tags: Decodable {
    let genres: [String]
}
