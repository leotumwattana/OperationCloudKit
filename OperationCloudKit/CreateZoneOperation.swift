//
//  CreateZoneOperation.swift
//  OperationCloudKit
//
//  Created by Leo Tumwattana on 31/5/2016.
//  Copyright © 2016 Sorted Limited. All rights reserved.
//

import CloudKit
import Operations

final class CreateZoneOperation: GroupOperation {
    
    init() {
        
        // Setup CKOperation
        let modifyRecordZonesOperation = CKModifyRecordZonesOperation(
            recordZonesToSave: [CloudKit.recordZone],
            recordZoneIDsToDelete: nil) //[ORCloudKit.zoneID])
        
        modifyRecordZonesOperation.name = "ModifyRecordZonesOperation"
        modifyRecordZonesOperation.qualityOfService = .UserInitiated
        
        // Create composed operation
        let createZoneOperation = CloudKitOperation { modifyRecordZonesOperation }
        createZoneOperation.name = "CreateZoneOperation"
        createZoneOperation.qualityOfService = .UserInitiated
        
        createZoneOperation.container = CloudKit.container
        createZoneOperation.database = CloudKit.database
        
        // Handle success
        createZoneOperation.setModifyRecordZonesCompletionBlock {
            (recordZonesSaved, recordZoneIdDeleted) in
            print("Zone Setup Operation: \(recordZonesSaved) \(recordZoneIdDeleted)")
        }
        
        super.init(operations: [createZoneOperation])
        name = "ZoneSetupOperation"
        qualityOfService = .UserInitiated
    }
    
}
