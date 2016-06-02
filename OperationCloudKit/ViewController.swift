//
//  ViewController.swift
//  OperationCloudKit
//
//  Created by Leo Tumwattana on 31/5/2016.
//  Copyright © 2016 Sorted Limited. All rights reserved.
//

import UIKit
import Operations

class BlockGenerator: GeneratorType {
    func next() -> BlockOperation? {
        let op = BlockOperation(block: { (continueWithError) in
            print("LALA")
            continueWithError(error: nil)
        })
        
        let condition = BlockCondition { () -> Bool in
            return false
        }
        
        op.addCondition(condition)
        
        return op
    }
}

class CloudGenerator: GeneratorType {
    func next() -> CreateRecordOperation? {
        return CreateRecordOperation()
    }
}

class ViewController: UIViewController {
    
    let queue = OperationQueue()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ==============================================
        // Initial run to make sure we have a zone create
        // Note: You can comment this out after first run
        // and uncomment the second part to skip running
        // CreateZoneOperation()
        // ==============================================
        
        //let createZone = CreateZoneOperation()
        //let createRecord = CreateRecordOperation()
        //createRecord.addDependency(createZone)
        //queue.addOperations([createZone, createRecord])
        
        // ==============================================
        // Uncomment this after first run
        // ==============================================
        
        //let createRecord = CreateRecordOperation()
        //queue.addOperations([createRecord])
        
        // ======================================
        // NOTE: Basic retry operation works fine
        // ======================================
        
        //let retry  = RetryOperation<BlockOperation>(maxCount: 3,
            //strategy: .Random((0.1, 1.0)), BlockGenerator())
        //{ (info, stuff) -> (Delay?, BlockOperation)? in
            //return (stuff.0, stuff.1)
        //}
        
        //queue.addOperation(retry)
        
        // ======================================
        // NOTE: CloudKitOperations seems to fail
        // ======================================
        
        let retry = RetryOperation<CreateRecordOperation>(
            maxCount: 3,
            strategy: .Random((0.1, 1.0)),
            CloudGenerator()) { info, stuff -> (Delay?, CreateRecordOperation)? in
                return (stuff.0, stuff.1)
        }
        
        queue.addOperation(retry)
    }

}

