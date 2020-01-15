//
//  GiphySearchResponse.swift
//  GiphySearch
//
//  Created by gwangyonglee on 2020/01/11.
//  Copyright © 2020 gwangyonglee. All rights reserved.
//

struct GiphySearchResponse: Decodable {
	let data: [GiphyData]?
}

struct GiphyData: Decodable {
	let id: String?
	let url: String?
	let images: GiphyImages?
}

struct GiphyImages: Decodable {
	let image: GiphyImage?
	
	enum CodingKeys: String, CodingKey {
		case image = "downsized"
	}
}

struct GiphyImage: Decodable {
	let width: String?
	let height: String?
	let url: String?
}
