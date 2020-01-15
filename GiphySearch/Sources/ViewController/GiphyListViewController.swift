//
//  GiphyListViewController.swift
//  GiphySearch
//
//  Created by gwangyonglee on 2020/01/11.
//  Copyright © 2020 gwangyonglee. All rights reserved.
//

import UIKit

final class GiphyListViewController: UIViewController {
	// MARK: - IBOutlet
	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var searchBar: UISearchBar!
	
	// MARK: - Property
	private var giphySearchResponse: GiphySearchResponse? {
		didSet {
			DispatchQueue.main.async {
				self.tableView.reloadData()
				self.tableView.contentOffset = .zero
			}
		}
	}

	// MARK: - Life Cycle
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	// MARK: - Segue
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "showDetail" {
			guard let viewController = segue.destination as? GiphyDetailViewController,
				let index = sender as? Int,
				let giphyData = giphySearchResponse?.data?[index] else { return }
            let giphyModel = GiphyModel(id: giphyData.id,
                                        url: giphyData.images?.image?.url,
                                        width: giphyData.images?.image?.width,
                                        height: giphyData.images?.image?.height)
            viewController.giphyModel = giphyModel
		}
	}
}

// MARK: - UITableViewDataSource
extension GiphyListViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return giphySearchResponse?.data?.count ?? 0
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: GiphyListTableViewCellInfo.identifier, for: indexPath) as? GiphyListTableViewCell else { return UITableViewCell() }
		guard let imageURLString = giphySearchResponse?.data?[indexPath.row].images?.image?.url else { return UITableViewCell() }
		cell.imageURLString = imageURLString

		return cell
	}
}

// MARK: - UITableViewDelegate
extension GiphyListViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		guard let giphyData = giphySearchResponse?.data?[indexPath.row],
			let height = giphyData.images?.image?.height?.CGFloatValue() else { return .zero }
		return height
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		self.performSegue(withIdentifier: "showDetail", sender: indexPath.row)
	}
}

// MARK: -
extension GiphyListViewController: UISearchBarDelegate {
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		if let text = searchBar.text {
			self.search(keyword: text)
		}
		searchBar.resignFirstResponder()
	}
	
	private func search(keyword: String) {
		GiphyService.shared.search(q: keyword, limit: 25, offset: 0, rating: "g") { (response) in
			switch response {
			case .success(let data):
				self.giphySearchResponse = data
			case .failure(let error):
				let alertController = UIAlertController(title: "네트워크 요청 실패", message: "\(error.localizedDescription)", preferredStyle: .alert)
				let alertAction = UIAlertAction(title: "확인", style: .cancel)
				alertController.addAction(alertAction)
				self.present(alertController, animated: true, completion: nil)
			}
		}
	}
}
