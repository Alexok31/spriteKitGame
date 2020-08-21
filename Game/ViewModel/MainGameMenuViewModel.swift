//
//  MainGameMenuViewModel.swift
//  TextGame
//
//  Created by EVA RUSH on 08.07.2020.
//  Copyright © 2020 EVA RUSH. All rights reserved.
//

import Foundation

class MainGameMenuViewModel: MainGameMenuViewModelType {
    
    var ratingPeopleManeager: RatingPeopleManeager
    
    init() {
        ratingPeopleManeager = RatingPeopleManeager(persistentManager: PersistentManager.shared)
    }
    
    var newRecord: (() -> ())?
    var newRecordScane: (() -> ())?
    
    private var numberScorePoints: Int = 0
    
    var countRatingPeople: Int {
        return ratingPeople.count
    }
    
    private var ratingPeople: [RatingModel] {
        return ratingPeopleManeager.fatch
    }
    
    func numberOf(scorePoints: Int) {
        numberScorePoints = scorePoints
        let maxScore = ratingPeople.map({$0.score}).max() ?? 0
        if scorePoints > maxScore {
            newRecordScane?()
            newRecord?()
        }
    }
    
    func saveScorePoints(name: String) {
        ratingPeopleManeager.saveScorePoints(name: name, score: numberScorePoints)
    }
    
    func ratigPeopleViewModelCell(indexPath: IndexPath) -> RatigPeopleViewModelCellType {
        return RatingPeopleViewModelCell(ratingPeople: ratingPeople[indexPath.row])
    }
}
