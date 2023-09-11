import Resolver
import SwiftUI
import Transactions

public struct TabBarMainView: View {
    @State var path = NavigationPath()

    private let transactionsViewFactory: TransactionsViewFactory

    public init(resolver: Resolver) {
        transactionsViewFactory = TransactionsViewFactory(resolver: resolver)
    }

    public var body: some View {
//        TabView {
            NavigationStack(path: $path) { transactionsViewFactory.rootView }.tabItem { Label("Transactions", systemImage: "bag") }

//            VStack {}.tabItem { Label("Feed", systemImage: "list.dash") }
//
//            VStack {}.tabItem { Label("Shopping", systemImage: "cart") }
//
//            VStack {}.tabItem { Label("Settings", systemImage: "gear") }
//        }
    }
}
