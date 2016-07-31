//
//  FetchChangesOperation.swift
//  OperationCloudKit
//
//  Created by Leo Tumwattana on 15/7/2016.
//  Copyright © 2016 Sorted Limited. All rights reserved.
//

import Operations
import CloudKit

class FetchChangesOperation: GroupOperation {
    
    static var token:CKServerChangeToken?
    
    init() {
        let op = FetchChangesOperation.makeFetchRecordChangesOperation()
        super.init(operations: [op])
        name = String(CKFetchRecordChangesOperation)
        qualityOfService = .UserInitiated
    }
    
    
    //override func willFinishOperation(operation: NSOperation) {
        //if let cloudKitOperation = operation as? CloudKitOperation<CKFetchRecordChangesOperation> {
            //if cloudKitOperation.moreComing {
                //self.queue.addOperation(FetchChangesOperation.makeFetchRecordChangesOperation())
            //}
        //}
        //super.willFinishOperation(operation)
    //}
    
    class func makeFetchRecordChangesOperation() -> CloudKitOperation<CKFetchRecordChangesOperation> {
        
        let op = CloudKitOperation { CKFetchRecordChangesOperation() }
        op.name = String(CloudKitOperation<CKFetchRecordChangesOperation>)
        op.container = CloudKit.container
        op.database = CloudKit.database
        op.recordZoneID = CloudKit.zoneID
        op.previousServerChangeToken = self.token
        
        op.recordChangedBlock = { record in
            print("Record fetched: \(record)")
        }
        
        op.recordWithIDWasDeletedBlock = { recordID in
            print("Record deleted: \(recordID.recordName)")
        }
        
        op.setFetchRecordChangesCompletionBlock { (serverChangeToken, clientChangeToken) in
            self.token = serverChangeToken
            print("ServerCT: \(serverChangeToken) ClientCT: \(clientChangeToken)")
            print("More records coming: \(op.moreComing)")
        }
        
        return op
    }
}


