//
//  GiphyDetailViewController.swift
//  GiphySearch
//
//  Created by gwangyonglee on 2020/01/12.
//  Copyright © 2020 gwangyonglee. All rights reserved.
//

import UIKit

final class GiphyDetailViewController: UIViewController {
	// MARK: - IBOutlet
	@IBOutlet weak var mainImageView: UIImageView!
	@IBOutlet weak var mainImageViewWidthConstraint: NSLayoutConstraint!
	@IBOutlet weak var mainImageViewHeightConstraint: NSLayoutConstraint!
	@IBOutlet weak var favoriteButton: FavoriteButton!
	
	// MARK - Stored Property
    var giphyModel: GiphyModel?
	
	// MARK: - Life Cycle
	override func viewDidLoad() {
        super.viewDidLoad()
		updateViews()
    }
	
	private func updateViews() {
        favoriteButton.id = giphyModel?.id
        
		// Set Image
		if let url = giphyModel?.url {
			mainImageView.kf.setImage(with: URL(string: url))
		}
		// Image Size Update
        if let width = giphyModel?.width?.CGFloatValue(), let height = giphyModel?.height?.CGFloatValue() {
			mainImageViewWidthConstraint.constant = width
			mainImageViewHeightConstraint.constant = height
		}
	}
	
	// MARK: - IBAction
	@IBAction func touchUpInsideFavorite(_ sender: UIButton) {
		switch !sender.isSelected {
		case true:
            guard let giphyModel = giphyModel else { return }
            CoreDataManager.shared.save(giphyModel) { (isSuccess) in
				sender.isSelected = isSuccess
			}
		case false:
            guard let id = giphyModel?.id else { return }
			CoreDataManager.shared.delete(id: id) { (isSuccess) in
				sender.isSelected = !isSuccess
			}
		}
	}
	
	@IBAction func touchUpInsideClose(_ sender: UIButton) {
		self.dismiss(animated: true, completion: nil)
	}
}
