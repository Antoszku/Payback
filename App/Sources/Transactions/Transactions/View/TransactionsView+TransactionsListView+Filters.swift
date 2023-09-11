import SwiftUI

extension TransactionsView.TransactionsListView {
    struct Filters: View {
        @EnvironmentObject var viewModel: TransactionsViewModel

        var body: some View {
            HStack {
                Text("Filters:").padding(.leading)
                ScrollView(.horizontal) {
                    HStack(spacing: 8) {
                        ForEach(viewModel.categories, id: \.self) { category in
                            Button("\(category)") { viewModel.onFilterTap(category) }
                            .tint(viewModel.selectedFilter == category ? .blue : .gray)
                            .controlSize(.regular)
                            .buttonStyle(.bordered)
                        }
                    }
                }
            }.padding(.vertical, 16)
        }
    }
}
