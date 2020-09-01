import SwiftUI
import WeatherClient

struct AppView: View {

    @ObservedObject var viewModel: AppViewModel

    var body: some View {
        VStack {
            Spacer()
            Text(viewModel.temperature ?? "")
                .font(.title)
            Button(
                action: { viewModel.computeTapped() },
                label: {
                    Text(viewModel.isLoading ? "Loading..." : "Tap me")
                        .bold()
                        .foregroundColor(.white)
                        .padding()
                        .contentShape(RoundedRectangle(cornerRadius: 20))
                        .background(Color.blue)
                        .clipShape(Capsule())
                }
            ).disabled(viewModel.isLoading)

            Spacer()
        }
        .padding()
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView(viewModel: AppViewModel(weatherClient: .cold))
    }
}
