import SwiftUI

@main
struct DesigningDependencyApp: App {
    var body: some Scene {
        WindowGroup {
            AppView(viewModel: AppViewModel())
        }
    }
}
