import SwiftUI
import App

@main
struct WorldOfPAYBACKApp: App {
    let assembler = MainAssembler()
    var body: some Scene {
        WindowGroup {
            TabBarMainView(resolver: assembler.resolver)
        }
    }
}
