import Foundation
import Combine

@MainActor
final class NotesListViewModel: ObservableObject {
    @Published private(set) var notes: [Note] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private let notesStorage: NotesStoring
    private let weatherService: WeatherService

    init(notesStorage: NotesStoring, weatherService: WeatherService) {
        self.notesStorage = notesStorage
        self.weatherService = weatherService
        loadNotes()
    }

    func loadNotes() {
        notes = notesStorage.loadNotes().sorted { $0.createdAt > $1.createdAt }
    }

    func addNote(text: String) async {
        guard !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }

        isLoading = true
        errorMessage = nil

        do {
            let weather = try await weatherService.fetchCurrentWeather()
            let note = Note(
                id: UUID(),
                text: text,
                createdAt: Date(),
                weather: weather
            )
            notes.insert(note, at: 0)
            notesStorage.saveNotes(notes)
        } catch {
            errorMessage = "Couldn't find the weather. Try again"
        }

        isLoading = false
    }

    func noteDetailsViewModel(for note: Note) -> NoteDetailViewModel {
        NoteDetailViewModel(note: note)
    }
}
