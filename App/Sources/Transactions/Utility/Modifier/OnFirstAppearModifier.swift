import SwiftUI
struct OnFirstAppearModifier: ViewModifier {
    let perform: () -> Void
    @State private var firstTime = true

    func body(content: Content) -> some View {
        content.onAppear {
            if firstTime {
                firstTime = false
                self.perform()
            }
        }
    }
}

extension View {
    func onFirstAppear(perform: @escaping () -> Void) -> some View {
        return modifier(OnFirstAppearModifier(perform: perform))
    }
}
