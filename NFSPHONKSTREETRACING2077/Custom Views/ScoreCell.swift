//
//  ScoreCell.swift
//  NFSPHONKSTREETRACING2077
//
//  Created by Роман Денисенко on 18.11.22.
//

import UIKit

class ScoreCell: UITableViewCell {
    // MARK: - Private properties
    private lazy var goldenColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
    private lazy var silverColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
    private lazy var bronzeColor = #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1)
    // MARK: - IBOutlets
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    // MARK: - Override methods
    override func prepareForReuse() {
        super.prepareForReuse()
        usernameLabel.text = ""
        scoreLabel.text = ""
        self.backgroundColor = .white
    }
    // MARK: - Private methods
    public func setup(with score : Player, position : Int){
        usernameLabel.text = score.name
        scoreLabel.text = String(score.score)
        switch position {
        case 0:
            backgroundColor = goldenColor
        case 1:
            backgroundColor = silverColor
        case 2:
            backgroundColor = bronzeColor
        default:
            backgroundColor = position % 2 == 1  ? .white : .lightGray
        }
    }
}
