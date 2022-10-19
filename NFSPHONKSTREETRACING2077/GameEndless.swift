/// Выглядит не идеально, но основной функционал выполняется. Хотелось бы улучшить поток машин. Основная проблема - машина может заспавниться в машине .


import UIKit
class GameEndless: UIViewController {
    
    // MARK: - Override properties
    var mainCarImage = UIImage()
    private lazy var carImageView  = UIImageView(image: mainCarImage)
    private var carLocation: Location = .center {
        willSet (newLocation) {
            carLayout(at: newLocation)
        }
    }
    
    private var backMessage = "Капец ты слабый..."
    private var coins = 0
    private var time = 3
    private var scoreTimer = Timer()
    private var finalTimer = Timer()
    private var startTimer = Timer()
    private var backTimer = Timer()
    private let scoreLabel = UILabel()
    private let timeLabel = UILabel()
    private var isOneHundread = false
    private var isFifty = false
    private var isTwoHundread = false
    private var isStarted = false

    
    private let roadImage = UIImage(named: "road1")
    private lazy var roadImageView = UIImageView(image: roadImage)
    private lazy var lastRoadImageView = UIImageView(image: roadImage)
    private lazy var secondRoadImageView = UIImageView(image: roadImage)
    
    private let whiteEnemyImage = UIImage(named: "whiteEnemy")
    private let greenEnemyImage = UIImage(named: "green")
    private let taxiEnemyImage  = UIImage(named: "taxi")
    private let redEnemyImage = UIImage(named: "redcar")
    private let policeEnemyImage = UIImage(named: "police")
    private let blueEnemyImage = UIImage(named: "blue")

    private lazy var whiteEnemy = UIImageView(image: whiteEnemyImage)
    private lazy var greenEnemy = UIImageView(image: greenEnemyImage)
    private lazy var taxiEnemy = UIImageView(image: taxiEnemyImage)
    private lazy var redEnemy = UIImageView(image: redEnemyImage)
    private lazy var policeEnemy = UIImageView(image: policeEnemyImage)
    private lazy var blueEnemy = UIImageView(image: blueEnemyImage)
    
    private var rightSide : CGFloat = 0
    private var leftSide: CGFloat = 70
    private var center : CGFloat = 0
    
    private var speed = 300.0
    private var roadDistance = 1800.0
    private var roadTime = 5.0
    private var roadSpeed = 360.0
    private var secondsCounter = 0
    
    // MARK: - IBOutlets
    @IBOutlet weak var startBlurView: BackgroundView!
    
    // MARK: - Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        rightSide = view.frame.width - 70
        center = view.center.x
        roadsStartLayout()
        mainCarStartLayout()
        enemiesStartLayout()
        addSubViews()
     
        startBlurView.alpha = 1
        startBlurView.makeBlur()
        view.insertSubview(startBlurView, aboveSubview: roadImageView)
        view.insertSubview(startBlurView, aboveSubview: carImageView)
        scoreLabel.text = String(coins)
        scoreLabel.textAlignment = .center
        scoreLabel.font = scoreLabel.font.withSize(30)
        scoreLabel.textColor = .white
        scoreLabel.frame.size = CGSize(width: 350, height: 50)
        scoreLabel.center.x = 50
        scoreLabel.frame.origin.y = 50
        view.addSubview(scoreLabel)
        
        timeLabel.text = String(time)
        timeLabel.textAlignment = .center
        timeLabel.font = timeLabel.font.withSize(100)
        timeLabel.textColor = .black
        timeLabel.frame.size = CGSize(width: 200, height: 200)
        timeLabel.center.x  = view.center.x
        timeLabel.center.y = view.center.y
        view.addSubview(timeLabel)
        
