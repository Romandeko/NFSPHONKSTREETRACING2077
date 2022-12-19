import UIKit
class GameEndless: GameViewController{
    
    private var seconds = 0
    private var newRoadSpeedTimer = Timer()
    
    // MARK: - IBOutlets
    @IBOutlet weak var startBlurView: BackgroundView!
    
    // MARK: - Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.isUserInteractionEnabled = false
        rightSide = view.frame.width - 70
        center = view.center.x
        
        startBlurView.alpha = 1
        startBlurView.makeBlur()
        
        roadsStartLayout()
        mainCarStartLayout()
        enemiesStartLayout()
        addSubViews()
        addLabels()
        motionManager.startAccelerometerUpdates()
        view.insertSubview(startBlurView, aboveSubview: roadImageView)
        view.insertSubview(startBlurView, aboveSubview: carImageView)
        
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
            
            delegate?.gameEnded(withScore: score)
            delegate?.newRecordSet(withScore: score)
            
            StorageManager.shared.coins += score
            stopEverything()
            dismiss(animated: false)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
            self?.intersects()
        }
    }
    
    private func checkIntersect(_ first: UIView, _ second: UIView) -> Bool {
        
        guard let firstFrame = first.layer.presentation()?.frame,
              let secondFrame = second.layer.presentation()?.frame else { return false }
        
        return firstFrame.intersects(secondFrame)
    }
    private func stopEverything(){
        view.layer.removeAllAnimations()
        speed = 0
        scoreTimer.invalidate()
        startTimer.invalidate()
        backTimer.invalidate()
        isLastOnRoadTimer.invalidate()
        newRoadSpeedTimer.invalidate()
        onlyOneCarTimer.invalidate()
        movementTimer.invalidate()
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
    
    @objc func update() {
        if let accelerometerData = motionManager.accelerometerData {
            let valX = accelerometerData.acceleration.x
            
            
            if (carImageView.frame.origin.x < -30)
               || (carImageView.frame.origin.x > view.frame.size.width - 30)
            {
                delegate?.cuvet()
                delegate?.newRecordSet(withScore: score)
                StorageManager.shared.coins += score
                
                stopEverything()
                dismiss(animated: false)
            }
            carImageView.center.x += CGFloat(valX * 6)
            
            lastX = valX
        }
        
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
            isFifty = true
        }
        if score > 100 && isOneHundread == false {
            scoreLabel.textColor = .orange
            isOneHundread = true
            score += 1
        }
        if score > 200 && isTwoHundread == false {
            scoreLabel.textColor = .red
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
            movementTimer = Timer.scheduledTimer(timeInterval: 0.008333, target: self, selector: #selector(update), userInfo: nil, repeats: true)
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
        view.isUserInteractionEnabled = true
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
        let distance : Double = 1200
        let time = distance/speed
        UIImageView.animate(withDuration: time, delay: delay, options: .curveLinear, animations: {
            enemy.center.y += distance
        }, completion: {[weak self]  _ in
            let randomLineArray = [self?.leftSide,self?.center,self?.rightSide,self?.center]
            guard  let randomLine = randomLineArray.randomElement(),let randomLine  else {return}
            enemy.center.x = CGFloat(randomLine)
            enemy.center.y = -150
            self?.speed *= 1.01
        })
    }
    
    private func animateLastEnemy(enemy: UIImageView, delay : Double){
        let distance : Double = 1200
        let time = distance/speed
        UIImageView.animate(withDuration: time, delay: delay, options: .curveLinear, animations: {
            enemy.center.y += distance
        }, completion: {[weak self]  _ in
            self?.isLastOnRoad = true
            let randomLineArray = [self?.leftSide,self?.center,self?.rightSide,self?.center]
            guard  let randomLine = randomLineArray.randomElement(),let randomLine else {return}
            enemy.center.x = CGFloat(randomLine)
            enemy.center.y = -150
            self?.animateLastEnemy(enemy: enemy, delay: delay)
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
        UIImageView.animate(withDuration: 2.5, delay: 0, options: [.curveLinear] ){[weak self] in
            self?.roadImageView.center.y += (self?.roadDistance ?? 0)/2
        }
        
        UIImageView.animate(withDuration: 5, delay: 0, options: [.curveLinear, .repeat] ){[weak self] in
            self?.secondRoadImageView.center.y += self?.roadDistance ?? 0
        }
        
        UIImageView.animate(withDuration: 5, delay: 2.5, options: [.curveLinear, .repeat] ){[weak self] in
            self?.lastRoadImageView.center.y += self?.roadDistance ?? 0
        }
    }
    
    private func fasterRoadAnimation(withDuration duration: Double, withSpeed delay : Double){
        roadImageView.stopAnimating()
        secondRoadImageView.stopAnimating()
        lastRoadImageView.stopAnimating()
        roadImageView.frame.origin.x = 0
        roadImageView.frame.origin.y = 0
        
        secondRoadImageView.frame.origin.x = 0
        secondRoadImageView.frame.origin.y = -roadDistance / 2 + 1
        
        lastRoadImageView.frame.origin.x = 0
        lastRoadImageView.frame.origin.y = -roadDistance / 2 + 1
        
        UIImageView.animate(withDuration: delay, delay: 0, options: [.curveLinear] ){[weak self] in
            self?.roadImageView.center.y += (self?.roadDistance ?? 0)/2
        }
        
        UIImageView.animate(withDuration: duration, delay: 0, options: [.curveLinear, .repeat] ){[weak self] in
            self?.secondRoadImageView.center.y += self?.roadDistance ?? 0
        }
        
        UIImageView.animate(withDuration: duration, delay: delay, options: [.curveLinear, .repeat] ){[weak self] in
            self?.lastRoadImageView.center.y += self?.roadDistance ?? 0
        }
    }
    
    // MARK: - Layouts
    
    private func enemiesStartLayout(){
        
        let randomLineArray = [leftSide,center,rightSide]
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
        roadImageView.frame.size.width = view.frame.size.width
        roadImageView.frame.size.height = roadDistance / 2
        
        secondRoadImageView.frame.origin.x = 0
        secondRoadImageView.frame.origin.y = -roadDistance / 2 + 1
        secondRoadImageView.frame.size.width = view.frame.size.width
        secondRoadImageView.frame.size.height = roadDistance / 2
        lastRoadImageView.frame.origin.x = 0
        lastRoadImageView.frame.origin.y = -roadDistance / 2 + 1
        lastRoadImageView.frame.size.width = view.frame.size.width
        lastRoadImageView.frame.size.height = roadDistance / 2
    }
    
    private  func mainCarStartLayout(){
        carImageView.frame = CGRect(x: center, y: 550, width: 75, height: 140)
        carImageView.center.x = view.center.x
        carImageView.isUserInteractionEnabled = true
    }
}
