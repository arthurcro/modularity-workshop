import SwiftUI
import WeatherClient

public struct TemperatureView: View {

    @ObservedObject var viewModel: TemperatureViewModel

    public var body: some View {
        VStack {
            Spacer()
            Text(viewModel.temperature ?? "")
                .font(.title)
            Button(
                action: { viewModel.weatherTapped() },
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

    public init(
        viewModel: TemperatureViewModel
    ) {
        self.viewModel = viewModel
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        TemperatureView(viewModel: TemperatureViewModel(weatherClient: .cold))
    }
}
