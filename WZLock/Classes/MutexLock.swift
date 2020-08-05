//
//  MutexLock.swift
//  WZLock
//
//  Created by xiaobin liu on 2019/8/27.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation


/// MARK - 互斥锁
internal final class MutexLock: Lock {
    
    /// 互斥锁对象
    private var mutex = pthread_mutex_t()
    
    
    /// 初始化
    init() {
        let result = pthread_mutex_init(&mutex, nil)
        precondition(result == 0, "Failed to create pthread mutex")
    }
    
    
    /// 锁
    internal func lock() {
        let result = pthread_mutex_lock(&mutex)
        assert(result == 0, "Failed to lock mutex")
    }
    
    
    /// 解锁
    internal func unlock() {
        let result = pthread_mutex_unlock(&mutex)
        assert(result == 0, "Failed to unlock mutex")
    }
    
    deinit {
        let result = pthread_mutex_destroy(&mutex)
        assert(result == 0, "Failed to destroy mutex")
    }
}
