import SwiftUI
import TemperatureFeature
import WeatherClientLive

@main
struct DesigningDependencyApp: App {
    var body: some Scene {
        WindowGroup {
            TemperatureView(viewModel: TemperatureViewModel(weatherClient: .live))
        }
    }
}
