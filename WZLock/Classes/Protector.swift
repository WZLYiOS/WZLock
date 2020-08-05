//
//  Protector.swift
//  WZLock_Example
//
//  Created by xiaobin liu on 2019/8/27.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation


/// MARK - 线程安全包装器
public final class Protector<T> {
    
    /// 值
    private var value: T
    
    /// 锁
    private let lock: Lock = {
        if #available(iOS 10.0, macOS 10.12, tvOS 10.0, watchOS 3.0, *) {
            return UnfairLock()
        } else {
            return MutexLock()
        }
    }()
    
    
    /// 初始化
    ///
    /// - Parameter value: value description
    public init(_ value: T) {
        self.value = value
    }
    
    /// 所包含的值。对于直接读写以外的任何操作都是不安全的
    public var directValue: T {
        get { return lock.around { value } }
        set { lock.around { value = newValue } }
    }
    
    /// 同步读取或转换包含的值
    ///
    /// - Parameter closure: The closure to execute.
    /// - Returns:           The return value of the closure passed.
    public func read<U>(_ closure: (T) -> U) -> U {
        return lock.around { closure(self.value) }
    }
    
    /// 同步修改受保护的值
    ///
    /// - Parameter closure: The closure to execute.
    /// - Returns:           The modified value.
    @discardableResult
    public func write<U>(_ closure: (inout T) -> U) -> U {
        return lock.around { closure(&self.value) }
    }
}


// MARK: - RangeReplaceableCollection
public extension Protector where T: RangeReplaceableCollection {
    
    /// 将新元素添加到此受保护集合的结尾
    ///
    /// - Parameter newElement: The `Element` to append.
    func append(_ newElement: T.Element) {
        write { (ward: inout T) in
            ward.append(newElement)
        }
    }
    
    /// 将序列的元素添加到此受保护集合的结尾
    ///
    /// - Parameter newElements: The `Sequence` to append.
    func append<S: Sequence>(contentsOf newElements: S) where S.Element == T.Element {
        write { (ward: inout T) in
            ward.append(contentsOf: newElements)
        }
    }
    
    /// 将集合的元素添加到受保护集合的结尾
    ///
    /// - Parameter newElements: The `Collection` to append.
    func append<C: Collection>(contentsOf newElements: C) where C.Element == T.Element {
        write { (ward: inout T) in
            ward.append(contentsOf: newElements)
        }
    }
}


// MARK: - Description
public extension Protector where T == Data? {
    
    /// 将数据值的内容添加到受保护数据的结尾
    ///
    /// - Parameter data: The `Data` to be appended.
    func append(_ data: Data) {
        write { (ward: inout T) in
            ward?.append(data)
        }
    }
}


// MARK: - Strideable
public extension Protector where T: Strideable {
    func advance(by stride: T.Stride) {
        write { (ward: inout T) in
            ward = ward.advanced(by: stride)
        }
    }
}
