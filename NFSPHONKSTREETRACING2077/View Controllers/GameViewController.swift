//
//  GameViewController.swift
//  NFSPHONKSTREETRACING2077
//
//  Created by Роман Денисенко on 24.11.22.
//

import UIKit
import CoreMotion
class GameViewController: UIViewController,GameDelegate {
    // MARK: - Override properties
    var mainCarImage = UIImage()
    weak var delegate : GameDelegate?
    lazy var carImageView  = UIImageView(image: mainCarImage)
    var time = 3
    var score = 0
    var scoreTimer = Timer()
    var startTimer = Timer()
    var backTimer = Timer()
    var onlyOneCarTimer = Timer()
    var isLastOnRoadTimer = Timer()
    var movementTimer = Timer()
    let scoreLabel = UILabel()
    let timeLabel = UILabel()
    var lastX = 0.0
    var lastY = 0.0
    var lastZ = 0.0
    let motionManager = CMMotionManager()
    let roadImage = UIImage(named: "road1")
    lazy var roadImageView = UIImageView(image: roadImage)
    lazy var lastRoadImageView = UIImageView(image: roadImage)
    lazy var secondRoadImageView = UIImageView(image: roadImage)
    let whiteEnemyImage = UIImage(named: "whiteEnemy")
    let greenEnemyImage = UIImage(named: "green")
    let taxiEnemyImage  = UIImage(named: "taxi")
    let redEnemyImage = UIImage(named: "redcar")
    let policeEnemyImage = UIImage(named: "police")
    let blueEnemyImage = UIImage(named: "blue")
    
    lazy var whiteEnemy = UIImageView(image: whiteEnemyImage)
    lazy var greenEnemy = UIImageView(image: greenEnemyImage)
    lazy var taxiEnemy = UIImageView(image: taxiEnemyImage)
    lazy var redEnemy = UIImageView(image: redEnemyImage)
    lazy var policeEnemy = UIImageView(image: policeEnemyImage)
    lazy var blueEnemy = UIImageView(image: blueEnemyImage)
    
    var rightSide : CGFloat = 0
    var leftSide: CGFloat = 70
    var center : CGFloat = 0
    
    var speed = 300.0
    var roadDistance = 2000.0
    var secondsCounter = 0
    
    var isOneHundread = false
    var isFifty = false
    var isTwoHundread = false
    var isStarted = false
    var isLastOnRoad = false
    
    // MARK: - Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
}
