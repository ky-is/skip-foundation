// Copyright 2023–2025 Skip
// SPDX-License-Identifier: LGPL-3.0-only WITH LGPL-3.0-linking-exception
import Foundation
import XCTest

#if false // no Skip support for NSOperationQueue

// These tests are adapted from https://github.com/apple/swift-corelibs-foundation/blob/main/Tests/Foundation/Tests which have the following license:


// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2016 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See http://swift.org/LICENSE.txt for license information
// See http://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//

import Dispatch

class TestOperationQueue : XCTestCase {
    
    func test_OperationCount() {
        #if SKIP
        throw XCTSkip("TODO")
        #else
        let queue = OperationQueue()
        let op1 = BlockOperation(block: { Thread.sleep(forTimeInterval: 2) })
        queue.addOperation(op1)
        XCTAssertEqual(queue.operationCount, 1)
        queue.waitUntilAllOperationsAreFinished()
        XCTAssertEqual(queue.operationCount, 0)

        let op2 = BlockOperation(block: { Thread.sleep(forTimeInterval: 0.5) })
        let op3 = BlockOperation(block: { Thread.sleep(forTimeInterval: 0.5) })
        queue.addOperation(op2)
        queue.addOperation(op3)
        XCTAssertEqual(queue.operationCount, 2)
        let operations = queue.operations
        XCTAssertEqual(operations.count, 2)
        if (operations.count == 2) {
            XCTAssertEqual(operations[0], op2)
            XCTAssertEqual(operations[1], op3)
        }
        queue.waitUntilAllOperationsAreFinished()
        XCTAssertEqual(queue.operationCount, 0)
        XCTAssertEqual(queue.operations.count, 0)
        #endif // !SKIP
    }

    func test_OperationPriorities() {
        #if SKIP
        throw XCTSkip("TODO")
        #else
        var msgOperations = [String]()
        let operation1 : BlockOperation = BlockOperation(block: {
            msgOperations.append("Operation1 executed")
        })
        let operation2 : BlockOperation = BlockOperation(block: {
            msgOperations.append("Operation2 executed")
        })
        let operation3 : BlockOperation = BlockOperation(block: {
            msgOperations.append("Operation3 executed")
        })
        let operation4: BlockOperation = BlockOperation(block: {
            msgOperations.append("Operation4 executed")
        })
        operation4.queuePriority = .veryLow
        operation3.queuePriority = .veryHigh
        operation2.queuePriority = .low
        operation1.queuePriority = .normal
        var operations = [Operation]()
        operations.append(operation1)
        operations.append(operation2)
        operations.append(operation3)
        operations.append(operation4)
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 1
        queue.addOperations(operations, waitUntilFinished: true)
        XCTAssertEqual(msgOperations[0], "Operation3 executed")
        XCTAssertEqual(msgOperations[1], "Operation1 executed")
        XCTAssertEqual(msgOperations[2], "Operation2 executed")
        XCTAssertEqual(msgOperations[3], "Operation4 executed")
        #endif // !SKIP
    }

    func test_isExecutingWorks() {
        #if SKIP
        throw XCTSkip("TODO")
        #else
        class _OperationBox {
            var operation: Operation?
            init() {
                self.operation = nil
            }
        }
        let queue = OperationQueue()
        let opBox = _OperationBox()
        let op = BlockOperation(block: { XCTAssertEqual(true, opBox.operation?.isExecuting) })
        opBox.operation = op
        XCTAssertFalse(op.isExecuting)

        queue.addOperation(op)
        queue.waitUntilAllOperationsAreFinished()
        XCTAssertFalse(op.isExecuting)

        opBox.operation = nil /* break the reference cycle op -> <closure> -> opBox -> op */
        #endif // !SKIP
    }

    func test_AsyncOperation() {
        #if SKIP
        throw XCTSkip("TODO")
        #else
        let operation = AsyncOperation()
        XCTAssertFalse(operation.isExecuting)
        XCTAssertFalse(operation.isFinished)

        operation.start()

        while !operation.isFinished {
            // do nothing
        }

        XCTAssertFalse(operation.isExecuting)
        XCTAssertTrue(operation.isFinished)
        #endif // !SKIP
    }
    
