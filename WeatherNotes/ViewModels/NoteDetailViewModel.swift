import Foundation
import Combine

final class NoteDetailViewModel: ObservableObject {
    let note: Note

    init(note: Note) {
        self.note = note
    }

    var title: String { note.text }
    var dateText: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy HH:mm"
        return formatter.string(from: note.createdAt)
    }

    var temperatureText: String {
        "\(Int(note.weather.temperature.rounded()))°C"
    }

    var descriptionText: String {
        note.weather.description.capitalized
    }

    var cityText: String {
        note.weather.cityName
    }

    var iconURL: URL? {
        // OpenWeather
        URL(string: "https://openweathermap.org/img/wn/\(note.weather.icon)@2x.png")
    }
}