        addSwipeGesture(to: carImageView, with: .left)
        addSwipeGesture(to: carImageView, with: .right)
    }
    
    override func viewDidAppear(_ animated: Bool){
        super.viewDidAppear(true)
        
        coins = 0
        
        scoreTimer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(scoreUpdate), userInfo: nil, repeats: true)
        startTimer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(startCheck), userInfo: nil, repeats: true)
        backTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timeBack), userInfo: nil, repeats: true)
    
        
        let scoreLabel = UILabel()
        scoreLabel.text = String(coins)
        scoreLabel.textAlignment = .center
        scoreLabel.font = scoreLabel.font.withSize(30)
        scoreLabel.textColor = .white
        scoreLabel.frame.size = CGSize(width: 350, height: 50)
        scoreLabel.center.x = 50
        scoreLabel.frame.origin.y = 50
        
     
    }
    
    private func addSwipeGesture(to view: UIImageView, with direction: UISwipeGestureRecognizer.Direction){
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(moveCar))
        swipeGesture.direction = direction
        self.view.addGestureRecognizer(swipeGesture)
    }
    
    @objc private func moveCar (_ gestureRecogniser: UISwipeGestureRecognizer){
        switch gestureRecogniser.direction{
        case .left:
            if carLocation == .center {carLocation = .left}
            if carLocation == .right {carLocation = .center}
        case .right:
            if carLocation == .center {carLocation = .right}
            if carLocation == .left {carLocation = .center}
        default: return
        }
    }
    
    private func carLayout( at location : Location){
        UIImageView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut ){
            switch location {
                
            case .left:
                self.carImageView.center.x = self.leftSide
                
            case .center:
                self.carImageView.center.x = self.center
                
            case .right:
                self.carImageView.center.x = self.rightSide
                
            }
        }
    }
    
    @objc private func scoreUpdate(){
        guard isStarted == true else { return }
        
        coins += 1
        if coins > 50 && isFifty == false {
            scoreLabel.textColor = .yellow
            backMessage = "Так себе"
            isFifty = true
        }
        if coins > 100 && isOneHundread == false {
            scoreLabel.textColor = .orange
            backMessage = "Можно и лучше"
            isOneHundread = true
            coins += 1
        }
        if coins > 200 && isTwoHundread == false {
            scoreLabel.textColor = .red
            backMessage = "КУДА ТЫ ТАК ГОНИШЬ"
            isTwoHundread = true
            coins += 2
        }
        scoreLabel.text = String(coins)
    }
    
 
    @objc private func timeBack(){
        if timeLabel.text  == "1" {
            timeLabel.text = "GO"
            return
        }
        if timeLabel.text  == "GO" {
            timeLabel.text = ""
            backTimer.invalidate()
            return
        }
        time -= 1
        timeLabel.text = String(time)
        }
    
    
    @objc private func startCheck(){
        if isStarted == false {
            isStarted = true
            
            animateEnemy(enemy: whiteEnemy, lastDistance: 400, delay: 1.6)
            animateEnemy(enemy: redEnemy, lastDistance: 500, delay: 0.5)
            animateEnemy(enemy: blueEnemy, lastDistance: 600, delay: 2.6)
            animateEnemy(enemy: greenEnemy, lastDistance: 400, delay: 3.9)
            animateEnemy(enemy: taxiEnemy, lastDistance: 500, delay: 4.8)
            animateEnemy(enemy: policeEnemy, lastDistance: 400, delay: 5.6)
            
            UIImageView.animate(withDuration: 2.5, delay: 0, options: [.curveLinear] ){
                self.roadImageView.center.y += 900
            }
            
            UIImageView.animate(withDuration: 5, delay: 0, options: [.curveLinear, .repeat] ){
                self.secondRoadImageView.center.y += self.roadDistance
            }
            
            UIImageView.animate(withDuration: 5, delay: 2.5, options: [.curveLinear, .repeat] ){
                self.lastRoadImageView.center.y += self.roadDistance
            }

            startBlurView.isHidden = true
            
        } else { return }
        
    }
    
    private func animateEnemy(enemy: UIImageView, lastDistance: Double, delay : Double){
        let firstDistance : Double = 710
        let secondDistance : Double = 250
        let thirdDistance : Double = lastDistance
        let firstTime = firstDistance/speed
        UIImageView.animate(withDuration: firstTime, delay: delay, options: .curveLinear, animations: {
            enemy.center.y += firstDistance
        }, completion: { _ in
            if enemy.center.x == self.carImageView.center.x {
                
                guard let parentViewController = self.presentingViewController as?
                        Menu else { return }
                parentViewController.backMessage = self.backMessage
                parentViewController.coins += self.coins
                self.dismiss(animated: false)
            }
            let secondTime = secondDistance/self.speed
            UIImageView.animate(withDuration: secondTime, delay: 0, options: .curveLinear, animations: {
                enemy.center.y += secondDistance
            },completion: {_ in
                if enemy.center.x == self.carImageView.center.x {
                    guard let parentViewController = self.presentingViewController as?
                            Menu else { return }
                    parentViewController.backMessage = self.backMessage
                    parentViewController.coins +=  self.coins
                    self.dismiss(animated: false)
                }
                let thirdTime = thirdDistance/self.speed
                UIImageView.animate(withDuration: thirdTime, delay: 0, options: .curveLinear,animations:{
                    enemy.center.y += thirdDistance}, completion: { _ in
                        let randomLineArray = [self.leftSide,self.center,self.rightSide]
                        guard  let randomLine = randomLineArray.randomElement() else {return}
                        enemy.center.x = CGFloat(randomLine)
                        enemy.center.y = -300
                        self.animateEnemy(enemy: enemy, lastDistance: lastDistance, delay: delay)
                    })
            })
        })
    }
    
    private func addSubViews(){
        
        view.addSubview(secondRoadImageView)
        view.addSubview(roadImageView)
        view.addSubview(lastRoadImageView)
        view.addSubview(carImageView)
        view.addSubview(whiteEnemy)
        view.addSubview(greenEnemy)
        view.addSubview(taxiEnemy)
        view.addSubview(redEnemy)
        view.addSubview(policeEnemy)
        view.addSubview(blueEnemy)
    }
    private func enemiesStartLayout(){
        let randomLineArray = [self.leftSide,self.center,self.rightSide]
        
        guard  let randomLineForWhite = randomLineArray.randomElement() else {return}
        guard  let randomLineForTruck = randomLineArray.randomElement() else {return}
        guard  let randomLineForTaxi = randomLineArray.randomElement() else {return}
        guard  let randomLineForRed = randomLineArray.randomElement() else {return}
        guard  let randomLineForPolice = randomLineArray.randomElement() else {return}
        guard  let randomLineForBlue = randomLineArray.randomElement() else {return}
        
        whiteEnemy.frame = CGRect(x: 0, y: -300, width: 75, height: 140)
        greenEnemy.frame = CGRect(x: 0, y: -300, width: 75, height: 140)
        taxiEnemy.frame = CGRect(x: 0, y: -300, width: 70, height: 140)
        redEnemy.frame = CGRect(x: 0, y: -300, width: 70, height: 140)
        policeEnemy.frame = CGRect(x: 0, y: -300, width: 70, height: 140)
        blueEnemy.frame = CGRect(x: 0, y: -300, width: 75, height: 140)
        
        
        whiteEnemy.center.x = randomLineForWhite
        greenEnemy.center.x = randomLineForTruck
        taxiEnemy.center.x = randomLineForTaxi
        redEnemy.center.x = randomLineForRed
        policeEnemy.center.x = randomLineForPolice
        blueEnemy.center.x = randomLineForBlue
        
    }
    private func roadsStartLayout(){
        
        roadImageView.frame.size.width = self.view.frame.size.width
        
        secondRoadImageView.frame.origin.x = 0
        secondRoadImageView.frame.origin.y = -899
        secondRoadImageView.frame.size.width = self.view.frame.size.width
        
        lastRoadImageView.frame.origin.x = 0
        lastRoadImageView.frame.origin.y = -899
        lastRoadImageView.frame.size.width = self.view.frame.size.width
    }
    
    private  func mainCarStartLayout(){
        carImageView.frame = CGRect(x: center, y: 550, width: 75, height: 140)
        carImageView.center.x = view.center.x
        carImageView.isUserInteractionEnabled = true
    }
    
}


