//
//  ViewController.swift
//  WZLock
//
//  Created by LiuSky on 08/27/2019.
//  Copyright (c) 2019 LiuSky. All rights reserved.
//

import UIKit
import WZLock

class ViewController: UIViewController {

    /// 并发队列
    private lazy var concurrentQueue = DispatchQueue(label: "concurrentQueue", attributes: DispatchQueue.Attributes.concurrent)
    
    public var protector = Protector<String>("")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        asyncConcurrent()
    }
    
    /**
     * 异步执行 + 并发队列
     * 特点：可以开启多个线程，任务交替（同时）执行。
     */
    private func asyncConcurrent() {
        
        // 打印当前线程
        debugPrint("currentThread---\(Thread.current)")
        debugPrint("asyncConcurrent---begin")
        
        concurrentQueue.async {
            
            // 追加任务1
            (0...2).forEach { (index) in
                Thread.sleep(forTimeInterval: 2) // 模拟耗时操作
                let result = "我是\(index)"
                debugPrint(result)
                self.protector.directValue = result
                debugPrint(self.protector.directValue)
                debugPrint("1---\(Thread.current)") // 打印当前线程
            }
        }
        
        concurrentQueue.async {
            
            // 追加任务2
            (3...5).forEach { (index) in
                Thread.sleep(forTimeInterval: 2) // 模拟耗时操作
                let result = "我是\(index)"
                debugPrint(result)
                self.protector.directValue = result
                debugPrint(self.protector.directValue)
                debugPrint("2---\(Thread.current)") // 打印当前线程
            }
        }
        
        
        concurrentQueue.async {
            
            // 追加任务3
            (6...8).forEach { (index) in
                
                Thread.sleep(forTimeInterval: 2) // 模拟耗时操作
                let result = "我是\(index)"
                debugPrint(result)
                self.protector.directValue = result
                debugPrint(self.protector.directValue)
                debugPrint("3---\(Thread.current)") // 打印当前线程
            }
        }
        
        debugPrint("asyncConcurrent---end")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

