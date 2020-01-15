//
//  FavoriteButton.swift
//  GiphySearch
//
//  Created by gwangyonglee on 2020/01/12.
//  Copyright © 2020 gwangyonglee. All rights reserved.
//

import UIKit

protocol FavoriteButtonProtocol {
	var isFavorite: Bool { get }
}

final class FavoriteButton: UIButton {
	// MARK: - Property
	var id: String?
	
	// MARK: - Life Cycle
	override func draw(_ rect: CGRect) {
		self.isSelected = isFavorite
	}
}

extension FavoriteButton: FavoriteButtonProtocol {
	var isFavorite: Bool {
		guard let id = id,
			let favoriteEntity = CoreDataManager.shared.fetch() as? [FavoriteGiphyData] else { return false }
		for favorite in favoriteEntity where favorite.id == id {
			return true
		}
		return false
	}
}
