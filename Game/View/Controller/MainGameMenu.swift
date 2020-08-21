//
//  ViewController.swift
//  TextGame
//
//  Created by EVA RUSH on 02.07.2020.
//  Copyright © 2020 EVA RUSH. All rights reserved.
//

import UIKit
import SpriteKit

class MainGameMenu: UIViewController {

    @IBOutlet weak var spriteView: SKView!
    @IBOutlet weak var ratingTableView: UITableView!
    
    var viewModel: MainGameMenuViewModelType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = MainGameMenuViewModel()
        let scaneGame = (spriteView.scene as? ScaneGame)
        scaneGame?.gameStatDelegate = viewModel
        scaneGame?.newRecordScane()
        
        viewModel?.newRecord = { [weak self] in
            self?.presentSaveResultGameAlert()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let evaBird = (spriteView.scene as? ScaneGame)?.evaBird
        evaBird?.pushUpNode()
        (spriteView.scene as? ScaneGame)?.startSpawnWalls()
    }
    
    func presentSaveResultGameAlert() {
        let alert = UIAlertController(title: "Новый рекорд!!!", message: "Веевиде ваше имя если хотите сохранить результат", preferredStyle: .alert)

        alert.addTextField { (textField) in }
        alert.addAction(UIAlertAction(title: "Закрыть", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Сохранить", style: .default, handler: { [weak alert] (_) in
            if let text = alert?.textFields?[0].text {
                self.viewModel?.saveScorePoints(name: text)
                DispatchQueue.main.async {
                    self.ratingTableView.reloadData()
                }
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }

    @IBAction func restartGame(_ sender: Any) {
        (spriteView.scene as? ScaneGame)?.restart()
    }
    
}

extension MainGameMenu: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.countRatingPeople ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RatingCellId") as! RatingPeopleCell
        cell.viewModel = viewModel?.ratigPeopleViewModelCell(indexPath: indexPath)
        return cell
    }
    
    
}
