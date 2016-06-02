//
//  CreateRecordOperation.swift
//  OperationCloudKit
//
//  Created by Leo Tumwattana on 31/5/2016.
//  Copyright © 2016 Sorted Limited. All rights reserved.
//

import CloudKit
import Operations

class CreateRecordOperation: GroupOperation {
    
    init() {
        
        let records:[CKRecord] = (1...500).map { i in
            let id = NSUUID().UUIDString
            let recordID = CKRecordID(recordName: id, zoneID: CloudKit.zoneID)
            let record = CKRecord(recordType: "Item", recordID: recordID)
            record["Title"] = "This is item number \(i)"
            return record
        }
        
        let op = CKModifyRecordsOperation(
            recordsToSave: records,
            recordIDsToDelete: nil)
        
        op.savePolicy = .ChangedKeys
        op.qualityOfService = .UserInitiated
        
        let createRecordOperation = CloudKitOperation { op }
        createRecordOperation.name = "CreateRecordCloudKitOperation"
        createRecordOperation.container = CloudKit.container
        createRecordOperation.database = CloudKit.database
        
        createRecordOperation.setModifyRecordsCompletionBlock { (recordsSaved, recordIdsDeleted) in
            print("Create Record: \(recordsSaved) Records Deleted: \(recordIdsDeleted)")
        }
        
        // Setting this will cause the crash!
        //createRecordOperation.setErrorHandlerForLimitExceeded()
        
        createRecordOperation.setErrorHandlerForCode(.LimitExceeded) {
            (operation, error, log, suggested) ->
            (delay: Delay?, configure: OPRCKOperation<CKModifyRecordsOperation> -> Void)? in
            
            let configure = { (rhs: OPRCKOperation<CKModifyRecordsOperation>) in
                
                suggested.configure(rhs)
                
                rhs.recordsToSave = operation.recordsToSave
                rhs.recordIDsToDelete = operation.recordIDsToDelete
            }
            
            return (Delay.By(1), configure)
        }
        
        super.init(operations: [createRecordOperation])
        
        name = "CreateRecordOperation"
        qualityOfService = .UserInitiated
    }
}


