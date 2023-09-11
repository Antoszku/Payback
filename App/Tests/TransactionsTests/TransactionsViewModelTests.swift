import Combine
@testable import Transactions
import XCTest

final class TransactionsViewModelTests: XCTestCase {
    func test_loadTransactions_callInteractor() async {
        let interactor = TransactionsInteractorStub()
        let sut = makeSut(interactor: interactor)

        await sut.loadTransactions()

        XCTAssertTrue(interactor.getTransactionsCalled)
    }

    func test_loadTransactions_setStateToTransaction() async {
        let sut = makeSut()

        await sut.loadTransactions()

        guard case .transactions = sut.state else { XCTFail(); return }
    }

    func test_loadTransactions_setStateToTransaction_withCorrectTransactionData() async {
        let transaction = TransactionPresentable.build(id: "id",
                                                       bookingDate: Date(),
                                                       category: 1,
                                                       bookingDateDescription: "description",
                                                       partnerDisplayName: "partner",
                                                       transactionDetailDescription: "detailDestription",
                                                       amount: 999,
                                                       currency: "PLN")
        let interactor = TransactionsInteractorStub()
        let sut = makeSut(interactor: interactor)
        interactor.returnTransactions = [transaction]

        await sut.loadTransactions()
        guard case let .transactions(transactions) = sut.state else { XCTFail(); return }

        XCTAssertEqual(transactions.count, 1)
        XCTAssertEqual(transactions[0], transaction)
    }

    func test_loadTransactions_setStateToTransaction_withTransactionsSortedByNewestBookingDate() async {
        let transaction1 = TransactionPresentable.build(id: "1", bookingDate: Date())
        let transaction2 = TransactionPresentable.build(id: "2", bookingDate: Date(timeIntervalSinceNow: 10))
        let transaction3 = TransactionPresentable.build(id: "3", bookingDate: Date(timeIntervalSinceNow: -10))
        let transactions = [transaction1, transaction2, transaction3]
        let interactor = TransactionsInteractorStub()
        let sut = makeSut(interactor: interactor)
        interactor.returnTransactions = transactions

        await sut.loadTransactions()
        guard case let .transactions(transactions) = sut.state else { XCTFail(); return }

        XCTAssertEqual(transactions, [transaction2, transaction1, transaction3])
    }

    func test_loadTransactions_setStateToError() async {
        let interactor = TransactionsInteractorStub()
        let sut = makeSut(interactor: interactor)
        interactor.throwError = NSError(domain: "", code: 1)

        await sut.loadTransactions()

        guard case .error = sut.state else { XCTFail(); return }
    }

    func test_loadTransactions_setCategories() async {
        let interactor = TransactionsInteractorStub()
        let sut = makeSut(interactor: interactor)
        interactor.returnTransactions = [.build(category: 1), .build(category: 2)]

        await sut.loadTransactions()

        XCTAssertEqual(sut.categories, [1, 2])
    }

    func test_loadTransactions_setCategoriesRemoveDuplicates() async {
        let interactor = TransactionsInteractorStub()
        let sut = makeSut(interactor: interactor)
        interactor.returnTransactions = [.build(category: 1), .build(category: 1)]

        await sut.loadTransactions()

        XCTAssertEqual(sut.categories, [1])
    }

    func test_onFilterTap_selectFilter() {
        let sut = makeSut()

        sut.onFilterTap(1)

        XCTAssertEqual(sut.selectedFilter, 1)
    }

    func test_onFilterTapTwice_deselectFilter() {
        let sut = makeSut()

        sut.onFilterTap(1)
        sut.onFilterTap(1)

        XCTAssertEqual(sut.selectedFilter, nil)
    }

    func test_onFilterTap_setStateToTransactions_withFilteredTransactions() async {
        let transaction1 = TransactionPresentable.build(id: "1", category: 1)
        let transaction2 = TransactionPresentable.build(id: "2", category: 2)
        let interactor = TransactionsInteractorStub()
        let sut = makeSut(interactor: interactor)
        interactor.returnTransactions = [transaction1, transaction2]
        await sut.loadTransactions()

        sut.onFilterTap(1)

        guard case let .transactions(transactions) = sut.state else { XCTFail(); return }

        XCTAssertEqual(transactions, [transaction1])
    }

    func test_onFilterTapTwice_setStateToTransactions_withAllTransactions() async {
        let transaction1 = TransactionPresentable.build(id: "1", category: 1)
        let transaction2 = TransactionPresentable.build(id: "2", category: 2)
        let interactor = TransactionsInteractorStub()
        let sut = makeSut(interactor: interactor)
        interactor.returnTransactions = [transaction1, transaction2]
        await sut.loadTransactions()

        sut.onFilterTap(1)
        sut.onFilterTap(1)

        guard case let .transactions(transactions) = sut.state else { XCTFail(); return }

        XCTAssertEqual(transactions, [transaction2, transaction1])
    }

    func test_onFilterTap_setTotalAmount() async {
        let transaction1 = TransactionPresentable.build(id: "1", category: 1, amount: 100)
        let transaction2 = TransactionPresentable.build(id: "2", category: 1, amount: 200)
        let interactor = TransactionsInteractorStub()
        let sut = makeSut(interactor: interactor)
        interactor.returnTransactions = [transaction1, transaction2]
        await sut.loadTransactions()

        sut.onFilterTap(1)

        XCTAssertEqual(sut.totalAmount, 300)
    }

    func test_onFilterTapTwice_setTotalAmountToNil() async {
        let transaction1 = TransactionPresentable.build(id: "1", category: 1, amount: 100)
        let transaction2 = TransactionPresentable.build(id: "2", category: 1, amount: 200)
        let interactor = TransactionsInteractorStub()
        let sut = makeSut(interactor: interactor)
        interactor.returnTransactions = [transaction1, transaction2]
        await sut.loadTransactions()

        sut.onFilterTap(1)
        sut.onFilterTap(1)

        XCTAssertEqual(sut.totalAmount, nil)
    }

    func test_loadTransactions_setCorrectStates() async {
        let sut = makeSut()
        var states = [TransactionsViewModel.State]()
        var container = Set<AnyCancellable>()

        sut.$state.sink {
            states.append($0)
        }.store(in: &container)

        await sut.loadTransactions()

        XCTAssertEqual(states, [.loading, .loading, .transactions([])])
    }

    private func makeSut(interactor: TransactionsInteractor = TransactionsInteractorStub()) -> TransactionsViewModel {
        TransactionsViewModel(interactor: interactor)
    }
}
