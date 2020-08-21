//
//  CoreDataRatingPeopleManeager.swift
//  TextGame
//
//  Created by EVA RUSH on 08.07.2020.
//  Copyright © 2020 EVA RUSH. All rights reserved.
//

import Foundation

class RatingPeopleManeager {
    
    let persistentManager: PersistentManager
    
    init(persistentManager: PersistentManager) {
        self.persistentManager = persistentManager
    }
    
    // Create Core Data Object
    
    func saveScorePoints(name: String, score: Int) {
        let ratingModel = RatingModel(context: persistentManager.context)
        ratingModel.name = name
        ratingModel.score = Int32(score)
        
        persistentManager.save()
    }
    
    var fatch: [RatingModel] {
        guard let ratingModel = try! persistentManager.context.fetch(RatingModel.fetchRequest()) as? [RatingModel]
            else {return [RatingModel]()}
        return ratingModel.sorted(by: {$0.score > $1.score})
    }
}
