//
//  GiphyListTableViewCell.swift
//  GiphySearch
//
//  Created by gwangyonglee on 2020/01/11.
//  Copyright © 2020 gwangyonglee. All rights reserved.
//

import UIKit
import Kingfisher

struct GiphyListTableViewCellInfo {
	static let identifier = "GiphyListTableViewCell"
}

final class GiphyListTableViewCell: UITableViewCell {
	// MARK: - IBOutlet
	@IBOutlet weak var mainImageView: UIImageView!
	
	// MARK: - Property
	var imageURLString: String? {
		didSet {
			guard let imageURLString = imageURLString else { return }
			DispatchQueue.main.async {
				self.mainImageView.kf.setImage(with: URL(string: imageURLString))
			}
		}
	}
	
	// MARK: - Life Cycle
	override func awakeFromNib() {
		super.awakeFromNib()
		mainImageView.kf.indicatorType = .activity
	}
	
	override func prepareForReuse() {
		super.prepareForReuse()
		mainImageView.image = nil
	}
}
