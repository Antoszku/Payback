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
                            Text("\(category)")
                                .padding(.horizontal)
                                .padding(.vertical, 4)
                                .overlay(RoundedRectangle(cornerRadius: 20).stroke(.gray, lineWidth: 1))
                                .onTapGesture { viewModel.onFilterTap(category) }
                        }
                    }
                }
            }.padding(.vertical, 16)
        }
    }
}
