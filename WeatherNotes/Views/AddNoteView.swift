import SwiftUI

struct AddNoteView: View {
    @Binding var text: String
    @Binding var isPresented: Bool

    let onSave: (String) -> Void

    var body: some View {
        NavigationStack {
            VStack {
                TextEditor(text: $text)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.secondary.opacity(0.3))
                    )
                    .padding()

                Spacer()
            }
            .navigationTitle("Новая заметка")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Отмена") {
                        isPresented = false
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Сохранить") {
                        let trimmed = text.trimmingCharacters(in: .whitespacesAndNewlines)
                        guard !trimmed.isEmpty else { return }
                        onSave(trimmed)
                        text = ""
                        isPresented = false
                    }
                }
            }
        }
    }
}
