//
//  ScoresViewController.swift
//  NFSPHONKSTREETRACING2077
//
//  Created by Роман Денисенко on 18.11.22.
//

import UIKit

class ScoresViewController: UIViewController {
    // MARK: - Private properties
    private lazy var goldenColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
    private lazy var silverColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
    private lazy var bronzeColor = #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1)
    private let cellIdentifier = "ScoreCell"
    private lazy var scores = StorageManager.shared.playersArray
    private var selectedIndex = -1
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    // MARK: - Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTable()
        
    }
    // MARK: - Private methods
    private func setUpTable(){
        tableView.delegate = self
        tableView.dataSource = self
        let cellNib = UINib(nibName: "ScoreCell", bundle: Bundle.main)
        tableView.register(cellNib, forCellReuseIdentifier: cellIdentifier)
    }
}

extension ScoresViewController : UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        scores.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        guard  let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier,for: indexPath) as? ScoreCell,
               index >= 0,
               index < scores.count
        else { return UITableViewCell()}
        
        cell.setup(with: scores[index], position: index)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        guard index >= 0,index < scores.count else { return }
        selectedIndex = index
        tableView.deselectRow(at: indexPath, animated: true)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let destinationViewController = storyboard.instantiateViewController(withIdentifier: "ScoresInfoViewController") as? ScoresInfoViewController else { return }
        destinationViewController.setup(with: StorageManager.shared.playersArray[selectedIndex], onPlace: selectedIndex+1)
        switch selectedIndex {
        case 0:
            destinationViewController.view.backgroundColor = goldenColor
        case 1:
            destinationViewController.view.backgroundColor = silverColor
        case 2:
            destinationViewController.view.backgroundColor = bronzeColor
        default:
            break
        }
        present(destinationViewController, animated: true)
        
        
    }
    
    
}
