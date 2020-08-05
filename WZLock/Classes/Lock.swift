//
//  Lock.swift
//  WZLock
//
//  Created by xiaobin liu on 2019/8/27.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation

/// MARK - 锁协议
internal protocol Lock {
    
    /// 锁
    ///
    /// - Returns: return value description
    func lock()
    
    /// 结锁
    ///
    /// - Returns: return value description
    func unlock()
    
    /// 环绕
    ///
    /// - Parameter closure: 闭包
    /// - Returns: return value description
    func around<T>(_ closure: () -> T) -> T
    
    /// 环绕
    ///
    /// - Parameter closure: 闭包
    func around(_ closure: () -> Void)
}


// MARK: - 默认实现(环绕)
internal extension Lock {
    
    func around<T>(_ closure: () -> T) -> T {
        lock(); defer { unlock() }
        return closure()
    }
    
    func around(_ closure: () -> Void) {
        lock(); defer { unlock() }
        return closure()
    }
}
