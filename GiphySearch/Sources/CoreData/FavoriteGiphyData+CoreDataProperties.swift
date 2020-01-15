//
//  FavoriteGiphyData+CoreDataProperties.swift
//  GiphySearch
//
//  Created by gwangyonglee on 2020/01/12.
//  Copyright © 2020 gwangyonglee. All rights reserved.
//
//

import Foundation
import CoreData

extension FavoriteGiphyData {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteGiphyData> {
        return NSFetchRequest<FavoriteGiphyData>(entityName: "FavoriteGiphyData")
    }

    @NSManaged public var id: String?
    @NSManaged public var height: String?
    @NSManaged public var url: String?
    @NSManaged public var width: String?
	@NSManaged public var timestamp: Date?
}
