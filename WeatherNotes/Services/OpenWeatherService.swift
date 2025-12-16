import Foundation

protocol WeatherService {
    func fetchCurrentWeather() async throws -> WeatherInfo
}

enum WeatherServiceError: Error {
    case invalidURL
    case invalidResponse
}

final class OpenWeatherService: WeatherService {
    private let apiKey = "bca06c36f531cade2cc0285a836e6a87"
    private let city = "Bad Urach"

    func fetchCurrentWeather() async throws -> WeatherInfo {
        guard let url = URL(string:
            "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(apiKey)&units=metric&lang=ru"
        ) else {
            throw WeatherServiceError.invalidURL
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let http = response as? HTTPURLResponse,
              200..<300 ~= http.statusCode else {
            throw WeatherServiceError.invalidResponse
        }

        let decoded = try JSONDecoder().decode(OpenWeatherResponse.self, from: data)

        guard let item = decoded.weather.first else {
            throw WeatherServiceError.invalidResponse
        }

        return WeatherInfo(
            temperature: decoded.main.temp,
            description: item.description,
            icon: item.icon,
            cityName: decoded.name
        )
    }
}
