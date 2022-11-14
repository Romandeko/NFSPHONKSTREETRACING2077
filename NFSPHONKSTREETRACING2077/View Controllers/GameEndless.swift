import UIKit

class GameEndless: UIViewController {
    
    // MARK: - Override properties
    var mainCarImage = UIImage()
    
    // MARK: - Private properties
    private lazy var carImageView  = UIImageView(image: mainCarImage)
    private var carLocation: Location = .center {
        willSet (newLocation) {
            carLayout(at: newLocation)
        }
    }
    
    private var backMessage = "Капец ты слабый..."
    private var time = 3
    private var seconds = 0
    private var score = 0
    private var scoreTimer = Timer()
    private var startTimer = Timer()
    private var backTimer = Timer()
    private var onlyOneCarTimer = Timer()
    private var isLastOnRoadTimer = Timer()
    private var newRoadSpeedTimer = Timer()
    private let scoreLabel = UILabel()
    private let timeLabel = UILabel()
    
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
    private var secondsCounter = 0
    
    private var isOneHundread = false
    private var isFifty = false
    private var isTwoHundread = false
    private var isStarted = false
    private var isLastOnRoad = false
    
    // MARK: - IBOutlets
    @IBOutlet weak var startBlurView: BackgroundView!
    
    // MARK: - Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rightSide = view.frame.width - 70
        center = view.center.x
        
        startBlurView.alpha = 1
        startBlurView.makeBlur()
        
        roadsStartLayout()
        mainCarStartLayout()
        enemiesStartLayout()
        addSubViews()
        addLabels()
        
        view.insertSubview(startBlurView, aboveSubview: roadImageView)
        view.insertSubview(startBlurView, aboveSubview: carImageView)
        
