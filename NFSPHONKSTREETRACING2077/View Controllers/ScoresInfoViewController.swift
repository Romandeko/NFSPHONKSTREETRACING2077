//
//  ScoresInfoViewController.swift
//  NFSPHONKSTREETRACING2077
//
//  Created by Роман Денисенко on 19.11.22.
//

import UIKit

class ScoresInfoViewController: UIViewController {
    // MARK: - Private properties
    private var name = String()
    private var place = String()
    private var score = String()
    private var date = String()
    // MARK: - IBOutlets
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    // MARK: - Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = name
        placeLabel.text = place
        scoreLabel.text = score
        dateLabel.text = date
    }
    // MARK: - Private methods
    public func setup(with score : Player,onPlace place : Int){
        self.name = score.name
        self.place = "\(place)"
        self.score = "Score :\(score.score)"
        date = score.date
    }
}
