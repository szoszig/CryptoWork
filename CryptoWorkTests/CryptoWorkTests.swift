//
//  CryptoWorkTests.swift
//  CryptoWorkTests
//
//  Created by Gergely Szoke on 2023. 07. 04..
//

import XCTest
import Combine
@testable import CryptoWork

final class CryptoWorkTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testList() throws {
        let viewModel = CryptoListViewModel()
        
        let statePublisher = viewModel.$viewState.collect(2).first()
        viewModel.fetchData()
        
        let stateArr = try awaitPublisher(statePublisher)
        XCTAssertEqual(stateArr.count, 2)
        XCTAssertEqual(stateArr.first, CryptoListViewModel.State.loading)
        switch stateArr.last {
        case .data(let items):
            XCTAssertEqual(items.count, 10)
        default:
            break
        }
    }
    
    func testDetail() throws {
        let viewModel = CryptoDetailViewModel()
        
        let statePublisher = viewModel.$viewState.collect(2).first()
        let itemToLoad = CryptoItem.dummy()
        viewModel.fetchData(
            data: itemToLoad
        )
        
        let stateArr = try awaitPublisher(statePublisher)
        XCTAssertEqual(stateArr.count, 2)
        XCTAssertEqual(stateArr.first, CryptoDetailViewModel.State.data(itemToLoad, true))
    }
    
    func testFalseDetail() throws {
        let viewModel = CryptoDetailViewModel()
        
        let statePublisher = viewModel.$viewState.collect(2).first()
        let itemToLoad = CryptoItem.dummy(id: "-12")
        viewModel.fetchData(
            data: itemToLoad
        )
        
        let stateArr = try awaitPublisher(statePublisher)
        XCTAssertEqual(stateArr.count, 2)
        XCTAssertEqual(stateArr.first, CryptoDetailViewModel.State.data(itemToLoad, true))
        XCTAssertEqual(stateArr.last, CryptoDetailViewModel.State.error(.mappingError))
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

extension CryptoItem {
    static func dummy(id: String = "BTC") -> CryptoItem {
        CryptoItem(
            id: id,
            name: "BTC",
            symbol: "BTC",
            priceUsd: 100.0,
            change: 0.5,
            marketCap: 1000.0,
            volume: 1000.0,
            supply: 1000.0,
            changeType: .down
        )
    }
}

extension CryptoSingleData {
    static var dummy: CryptoSingleData {
        CryptoSingleData(data: CryptoItemData.dummy())
    }
}

extension CryptoItemData {
    static func dummy(rank: Int = 1) -> CryptoItemData {
        CryptoItemData(
            id: "BTC",
            rank: "\(rank)",
            symbol: "BTC",
            name: "BTC",
            supply: "1000",
            maxSupply: nil,
            marketCapUsd: nil,
            volumeUsd24Hr: nil,
            priceUsd: "2",
            changePercent24Hr: nil,
            vwap24Hr: nil,
            explorer: nil
        )
    }
}

extension CryptoListData {
    static var dummy: CryptoListData {
        CryptoListData(data: (1...10).map { CryptoItemData.dummy(rank: $0) })
    }
}

class MockAPIManager: IAPIManager {
    func fetchList() -> AnyPublisher<CryptoWork.CryptoListData, CryptoWork.CryptoWorkError> {
        return Just(CryptoListData.dummy)
            .setFailureType(to: CryptoWorkError.self)
            .eraseToAnyPublisher()
    }
    
    func fetchItem(id: String) -> AnyPublisher<CryptoWork.CryptoSingleData, CryptoWork.CryptoWorkError> {
        return Just(CryptoSingleData.dummy)
            .setFailureType(to: CryptoWorkError.self)
            .eraseToAnyPublisher()
    }
    
    
}

extension XCTestCase {
    func awaitPublisher<T: Publisher>(
        _ publisher: T,
        timeout: TimeInterval = 10,
        file: StaticString = #file,
        line: UInt = #line
    ) throws -> T.Output {
        var result: Result<T.Output, Error>?
        let expectation = self.expectation(description: "Awaiting publisher")

        let cancellable = publisher.sink(
            receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    result = .failure(error)
                case .finished:
                    break
                }

                expectation.fulfill()
            },
            receiveValue: { value in
                result = .success(value)
            }
        )
        waitForExpectations(timeout: timeout)
        cancellable.cancel()

        let unwrappedResult = try XCTUnwrap(
            result,
            "Awaited publisher did not produce any output",
            file: file,
            line: line
        )

        return try unwrappedResult.get()
    }
}
