import Foundation
import RxSwift

enum ズンドコ: UInt32 {
    case ズン
    case ドコ
}

let ズンドコ川 = Observable<Int>.interval(0.5, scheduler: MainScheduler.instance)
    .map { _ in ズンドコ(rawValue: arc4random_uniform(2))! }

let 直近5件 = ズンドコ川
    .scan([]) { Array(($0 + [$1]).suffix(5)) }
    .shareReplay(1)

let キヨシチェック: [ズンドコ] -> Bool = { $0 != [.ズン, .ズン, .ズン, .ズン, .ドコ] }

_ = Observable
    .of(
        直近5件.takeWhile(キヨシチェック),
        直近5件.skipWhile(キヨシチェック).take(1)
    )
    .merge()
    .map { $0.last! }
    .concat(Observable.never().take(0.5, scheduler: MainScheduler.instance))
    .subscribe(onNext: { print($0) }, onCompleted: { print("キ・ヨ・シ！") })

///

import XCPlayground
XCPlaygroundPage.currentPage.needsIndefiniteExecution = true
