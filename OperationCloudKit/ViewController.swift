//
//  ViewController.swift
//  OperationCloudKit
//
//  Created by Leo Tumwattana on 31/5/2016.
//  Copyright © 2016 Sorted Limited. All rights reserved.
//

import UIKit
import Operations

class ViewController: UIViewController {
    
    let queue = OperationQueue()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let createZone = CreateZoneOperation()
        let createRecord = CreateRecordOperation()
        
        createRecord.addDependency(createZone)
        
        queue.addOperations([createZone, createRecord])
    }

}

