/// Выглядит не идеально, но основной функционал выполняется. Хотелось бы улучшить поток машин. Основная проблема - машина может заспавниться в машине .


import UIKit
class Game: UIViewController {
    
    // MARK: - Override properties
    private let carImage = UIImage(named: "car")
    private lazy var carImageView = UIImageView(image: carImage)
    private var carLocation: Location = .center {
        willSet (newLocation) {
            carLayout(at: newLocation)
        }
    }
    
    private var loseMessage = "Капец ты слабый..."
    private var score = 0
    private var timer = Timer()
    private let scoreLabel = UILabel()
    private var isOneHundread = false
    private var isTwoHundread = false
    private var isThreeHundread = false
    
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
    
    private let speed = 300.0
    
    // MARK: - Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rightSide = view.frame.width - 70
        center = view.center.x
        
        roadsStartLayout()
        mainCarStartLayout()
        enemiesStartLayout()
        addSubViews()
        
        scoreLabel.text = String(score)
        scoreLabel.textAlignment = .center
        scoreLabel.font = scoreLabel.font.withSize(30)
        scoreLabel.textColor = .white
        scoreLabel.frame.size = CGSize(width: 350, height: 50)
        scoreLabel.center.x = 50
        scoreLabel.frame.origin.y = 50
        view.addSubview(scoreLabel)
        
        addSwipeGesture(to: carImageView, with: .left)
        addSwipeGesture(to: carImageView, with: .right)
    }
    
    override func viewDidAppear(_ animated: Bool){
        
        super.viewDidAppear(true)
        
        UIImageView.animate(withDuration: 2.5, delay: 0, options: [.curveLinear] ){
            self.roadImageView.center.y += 900
        }
        
        UIImageView.animate(withDuration: 5, delay: 0, options: [.curveLinear, .repeat] ){
            self.secondRoadImageView.center.y += 1800
        }
        
        UIImageView.animate(withDuration: 5, delay: 2.5, options: [.curveLinear, .repeat] ){
            self.lastRoadImageView.center.y += 1800
        }
        
        timer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(scoreUpdate), userInfo: nil, repeats: true)
        
        let scoreLabel = UILabel()
        scoreLabel.text = String(score)
        scoreLabel.textAlignment = .center
        scoreLabel.font = scoreLabel.font.withSize(30)
        scoreLabel.textColor = .white
        scoreLabel.frame.size = CGSize(width: 350, height: 50)
        scoreLabel.center.x = 50
        scoreLabel.frame.origin.y = 50
        
        animateEnemy(enemy: whiteEnemy, lastDistance: 400, delay: 1.6)
        animateEnemy(enemy: redEnemy, lastDistance: 500, delay: 0.5)
        animateEnemy(enemy: blueEnemy, lastDistance: 600, delay: 2.6)
        animateEnemy(enemy: greenEnemy, lastDistance: 400, delay: 3.9)
        animateEnemy(enemy: taxiEnemy, lastDistance: 500, delay: 4.8)
        animateEnemy(enemy: policeEnemy, lastDistance: 400, delay: 5.6)
        
    }
    
    // MARK: - Private methods
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
        score += 1
        if score > 100 && isOneHundread == false {
            scoreLabel.textColor = .yellow
            loseMessage = "Так себе"
            isOneHundread = true
            
        }
        if score > 200 && isTwoHundread == false {
            scoreLabel.textColor = .orange
            loseMessage = "Можно и лучше"
            isTwoHundread = true
        }
        if score > 300 && isThreeHundread == false {
            scoreLabel.textColor = .red
            loseMessage = "КУДА ТЫ ТАК ГОНИШЬ"
            isThreeHundread = true
        }
        scoreLabel.text = String(score)
    }
    
    private func animateEnemy(enemy: UIImageView, lastDistance: Double, delay : Double){
        let firstDistance : Double = 800
        let secondDistance : Double = 140
        let thirdDistance : Double = lastDistance
        let firstTime = firstDistance/speed
        UIImageView.animate(withDuration: firstTime, delay: delay, options: .curveLinear, animations: {
            enemy.center.y += firstDistance
        }, completion: { _ in
            if enemy.center.x == self.carImageView.center.x {
                
                guard let destinationViewController = self.presentingViewController as?
                        ViewController else { return }
                destinationViewController.loseMessage = self.loseMessage
                self.dismiss(animated: false)
            }
            let secondTime = secondDistance/self.speed
            UIImageView.animate(withDuration: secondTime, delay: 0, options: .curveLinear, animations: {
                enemy.center.y += secondDistance
            },completion: {_ in
                if enemy.center.x == self.carImageView.center.x {
                    guard let destinationViewController = self.presentingViewController as?
                            ViewController else { return }
                    destinationViewController.loseMessage = self.loseMessage
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
                    }
                ) }) })
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
        
        whiteEnemy.frame = CGRect(x: 0, y: -300, width: 100, height: 150)
        greenEnemy.frame = CGRect(x: 0, y: -300, width: 90, height: 150)
        taxiEnemy.frame = CGRect(x: 0, y: -300, width: 100, height: 150)
        redEnemy.frame = CGRect(x: 0, y: -300, width: 90, height: 150)
        policeEnemy.frame = CGRect(x: 0, y: -300, width: 100, height: 150)
        blueEnemy.frame = CGRect(x: 0, y: -300, width: 90, height: 150)
        
        
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
        carImageView.frame = CGRect(x: center, y: 550, width: 100, height: 150)
        carImageView.center.x = view.center.x
        carImageView.isUserInteractionEnabled = true
    }
}


