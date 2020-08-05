//
//  UnfairLock.swift
//  WZLock
//
//  Created by xiaobin liu on 2019/8/27.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation


/// MARK - UnfairLock
@available (iOS 10.0, macOS 10.12, tvOS 10.0, watchOS 3.0, *)
internal final class UnfairLock: Lock {
    private var unfairLock: os_unfair_lock_t
    
    public init() {
        unfairLock = .allocate(capacity: 1)
        unfairLock.initialize(to: os_unfair_lock())
    }
    
    internal func lock() {
        os_unfair_lock_lock(unfairLock)
    }
    
    internal func unlock() {
        os_unfair_lock_unlock(unfairLock)
    }
}