    func test_SyncOperationWithoutAQueue() {
        #if SKIP
        throw XCTSkip("TODO")
        #else
        let operation = SyncOperation()
        XCTAssertFalse(operation.isExecuting)
        XCTAssertFalse(operation.isFinished)

        operation.start()

        XCTAssertFalse(operation.isExecuting)
        XCTAssertTrue(operation.isFinished)
        XCTAssertTrue(operation.hasRun)
        #endif // !SKIP
    }
    
    func test_MainQueueGetter() {
        #if SKIP
        throw XCTSkip("TODO")
        #else
        XCTAssertTrue(OperationQueue.main === OperationQueue.main)
        
        /*
         This call is only to check if OperationQueue.main returns a living instance.
         There used to be a bug where subsequent OperationQueue.main call would return a "dangling pointer".
         */
        XCTAssertFalse(OperationQueue.main.isSuspended)
        #endif // !SKIP
    }
    
    func test_CancelOneOperation() {
        #if SKIP
        throw XCTSkip("TODO")
        #else
        var operations = [Operation]()
        var valueOperations = [Int]()
        for i in 0..<5 {
            let operation = BlockOperation {
                valueOperations.append(i)
                Thread.sleep(forTimeInterval: 2)
            }
            operations.append(operation)
        }
        
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 1
        queue.addOperations(operations, waitUntilFinished: false)
        operations.remove(at: 2).cancel()
        queue.waitUntilAllOperationsAreFinished()
        XCTAssertTrue(!valueOperations.contains(2))
        #endif // !SKIP
    }
    
    func test_CancelOperationsOfSpecificQueuePriority() {
        #if SKIP
        throw XCTSkip("TODO")
        #else
        var operations = [Operation]()
        var valueOperations = [Int]()
        
        let operation1 = BlockOperation {
            valueOperations.append(0)
            Thread.sleep(forTimeInterval: 2)
        }
        operation1.queuePriority = .high
        operations.append(operation1)
        
        let operation2 = BlockOperation {
            valueOperations.append(1)
            Thread.sleep(forTimeInterval: 2)
        }
        operation2.queuePriority = .high
        operations.append(operation2)
        
        let operation3 = BlockOperation {
            valueOperations.append(2)
        }
        operation3.queuePriority = .normal
        operations.append(operation3)
        
        let operation4 = BlockOperation {
            valueOperations.append(3)
        }
        operation4.queuePriority = .normal
        operations.append(operation4)
        
        let operation5 = BlockOperation {
            valueOperations.append(4)
        }
        operation5.queuePriority = .normal
        operations.append(operation5)
        
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 1
        queue.addOperations(operations, waitUntilFinished: false)
        for operation in operations {
            if operation.queuePriority == .normal {
                operation.cancel()
            }
        }
        queue.waitUntilAllOperationsAreFinished()
        XCTAssertTrue(valueOperations.count == 2)
        XCTAssertTrue(valueOperations[0] == 0)
        XCTAssertTrue(valueOperations[1] == 1)
        #endif // !SKIP
    }
    
    func test_CurrentQueueOnMainQueue() {
        #if SKIP
        throw XCTSkip("TODO")
        #else
        XCTAssertTrue(OperationQueue.main === OperationQueue.current)
        #endif // !SKIP
    }
    
    func test_CurrentQueueOnBackgroundQueue() {
        #if SKIP
        throw XCTSkip("TODO")
        #else
        let expectation = self.expectation(description: "Background execution")
        
        let operationQueue = OperationQueue()
        operationQueue.addOperation {
            XCTAssertEqual(operationQueue, OperationQueue.current)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1)
        #endif // !SKIP
    }
    
    func test_CurrentQueueOnBackgroundQueueWithSelfCancel() {
        #if SKIP
        throw XCTSkip("TODO")
        #else
        let operationQueue = OperationQueue()
        operationQueue.maxConcurrentOperationCount = 1
        let expectation = self.expectation(description: "Background execution")
        operationQueue.addOperation {
            XCTAssertEqual(operationQueue, OperationQueue.current)
            expectation.fulfill()
            // Canceling operation X from inside operation X should not cause the app to a crash
            operationQueue.cancelAllOperations()
        }
        
        waitForExpectations(timeout: 1)
        #endif // !SKIP
    }

