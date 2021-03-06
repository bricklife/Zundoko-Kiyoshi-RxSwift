import Foundation
import RxSwift

enum ズンドコ: UInt32 {
    case ズン
    case ドコ
}

let ズンドコ川 = Observable<Int>.interval(0.5, scheduler: MainScheduler.instance)
    .map { _ in ズンドコ(rawValue: arc4random_uniform(2))! }
    .shareReplay(1)

let キヨシトリガー = ズンドコ川
    .scan([]) { Array(($0 + [$1]).suffix(5)) }
    .skipWhile { $0 != [.ズン, .ズン, .ズン, .ズン, .ドコ] }
    .skip(1)

_ = ズンドコ川
    .takeUntil(キヨシトリガー)
    .subscribe(onNext: { print($0) }, onCompleted: { print("キ・ヨ・シ！") })

///

import XCPlayground
XCPlaygroundPage.currentPage.needsIndefiniteExecution = true
