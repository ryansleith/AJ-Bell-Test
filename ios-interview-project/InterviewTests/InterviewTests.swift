//
//  InterviewTests.swift
//  InterviewTests
//
//  Created by Tiago on 04/04/2019.
//  Copyright © 2019 AJBell. All rights reserved.
//

import XCTest
@testable import Interview

class InterviewTests: XCTestCase {

	var viewModel: MarketsViewModel!

	override func setUp() {
		super.setUp()
		viewModel = MarketsViewModel()
	}

	override func tearDown() {
		viewModel = nil
		super.tearDown()
	}

	// Test successful reload with completion of the fetch is equal to total markets in json
	func testReloadMarkets() {
		viewModel.reloadMarkets {
			XCTAssertEqual(self.viewModel.markets.count, 9)
		}
	}

	// Test successful fetch asserted compared to the first hardcoded stock
	func testFetchMarkets() {
		viewModel.fetchMarkets { result in
			switch result {
			case .success(let markets):
				XCTAssertEqual(markets.count, 9)
				XCTAssertEqual(markets[0].name, "FTSE 100")
				XCTAssertEqual(markets[0].epic, "FTSE:UKX")
				XCTAssertEqual(markets[0].price, "7194.5")
			case .failure:
				XCTFail("Expected success, got failure")
			}
		}
	}
}
