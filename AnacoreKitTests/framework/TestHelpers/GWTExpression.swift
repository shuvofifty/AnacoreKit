//
//  GWTExpression.swift
//  AnacoreKitTests
//
//  Created by Shubroto Shuvo on 6/7/21.
//

import Foundation

protocol GWTExpression {}

private let gwtQueue = DispatchQueue(label: "gwt.queue", qos: .background)

extension GWTExpression {
    func given(_: String, in queue: DispatchQueue = gwtQueue, closure: () -> Void) {
        run(task: closure, in: queue)
    }
    
    func when(_: String, in queue: DispatchQueue = gwtQueue, closure: () -> Void) {
        run(task: closure, in: queue)
    }
    
    func then(_: String, in queue: DispatchQueue = gwtQueue, closure: () -> Void) {
        run(task: closure, in: queue)
    }
    
    private func run(task: () -> Void, in queue: DispatchQueue) {
        let currentQueue = OperationQueue.current?.underlyingQueue
        guard queue != currentQueue else {
            return task()
        }
        gwtQueue.sync(flags: .barrier, execute: task)
    }
}
