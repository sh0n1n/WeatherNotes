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
