//
//  GiphyFavoriteListViewController.swift
//  GiphySearch
//
//  Created by gwangyonglee on 2020/01/11.
//  Copyright © 2020 gwangyonglee. All rights reserved.
//

import UIKit

final class GiphyFavoriteListViewController: UIViewController {
	// MARK: - IBOutlet
	@IBOutlet weak var tableView: UITableView!
	
	// MARK: - Property
	var favoriteGiphy: [FavoriteGiphyData]? {
		didSet {
			DispatchQueue.main.async {
				self.tableView.reloadData()
			}
		}
	}
	
	// MARK: - Life Cycle
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		getCoreData()
	}
	
	// MARK: - Segue
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "showDetail" {
			guard let viewController = segue.destination as? GiphyDetailViewController,
				let index = sender as? Int,
				let favoriteGiphy = favoriteGiphy?[index] else { return }
            let giphyModel = GiphyModel(id: favoriteGiphy.id,
                                        url: favoriteGiphy.url,
                                        width: favoriteGiphy.width,
                                        height: favoriteGiphy.height)
            viewController.giphyModel = giphyModel
		}
	}
	
	private func getCoreData() {
		guard let favoriteEntity = CoreDataManager.shared.fetch() as? [FavoriteGiphyData] else { return }
		favoriteGiphy = favoriteEntity
	}
}

extension GiphyFavoriteListViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return favoriteGiphy?.count ?? 0
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: GiphyListTableViewCellInfo.identifier, for: indexPath) as? GiphyListTableViewCell else { return UITableViewCell() }
		guard let imageURLString = favoriteGiphy?[indexPath.row].url else { return UITableViewCell() }
		cell.imageURLString = imageURLString
		
		return cell
	}
}

extension GiphyFavoriteListViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		guard let height = favoriteGiphy?[indexPath.row].height?.CGFloatValue() else { return .zero }
		return height
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		self.performSegue(withIdentifier: "showDetail", sender: indexPath.row)
	}
}