    func test_CurrentQueueWithCustomUnderlyingQueue() {
        #if SKIP
        throw XCTSkip("TODO")
        #else
        let expectation = self.expectation(description: "Background execution")

        let operationQueue = OperationQueue()
        let underlyingQueue = DispatchQueue(label: "underlying_queue")
        operationQueue.underlyingQueue = underlyingQueue

        operationQueue.addOperation {
            XCTAssertEqual(operationQueue, OperationQueue.current)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1)
        #endif // !SKIP
    }
    
    func test_isSuspended() {
        #if SKIP
        throw XCTSkip("TODO")
        #else
        let expectation1 = self.expectation(description: "DispatchQueue execution")
        let expectation2 = self.expectation(description: "OperationQueue execution")
        
        let dispatchQueue = DispatchQueue(label: "underlying_queue")
        let operationQueue = OperationQueue()
        operationQueue.maxConcurrentOperationCount = 1
        operationQueue.underlyingQueue = dispatchQueue
        operationQueue.isSuspended = true
        
        operationQueue.addOperation {
            XCTAssert(OperationQueue.current?.underlyingQueue === dispatchQueue)
            expectation2.fulfill()
        }
        
        dispatchQueue.async {
            operationQueue.isSuspended = false
            expectation1.fulfill()
        }
        
        waitForExpectations(timeout: 1)
        #endif // !SKIP
    }
    
    func test_CurrentQueueWithUnderlyingQueueResetToNil() {
        #if SKIP
        throw XCTSkip("TODO")
        #else
        let expectation = self.expectation(description: "Background execution")
        
        let operationQueue = OperationQueue()
        let underlyingQueue = DispatchQueue(label: "underlying_queue")
        operationQueue.underlyingQueue = underlyingQueue
        operationQueue.underlyingQueue = nil
        
        operationQueue.addOperation {
            XCTAssertEqual(operationQueue, OperationQueue.current)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1)
        #endif // !SKIP
    }
    
    func test_OperationDependencyCount() {
        #if SKIP
        throw XCTSkip("TODO")
        #else
        var results = [Int]()
        let op1 = BlockOperation {
            results.append(1)
        }
        op1.name = "op1"
        let op2 = BlockOperation {
            results.append(2)
        }
        op2.name = "op2"
        op1.addDependency(op2)
        XCTAssert(op1.dependencies.count == 1)
        #endif // !SKIP
    }
    
    func test_CancelDependency() {
        #if SKIP
        throw XCTSkip("TODO")
        #else
        let expectation = self.expectation(description: "Operation should finish")

        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 1

        let op1 = BlockOperation() {
            XCTAssert(false, "Should not run")
        }
        let op2 = BlockOperation() {
            expectation.fulfill()
        }

        op2.addDependency(op1)
        op1.cancel()

        queue.addOperation(op1)
        queue.addOperation(op2)

        waitForExpectations(timeout: 1)
        #endif // !SKIP
    }

    func test_Deadlock() {
        #if SKIP
        throw XCTSkip("TODO")
        #else
        let expectation1 = self.expectation(description: "Operation should finish")
        let expectation2 = self.expectation(description: "Operation should finish")

        let op1 = BlockOperation {
            expectation1.fulfill()
        }
        op1.name = "op1"

        let op2 = BlockOperation {
            expectation2.fulfill()
        }
        op2.name = "op2"

        op1.addDependency(op2)

        // Narrow scope to force early release of queue object
        _ = {
            let queue = OperationQueue()
            queue.maxConcurrentOperationCount = 1
            queue.addOperation(op1)
            queue.addOperation(op2)
        }()

        waitForExpectations(timeout: 1)
        Thread.sleep(forTimeInterval: 1)
        #endif // !SKIP
    }

    public func test_CancelOutOfQueue() {
        #if SKIP
        throw XCTSkip("TODO")
        #else
        let op = Operation()
        op.cancel()

        XCTAssert(op.isCancelled)
        XCTAssertFalse(op.isExecuting)
        XCTAssertFalse(op.isFinished)
        #endif // !SKIP
    }

    public func test_CrossQueueDependency() {
        #if SKIP
        throw XCTSkip("TODO")
        #else
        let queue = OperationQueue()
        let queue2 = OperationQueue()

        let expectation1 = self.expectation(description: "Operation should finish")
        let expectation2 = self.expectation(description: "Operation should finish")

        let op1 = BlockOperation {
            expectation1.fulfill()
        }
        op1.name = "op1"

        let op2 = BlockOperation {
            expectation2.fulfill()
        }
        op2.name = "op2"

        op1.addDependency(op2)

        queue.addOperation(op1)
        queue2.addOperation(op2)

        waitForExpectations(timeout: 1)
        #endif // !SKIP
    }

