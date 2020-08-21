//
//  RatingPeopleCell.swift
//  TextGame
//
//  Created by EVA RUSH on 08.07.2020.
//  Copyright © 2020 EVA RUSH. All rights reserved.
//

import UIKit

class RatingPeopleCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var score: UILabel!
    
    var viewModel: RatigPeopleViewModelCellType? {
        willSet(viewModel) {
            name.text = viewModel?.name
            score.text = viewModel?.score
        }
    }
}
