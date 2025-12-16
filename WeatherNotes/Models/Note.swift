import Foundation

struct Note: Identifiable, Codable, Equatable {
    let id: UUID
    let text: String
    let createdAt: Date
    let weather: WeatherInfo
}

struct WeatherInfo: Codable, Equatable {
    let temperature: Double
    let description: String
    let icon: String
    let cityName: String
}

struct OpenWeatherResponse: Decodable {
    let name: String
    let weather: [WeatherItem]
    let main: MainInfo
}

struct WeatherItem: Decodable {
    let description: String
    let icon: String
}

struct MainInfo: Decodable {
    let temp: Double
}