    public func test_CancelWhileSuspended() {
        #if SKIP
        throw XCTSkip("TODO")
        #else
        let queue = OperationQueue()
        queue.isSuspended = true

        let op1 = BlockOperation {}
        op1.name = "op1"

        let op2 = BlockOperation {}
        op2.name = "op2"

        queue.addOperation(op1)
        queue.addOperation(op2)

        op1.cancel()
        op2.cancel()

        queue.isSuspended = false
        queue.waitUntilAllOperationsAreFinished()

        XCTAssert(op1.isCancelled)
        XCTAssertFalse(op1.isExecuting)
        XCTAssert(op1.isFinished)
        XCTAssert(op2.isCancelled)
        XCTAssertFalse(op2.isExecuting)
        XCTAssert(op2.isFinished)
        #endif // !SKIP
    }

    public func test_OperationOrder() {
        #if SKIP
        throw XCTSkip("TODO")
        #else
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 1
        queue.isSuspended = true

        var array = [Int]()

        let op1 = BlockOperation {
            array.append(1)
        }
        op1.queuePriority = .normal
        op1.name = "op1"

        let op2 = BlockOperation {
            array.append(2)
        }
        op2.queuePriority = .normal
        op2.name = "op2"

        let op3 = BlockOperation {
            array.append(3)
        }
        op3.queuePriority = .normal
        op3.name = "op3"

        let op4 = BlockOperation {
            array.append(4)
        }
        op4.queuePriority = .normal
        op4.name = "op4"

        let op5 = BlockOperation {
            array.append(5)
        }
        op5.queuePriority = .normal
        op5.name = "op5"

        queue.addOperation(op1)
        queue.addOperation(op2)
        queue.addOperation(op3)
        queue.addOperation(op4)
        queue.addOperation(op5)

        queue.isSuspended = false
        queue.waitUntilAllOperationsAreFinished()

        XCTAssertEqual(array, [1, 2, 3, 4, 5])
        #endif // !SKIP
    }

    public func test_OperationOrder2() {
        #if SKIP
        throw XCTSkip("TODO")
        #else
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 1
        queue.isSuspended = true

        var array = [Int]()

        let op1 = BlockOperation {
            array.append(1)
        }
        op1.queuePriority = .veryLow
        op1.name = "op1"

        let op2 = BlockOperation {
            array.append(2)
        }
        op2.queuePriority = .low
        op2.name = "op2"

        let op3 = BlockOperation {
            array.append(3)
        }
        op3.queuePriority = .normal
        op3.name = "op3"

        let op4 = BlockOperation {
            array.append(4)
        }
        op4.queuePriority = .high
        op4.name = "op4"

        let op5 = BlockOperation {
            array.append(5)
        }
        op5.queuePriority = .veryHigh
        op5.name = "op5"

        queue.addOperation(op1)
        queue.addOperation(op2)
        queue.addOperation(op3)
        queue.addOperation(op4)
        queue.addOperation(op5)

        queue.isSuspended = false
        queue.waitUntilAllOperationsAreFinished()

        XCTAssertEqual(array, [5, 4, 3, 2, 1])
        #endif // !SKIP
    }

    func test_ExecutionOrder() {
        #if SKIP
        throw XCTSkip("TODO")
        #else
        let queue = OperationQueue()
        
        let didRunOp1 = expectation(description: "Did run first operation")
        let didRunOp1Dependency = expectation(description: "Did run first operation dependency")
        let didRunOp2 = expectation(description: "Did run second operation")
        var didRunOp1DependencyFirst = false
        
        let op1 = BlockOperation {
            didRunOp1.fulfill()
            XCTAssertTrue(didRunOp1DependencyFirst, "Dependency should be executed first")
        }
        let op1Dependency = BlockOperation {
            didRunOp1Dependency.fulfill()
            didRunOp1DependencyFirst = true
        }
        op1.addDependency(op1Dependency)
        queue.addOperations([op1, op1Dependency], waitUntilFinished: false)
        
        queue.addOperation {
            didRunOp2.fulfill()
        }
        
        waitForExpectations(timeout: 1.0)
        #endif // !SKIP
    }

