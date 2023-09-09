import SwiftUI
import Transactions

public struct TabBarMainView: View {
    @State var path = NavigationPath()

    let coordinator = TransactionsCoordinator()
    
    public init() { }

    public var body: some View {
        TabView {

            NavigationStack(path: $path) {
                coordinator.mainView
            }.tabItem { Label("Transactions", systemImage: "bag") }

            VStack { }.tabItem { Label("Feed", systemImage: "list.dash") }

            VStack { }.tabItem { Label("Shopping", systemImage: "cart") }

            VStack { }.tabItem { Label("Settings", systemImage: "gear") }
        }
    }
}