        addSwipeGesture(to: carImageView, with: .left)
        addSwipeGesture(to: carImageView, with: .right)
    }
    
    override func viewDidAppear(_ animated: Bool){
        super.viewDidAppear(true)
        score = 0
        addTimers()
        roadAnimation()
        intersects()
    }
    
    // MARK: - Private methods
    private func intersects() {
        
        if checkIntersect(carImageView, redEnemy)
            || checkIntersect(carImageView, blueEnemy)
            || checkIntersect(carImageView, greenEnemy)
            || checkIntersect(carImageView, whiteEnemy)
            || checkIntersect(carImageView, policeEnemy)
            || checkIntersect(carImageView, taxiEnemy){
            
            guard let parentViewController = self.presentingViewController as?
                    Menu else { return }
            parentViewController.backMessage = self.backMessage
            StorageManager.shared.coins += score
            view.layer.removeAllAnimations()
            speed = 0
            scoreTimer.invalidate()
            StorageManager.shared.currentScore = score
            StorageManager.shared.updateRecords()
            self.dismiss(animated: false)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.intersects()
        }
    }
    
    private func checkIntersect(_ first: UIView, _ second: UIView) -> Bool {
        
        guard let firstFrame = first.layer.presentation()?.frame,
              let secondFrame = second.layer.presentation()?.frame else { return false }
        
        return firstFrame.intersects(secondFrame)
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
    
    private func addLabels(){
        
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
    }
    // MARK: - Timers
    private func addTimers(){
        scoreTimer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(scoreUpdate), userInfo: nil, repeats: true)
        startTimer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(startCheck), userInfo: nil, repeats: true)
        backTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timeBack), userInfo: nil, repeats: true)
        isLastOnRoadTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(checkLastCar), userInfo: nil, repeats: true)
        newRoadSpeedTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateSpeed), userInfo: nil, repeats: true)
    }
    
    @objc private func updateSpeed(){
        seconds += 1
        if seconds == 125 {
            fasterRoadAnimation(withDuration: 4.6, withSpeed:2.3)
            return
        }
        if seconds == 265{
            fasterRoadAnimation(withDuration: 4.2, withSpeed: 2.1)
            return
        }
        if seconds == 391{
            fasterRoadAnimation(withDuration: 3.6, withSpeed: 1.8)
            return
        }
        if seconds == 499{
            fasterRoadAnimation(withDuration: 3.2, withSpeed: 1.6)
            return
        }
        if seconds == 595{
            fasterRoadAnimation(withDuration: 2.8, withSpeed: 1.4)
            return
        }
    }
    
    @objc private func scoreUpdate(){
        guard isStarted == true else { return }
        
        score += 1
        if score > 50 && isFifty == false {
            scoreLabel.textColor = .yellow
            backMessage = "Так себе"
            isFifty = true
        }
        if score > 100 && isOneHundread == false {
            scoreLabel.textColor = .orange
            backMessage = "Можно и лучше"
            isOneHundread = true
            score += 1
        }
        if score > 200 && isTwoHundread == false {
            scoreLabel.textColor = .red
            backMessage = "КУДА ТЫ ТАК ГОНИШЬ"
            isTwoHundread = true
            score += 2
        }
        
        let myAttribute = [ NSAttributedString.Key.font: UIFont(name: "Miratrix", size: 30)]
        let scoreString = NSMutableAttributedString(string: String(score), attributes: myAttribute as [NSAttributedString.Key : Any] )
        scoreLabel.attributedText = scoreString
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
        guard isStarted == false else { return }
        isStarted = true
        animateAllEnemies()
        animateLastEnemy(enemy: policeEnemy, delay: 6)
        startBlurView.isHidden = true
    }
    
    @objc private func checkLastCar(){
        if isLastOnRoad == true{
            animateAllEnemies()
            isLastOnRoad = false
        }
    }
    
    // MARK: - Animations
    private func animateEnemy(enemy: UIImageView, delay : Double){
        let distance : Double = 1100
        let time = distance/speed
        UIImageView.animate(withDuration: time, delay: delay, options: .curveLinear, animations: {
            enemy.center.y += distance
        }, completion: { _ in
            let randomLineArray = [self.leftSide,self.center,self.rightSide,self.center]
            guard  let randomLine = randomLineArray.randomElement() else {return}
            enemy.center.x = CGFloat(randomLine)
            enemy.center.y = -150
            self.speed *= 1.01
        })
    }
    
    private func animateLastEnemy(enemy: UIImageView, delay : Double){
        let distance : Double = 1100
        let time = distance/speed
        UIImageView.animate(withDuration: time, delay: delay, options: .curveLinear, animations: {
            enemy.center.y += distance
        }, completion: { _ in
            self.isLastOnRoad = true
            let randomLineArray = [self.leftSide,self.center,self.rightSide,self.center]
            guard  let randomLine = randomLineArray.randomElement() else {return}
            enemy.center.x = CGFloat(randomLine)
            enemy.center.y = -150
            self.animateLastEnemy(enemy: enemy, delay: delay)
        })
    }
    private func animateAllEnemies(){
        animateEnemy(enemy: whiteEnemy, delay: 0)
        animateEnemy(enemy: redEnemy, delay: 1.2)
        animateEnemy(enemy: blueEnemy, delay: 2.5)
        animateEnemy(enemy: greenEnemy, delay: 3.6)
        animateEnemy(enemy: taxiEnemy, delay: 4.8)
    }
    
    private func roadAnimation(){
        UIImageView.animate(withDuration: 2.5, delay: 0, options: [.curveLinear] ){
            self.roadImageView.center.y += 900
        }
        
        UIImageView.animate(withDuration: 5, delay: 0, options: [.curveLinear, .repeat] ){
            self.secondRoadImageView.center.y += self.roadDistance
        }
        
        UIImageView.animate(withDuration: 5, delay: 2.5, options: [.curveLinear, .repeat] ){
            self.lastRoadImageView.center.y += self.roadDistance
        }
    }
    
    private func fasterRoadAnimation(withDuration duration: Double, withSpeed delay : Double){
        roadImageView.stopAnimating()
        secondRoadImageView.stopAnimating()
        lastRoadImageView.stopAnimating()
        roadImageView.frame.size.width = self.view.frame.size.width
        roadImageView.frame.origin.x = 0
        roadImageView.frame.origin.y = 0
        
        secondRoadImageView.frame.origin.x = 0
        secondRoadImageView.frame.origin.y = -899
        secondRoadImageView.frame.size.width = self.view.frame.size.width
        
        lastRoadImageView.frame.origin.x = 0
        lastRoadImageView.frame.origin.y = -899
        lastRoadImageView.frame.size.width = self.view.frame.size.width
        
        UIImageView.animate(withDuration: delay, delay: 0, options: [.curveLinear] ){
            self.roadImageView.center.y += 900
        }
        
        UIImageView.animate(withDuration: duration, delay: 0, options: [.curveLinear, .repeat] ){
            self.secondRoadImageView.center.y += self.roadDistance
        }
        
        UIImageView.animate(withDuration: duration, delay: delay, options: [.curveLinear, .repeat] ){
            self.lastRoadImageView.center.y += self.roadDistance
        }
    }
    
    // MARK: - Layouts
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
    
    private func enemiesStartLayout(){
        
        let randomLineArray = [self.leftSide,self.center,self.rightSide]
        guard let randomLineForWhite = randomLineArray.randomElement() else {return}
        guard let randomLineForTruck = randomLineArray.randomElement() else {return}
        guard let randomLineForTaxi = randomLineArray.randomElement() else {return}
        guard let randomLineForRed = randomLineArray.randomElement() else {return}
        guard let randomLineForPolice = randomLineArray.randomElement() else {return}
        guard let randomLineForBlue = randomLineArray.randomElement() else {return}
        
        whiteEnemy.frame = CGRect(x: 0, y: -150, width: 75, height: 140)
        greenEnemy.frame = CGRect(x: 0, y: -150, width: 75, height: 140)
        taxiEnemy.frame = CGRect(x: 0, y: -150, width: 70, height: 140)
        redEnemy.frame = CGRect(x: 0, y: -150, width: 70, height: 140)
        policeEnemy.frame = CGRect(x: 0, y: -150, width: 70, height: 140)
        blueEnemy.frame = CGRect(x: 0, y: -150, width: 75, height: 140)
        
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
