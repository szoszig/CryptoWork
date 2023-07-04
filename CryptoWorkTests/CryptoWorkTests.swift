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
    
    func testListMock() throws {
        let viewModel = CryptoListViewModel(apiManager: MockAPIManager())
        
        let statePublisher = viewModel.$viewState.collect(2).first()
        viewModel.fetchData()
        
        let stateArr = try awaitPublisher(statePublisher)
        XCTAssertEqual(stateArr.count, 2)
        XCTAssertEqual(stateArr.first, CryptoListViewModel.State.loading)
        switch stateArr.last {
        case .data(let items):
            XCTAssertEqual(items.count, 10)
            XCTAssertEqual(items, (1...10).map {_ in CryptoItem.dummy() })
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
    
    func testDetailMock() throws {
        let viewModel = CryptoDetailViewModel(apiManager: MockAPIManager())
        
        let statePublisher = viewModel.$viewState.collect(2).first()
        let itemToLoad = CryptoItem.dummy()
        viewModel.fetchData(
            data: itemToLoad
        )
        
        let stateArr = try awaitPublisher(statePublisher)
        XCTAssertEqual(stateArr.count, 2)
        XCTAssertEqual(stateArr.first, CryptoDetailViewModel.State.data(itemToLoad, true))
        switch stateArr.last {
        case .data(let item, let isLoading):
            XCTAssertFalse(isLoading)
            XCTAssertNotNil(item)
            if let item {
                XCTAssertEqual(item, itemToLoad)
            }
        default:
            break
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
