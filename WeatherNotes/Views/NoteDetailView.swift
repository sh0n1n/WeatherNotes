import SwiftUI
import Combine

struct NoteDetailView: View {
    @ObservedObject var viewModel: NoteDetailViewModel

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {

                Text(viewModel.title)
                    .font(.title2)
                    .bold()

                Text(viewModel.dateText)
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                Divider()

                HStack(spacing: 16) {
                    if let url = viewModel.iconURL {
                        AsyncImage(url: url) { phase in
                            switch phase {
                            case .success(let image):
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 80, height: 80)
                            case .failure(_):
                                Image(systemName: "cloud")
                                    .font(.largeTitle)
                            case .empty:
                                ProgressView()
                            @unknown default:
                                EmptyView()
                            }
                        }
                    } else {
                        Image(systemName: "cloud")
                            .font(.largeTitle)
                    }

                    VStack(alignment: .leading, spacing: 8) {
                        Text(viewModel.temperatureText)
                            .font(.largeTitle)
                        Text(viewModel.descriptionText)
                            .font(.headline)
                        Text(viewModel.cityText)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }

                Spacer()
            }
            .padding()
        }
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}
