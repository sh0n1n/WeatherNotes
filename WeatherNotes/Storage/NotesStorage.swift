import Foundation

protocol NotesStoring {
    func loadNotes() -> [Note]
    func saveNotes(_ notes: [Note])
}

final class NotesStorage: NotesStoring {
    private let key = "weather_notes_storage"

    func loadNotes() -> [Note] {
        guard let data = UserDefaults.standard.data(forKey: key) else { return [] }
        do {
            return try JSONDecoder().decode([Note].self, from: data)
        } catch {
            print("Failed to decode notes:", error)
            return []
        }
    }

    func saveNotes(_ notes: [Note]) {
        do {
            let data = try JSONEncoder().encode(notes)
            UserDefaults.standard.set(data, forKey: key)
        } catch {
            print("Failed to encode notes:", error)
        }
    }
}
