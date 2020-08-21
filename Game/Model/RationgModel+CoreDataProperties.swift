//
//  RatingModel+CoreDataProperties.swift
//  TextGame
//
//  Created by EVA RUSH on 08.07.2020.
//  Copyright © 2020 EVA RUSH. All rights reserved.
//
//

import Foundation
import CoreData


extension RatingModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RatingModel> {
        return NSFetchRequest<RatingModel>(entityName: "RatingModel")
    }

    @NSManaged public var name: String?
    @NSManaged public var score: Int32

}