    func test_WaitUntilFinished() {
        #if SKIP
        throw XCTSkip("TODO")
        #else
        let queue1 = OperationQueue()
        let queue2 = OperationQueue()

        let op1 = BlockOperation {Thread.sleep(forTimeInterval: 1) }
        let op2 = BlockOperation { }

        op2.addDependency(op1)

        queue1.addOperation(op1)
        queue2.addOperation(op2)

        queue2.waitUntilAllOperationsAreFinished()
        XCTAssertEqual(queue2.operationCount, 0)
        #endif // !SKIP
    }

    func test_OperationWaitUntilFinished() {
        #if SKIP
        throw XCTSkip("TODO")
        #else
        let queue1 = OperationQueue()
        let op1 = BlockOperation { Thread.sleep(forTimeInterval: 1) }
        queue1.addOperation(op1)
        op1.waitUntilFinished()
        
        // Operation is not removed from Queue simultaneously
        // with transitioning to "Finished" state. Wait a bit
        // to allow OperationQueue to deal with finished op.
        Thread.sleep(forTimeInterval: 0.1)
        XCTAssertEqual(queue1.operationCount, 0)
        #endif // !SKIP
    }

    func test_CustomOperationReady() {
        #if SKIP
        throw XCTSkip("TODO")
        #else
//        class CustomOperation: Operation {
//
//            private var _isReady = false
//
//            override var isReady: Bool {
//                return _isReady
//            }
//
//            func setIsReady() {
//                willChangeValue(forKey: "isReady")
//                _isReady = true
//                didChangeValue(forKey: "isReady")
//            }
//
//        }
//
//        let expectation = self.expectation(description: "Operation should finish")
//
//        let queue1 = OperationQueue()
//        let op1 = CustomOperation()
//        let op2 = BlockOperation(block: {
//            expectation.fulfill()
//        })
//
//        queue1.addOperation(op1)
//        queue1.addOperation(op2)
//
//        waitForExpectations(timeout: 1)
//
//        XCTAssertEqual(queue1.operationCount, 1)
//        op1.setIsReady()
//        queue1.waitUntilAllOperationsAreFinished()
//        XCTAssertEqual(queue1.operationCount, 0)
        #endif // !SKIP
    }

    func test_DependencyCycleBreak() {
        #if SKIP
        throw XCTSkip("TODO")
        #else
        let op1DidRun = expectation(description: "op1 supposed to be run")
        let op2DidRun = expectation(description: "op2 supposed to be run")
        let op2Finished = expectation(description: "op2 supposed to be finished")
        let op3Cancelled = expectation(description: "op3 supposed to be cancelled")
        let op3DidRun = expectation(description: "op3 is not supposed to be run")
        op3DidRun.isInverted = true

        var op1: Operation!
        var op2: Operation!
        var op3: Operation!

        let queue1 = OperationQueue()
        op1 = BlockOperation {
            op1DidRun.fulfill()
            if op2.isFinished {
                op2Finished.fulfill()
            }
        }
        op2 = BlockOperation {
            op2DidRun.fulfill()
            if op3.isCancelled {
                op3Cancelled.fulfill()
            }
        }
        op3 = BlockOperation {
            op3DidRun.fulfill()
        }

        // Create dependency cycle
        op1.addDependency(op2)
        op2.addDependency(op3)
        op3.addDependency(op1)

        queue1.addOperation(op1)
        queue1.addOperation(op2)
        queue1.addOperation(op3)

        XCTAssertEqual(queue1.operationCount, 3)

        //Break dependency cycle
        op3.cancel()

        waitForExpectations(timeout: 1)
        #endif // !SKIP
    }

    func test_Lifecycle() {
        #if SKIP
        throw XCTSkip("TODO")
        #else
        let opStarted = expectation(description: "Operation supposed to start")
        let opDone = expectation(description: "Operation supposed to be done")

        let op1 = BlockOperation {
            Thread.sleep(forTimeInterval: 0.3)
        }
        let op2 = BlockOperation {
            opStarted.fulfill()
            Thread.sleep(forTimeInterval: 0.3)
            opDone.fulfill()
        }

        op1.addDependency(op2)

        weak var weakQueue: OperationQueue?
        _ = {
            let queue = OperationQueue()
            weakQueue = queue
            queue.addOperation(op1)
            queue.addOperation(op2)
        }()

        wait(for: [opStarted], timeout: 1)
        op2.cancel()
        wait(for: [opDone], timeout: 1)

        Thread.sleep(forTimeInterval: 1) // Let queue to be deallocated
        XCTAssertNil(weakQueue, "Queue should be deallocated at this point")
        #endif // !SKIP
    }

