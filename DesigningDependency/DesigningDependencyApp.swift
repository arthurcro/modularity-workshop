import SwiftUI
import WeatherClient

@main
struct DesigningDependencyApp: App {
    var body: some Scene {
        WindowGroup {
            AppView(viewModel: AppViewModel(weatherClient: .live))
        }
    }
}
