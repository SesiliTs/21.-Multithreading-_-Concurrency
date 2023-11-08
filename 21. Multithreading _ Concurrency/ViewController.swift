//
//  ViewController.swift
//  21. Multithreading _ Concurrency
//
//  Created by Sesili Tsikaridze on 08.11.23.
//

import UIKit

final class ViewController: UIViewController {
    
    typealias BigInt = _BigInt<UInt>
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Task {
            await printWinnerThread()
        }
        
    }
    
    
    func factorial(_ n: Int) -> BigInt {
        if n <= 1 {
            return 1
        } else {
            return BigInt(n) * factorial(n - 1)
        }
    }
    
    func calculateFirstFactorial() async -> BigInt {
        let firstNum = Int.random(in: 20...25)
        return factorial(firstNum)
    }
    
    func calculateSecondFactorial() async -> BigInt {
        let secondNum = Int.random(in: 20...25)
        return factorial(secondNum)
    }
    
    func printWinnerThread() async {
        let startTime = DispatchTime.now()
        let firstFunc = await calculateFirstFactorial()
        let firstExecutionTime = Double(DispatchTime.now().uptimeNanoseconds - startTime.uptimeNanoseconds) / 1_000_000_000
        
        let startTime2 = DispatchTime.now()
        let secondFunc = await calculateSecondFactorial()
        let secondExecutionTime = Double(DispatchTime.now().uptimeNanoseconds - startTime2.uptimeNanoseconds) / 1_000_000_000
        
        if firstExecutionTime < secondExecutionTime {
            print("First factorial calculated faster: \(firstFunc)")
        } else {
            print("Second factorial calculated faster: \(secondFunc)")
        }
    }
    
}