    func test_ConcurrentOperations() {
        #if SKIP
        throw XCTSkip("TODO")
        #else
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 2
        
        // Running several iterations helps to reveal use-after-dealloc crashes
        for _ in 0..<3 {
            let didRunOp1 = expectation(description: "Did run first operation")
            let didRunOp2 = expectation(description: "Did run second operation")
            
            queue.addOperation {
                self.wait(for: [didRunOp2], timeout: 0.2)
                didRunOp1.fulfill()
            }
            queue.addOperation {
                didRunOp2.fulfill()
            }
            
            self.wait(for: [didRunOp1], timeout: 0.3)
        }
        #endif // !SKIP
    }

    func test_ConcurrentOperationsWithDependenciesAndCompletions() {
        #if SKIP
        throw XCTSkip("TODO")
        #else
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 2
        
        // Running several iterations helps to reveal use-after-dealloc crashes
        for _ in 0..<3 {
            let didRunOp1 = expectation(description: "Did run first operation")
            let didRunOp1Completion = expectation(description: "Did run first operation completion")
            let didRunOp1Dependency = expectation(description: "Did run first operation dependency")
            let didRunOp2 = expectation(description: "Did run second operation")
            
            let op1 = BlockOperation {
                self.wait(for: [didRunOp1Dependency, didRunOp2], timeout: 0.2)
                didRunOp1.fulfill()
            }
            op1.completionBlock = {
                didRunOp1Completion.fulfill()
            }
            let op1Dependency = BlockOperation {
                didRunOp1Dependency.fulfill()
            }
            queue.addOperations([op1, op1Dependency], waitUntilFinished: false)
            queue.addOperation {
                didRunOp2.fulfill()
            }
            
            self.wait(for: [didRunOp1, didRunOp1Completion], timeout: 0.3)
        }
        #endif // !SKIP
    }

    func test_BlockOperationAddExecutionBlock() {
        #if SKIP
        throw XCTSkip("TODO")
        #else
        let block1Expectation = expectation(description: "Block 1 executed")
        let block2Expectation = expectation(description: "Block 2 executed")
        
        let blockOperation = BlockOperation {
            block1Expectation.fulfill()
        }
        blockOperation.addExecutionBlock {
            block2Expectation.fulfill()
        }
        XCTAssert(blockOperation.executionBlocks.count == 2)
        let queue = OperationQueue()
        queue.addOperation(blockOperation)
        waitForExpectations(timeout: 1.0)
        #endif // !SKIP
    }
}

#if !SKIP
class AsyncOperation: Operation {

    private let queue = DispatchQueue(label: "async.operation.queue")
    private let lock = NSLock()

    private var _executing = false
    private var _finished = false

    override var isExecuting: Bool {
        get {
            lock.lock()
            let wasExecuting = _executing
            lock.unlock()
            return wasExecuting
        }
        set {
            if isExecuting != newValue {
                willChangeValue(forKey: "isExecuting")
                lock.lock()
                _executing = newValue
                lock.unlock()
                didChangeValue(forKey: "isExecuting")
            }
        }
    }

    override var isFinished: Bool {
        get {
            lock.lock()
            let wasFinished = _finished
            lock.unlock()
            return wasFinished
        }
        set {
            if isFinished != newValue {
                willChangeValue(forKey: "isFinished")
                lock.lock()
                _finished = newValue
                lock.unlock()
                didChangeValue(forKey: "isFinished")
            }
        }
    }

    override var isAsynchronous: Bool {
        return true
    }

    override func start() {
        #if SKIP
        throw XCTSkip("TODO")
        #else
        if isCancelled {
            isFinished = true
            return
        }

        isExecuting = true

        queue.async {
            Thread.sleep(forTimeInterval: 1)
            self.isExecuting = false
            self.isFinished = true
        }
        #endif // !SKIP
    }

}
#endif

class SyncOperation: Operation {

    var hasRun = false

    #if !SKIP
    override func main() {
        #if SKIP
        throw XCTSkip("TODO")
        #else
        Thread.sleep(forTimeInterval: 1)
        hasRun = true
        #endif // !SKIP
    }
    #endif

}


#endif

