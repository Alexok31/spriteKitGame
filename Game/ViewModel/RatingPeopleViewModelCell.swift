//
//  RatingPeopleViewModelCell.swift
//  TextGame
//
//  Created by EVA RUSH on 08.07.2020.
//  Copyright © 2020 EVA RUSH. All rights reserved.
//

import Foundation

class RatingPeopleViewModelCell: RatigPeopleViewModelCellType {
    
    var ratingPeople: RatingModel
    
    init(ratingPeople: RatingModel) {
        self.ratingPeople = ratingPeople
    }
    
    var name: String {
        return ratingPeople.name ?? ""
    }
    
    var score: String {
        return "\(ratingPeople.score)"
    }
}

