import SwiftUI

struct NotesListView: View {
    @StateObject var viewModel: NotesListViewModel
    @State private var showingAddSheet = false
    @State private var newNoteText: String = ""

    var body: some View {
        NavigationStack {
            ZStack {
                List {
                    ForEach(viewModel.notes) { note in
                        NavigationLink {
                            NoteDetailView(
                                viewModel: viewModel.noteDetailsViewModel(for: note)
                            )
                        } label: {
                            NoteRowView(note: note)
                        }
                    }
                }

                if viewModel.isLoading {
                    ProgressView()
                        .scaleEffect(1.2)
                }
            }
            .navigationTitle("WeatherNotes")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        showingAddSheet = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddSheet) {
                AddNoteView(
                    text: $newNoteText,
                    isPresented: $showingAddSheet,
                    onSave: { text in
                        Task { await viewModel.addNote(text: text) }
                    }
                )
            }
            .alert("Ошибка", isPresented: .constant(viewModel.errorMessage != nil)) {
                Button("OK", role: .cancel) { viewModel.errorMessage = nil }
            } message: {
                Text(viewModel.errorMessage ?? "")
            }
        }
    }
}

struct NoteRowView: View {
    let note: Note

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            VStack(alignment: .leading, spacing: 4) {
                Text(note.text)
                    .font(.headline)
                    .lineLimit(2)

                Text(dateText)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            Spacer()
            VStack(alignment: .trailing, spacing: 4) {
                Text("\(Int(note.weather.temperature.rounded()))°C")
                    .font(.headline)
                Text(note.weather.description.capitalized)
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
        }
    }

    private var dateText: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy HH:mm"
        return formatter.string(from: note.createdAt)
    }
}
