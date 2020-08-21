//
//  MainGameMenuViewModelType.swift
//  TextGame
//
//  Created by EVA RUSH on 08.07.2020.
//  Copyright © 2020 EVA RUSH. All rights reserved.
//

import Foundation

protocol MainGameMenuViewModelType: GameState {
    var countRatingPeople: Int {get}
    var newRecord: (()->())? {get set}
    func saveScorePoints(name: String)
    func ratigPeopleViewModelCell(indexPath: IndexPath) -> RatigPeopleViewModelCellType
}
