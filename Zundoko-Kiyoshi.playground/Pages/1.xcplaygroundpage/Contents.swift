import Foundation
import RxSwift

enum ズンドコ: UInt32 {
    case ズン
    case ドコ
}

let ズンドコ川 = Observable<Int>.interval(0.5, scheduler: MainScheduler.instance)
    .map { _ in ズンドコ(rawValue: arc4random_uniform(2))! }

_ = ズンドコ川
    .doOnNext { print($0) }
    .scan([]) { Array(($0 + [$1]).suffix(5)) }
    .takeWhile { $0 != [.ズン, .ズン, .ズン, .ズン, .ドコ] }
    .subscribeCompleted { print("キ・ヨ・シ！") }

///

import XCPlayground
XCPlaygroundPage.currentPage.needsIndefiniteExecution = true
