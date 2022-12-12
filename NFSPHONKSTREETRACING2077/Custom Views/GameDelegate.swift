
import Foundation

protocol GameDelegate : AnyObject {
    func gameEnded(withScore score: Int)
    func finishPassed()
    func newRecordSet(withScore score: Int)
}

extension GameDelegate{
    func gameEnded(withScore score: Int) { }
    func finishPassed() { }
    func newRecordSet(withScore score: Int) { }
}

