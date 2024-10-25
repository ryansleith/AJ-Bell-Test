//
//  Market.swift
//  Interview
//
//  Created by Ryan Sleith on 21/10/2024.
//  Copyright © 2024 AJBell. All rights reserved.
//

import Foundation

class MarketsViewModel: ObservableObject {
    var markets: [Market] = []

	init() {
		fetchMarkets { result in
			switch result {
			case .success(let markets):
				self.markets = markets
			case .failure(let error):
				print("Error loading markets: \(error.localizedDescription)")
			}
		}
	}

	// Helper function made during development, unused but left because this could be useful
	func reloadMarkets(completion: @escaping () -> (Void)) {
		fetchMarkets { result in
			switch result {
			case .success(let markets):
				self.markets = markets
				completion()
			case .failure(let error):
				print("Error loading markets: \(error.localizedDescription)")
			}
		}
	}

	func fetchMarkets(completion: @escaping (Result<[Market], Error>) -> Void) {
		let url = "http://localhost:8080/api/general/money-am-quote-delayed?ticker=UKX,MCX,NMX,ASX,SMX,AIM1,IXIC,INDU,DEX."
		var request = URLRequest(url: URL(string: url)!)
		request.addValue("Mock", forHTTPHeaderField: "Client")

		let configuration = URLSessionConfiguration.default
		configuration.protocolClasses = [NetworkInterceptor.self]
		let defaultSession = URLSession(configuration: configuration)

		defaultSession.dataTask(with: request) { (data, response, error) in
			if let error = error {
				completion(.failure(error))
				return
			}

			guard let data = data else {
				completion(.failure(NSError(domain: "No Data", code: 0, userInfo: nil)))
				return
			}

			var resultMarkets = [Market]()
			if let result = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
			   let marketsData = result["data"] as? [[String: Any]] {
				marketsData.forEach {
					let market = Market(name: $0["CompanyName"] as! String,
										epic: $0["Epic"] as! String,
										price: $0["CurrentPrice"] as! String)
					resultMarkets.append(market)
				}
				completion(.success(resultMarkets))
			} else {
				completion(.failure(NSError(domain: "Data Parsing Error", code: 1, userInfo: nil)))
			}
		}.resume()
	}
}
