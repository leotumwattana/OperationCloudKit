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
        
        let createRecordOperation = CloudKitOperation { CKModifyRecordsOperation() }
        createRecordOperation.name = "CreateRecordCloudKitOperation"
        createRecordOperation.savePolicy = .ChangedKeys
        createRecordOperation.qualityOfService = .UserInitiated
        createRecordOperation.recordsToSave = records
        createRecordOperation.recordIDsToDelete = nil
        createRecordOperation.container = CloudKit.container
        createRecordOperation.database = CloudKit.database
        
        createRecordOperation.setModifyRecordsCompletionBlock { (recordsSaved, recordIdsDeleted) in
            
            let recordTitles = recordsSaved?.map { record in record["Title"] }
            print("Create Record: \(recordTitles)")
        }
        
        // Setting this will cause the crash!
        createRecordOperation.setErrorHandlerForLimitExceeded()
        
        super.init(operations: [createRecordOperation])
        
        name = "CreateRecordOperation"
        qualityOfService = .UserInitiated
    }
}


