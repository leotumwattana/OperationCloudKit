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
        
        // ==============================================
        // Initial run to make sure we have a zone create
        // Note: You can comment this out after first run
        // and uncomment the second part to skip running
        // CreateZoneOperation()
        // ==============================================
        
        let createZone = CreateZoneOperation()
        let createRecord = CreateRecordOperation()
        createRecord.addDependency(createZone)
        queue.addOperations([createZone, createRecord])
        
        // ==============================================
        // Uncomment this after first run
        // ==============================================
        
        //let createRecord = CreateRecordOperation()
        //queue.addOperations([createRecord])
    }

}

