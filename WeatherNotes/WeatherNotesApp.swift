import SwiftUI

@main
struct WeatherNotesApp: App {
    var body: some Scene {
        WindowGroup {
            NotesListView(
                viewModel: NotesListViewModel(
                    notesStorage: NotesStorage(),
                    weatherService: OpenWeatherService()
                )
            )
        }
    }
}
