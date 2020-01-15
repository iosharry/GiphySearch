//
//  GiphyService.swift
//  GiphySearch
//
//  Created by gwangyonglee on 2020/01/11.
//  Copyright © 2020 gwangyonglee. All rights reserved.
//

import Alamofire

final class GiphyService {
	static let shared = GiphyService()
	static let appKey = "Uvt5xFC2IMPIf9bjlxxYtfXpPiXfPhgo"

	func search(q: String, limit: Int, offset: Int, rating: String, completion: @escaping (Swift.Result<GiphySearchResponse,Error>) -> Void ) {
		let url =  "https://api.giphy.com/v1/gifs/search"
		
		let parameters: Parameters = [
			"api_key" : GiphyService.appKey,
			"q": q,
			"limit": "\(limit)",
			"offset": "\(offset)",
			"rating" : "\(rating)"
		]
		Alamofire.request(url, method: .get, parameters: parameters).responseData { (response) in
			guard let responseData = response.data else { return }
			do {
				let result = try JSONDecoder().decode(GiphySearchResponse.self, from: responseData)
				completion(.success(result))
			} catch {
				completion(.failure(error))
			}
		}
	}
}

