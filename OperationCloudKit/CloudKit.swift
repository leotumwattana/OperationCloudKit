//
//  CloudKit.swift
//  OperationCloudKit
//
//  Created by Leo Tumwattana on 31/5/2016.
//  Copyright © 2016 Sorted Limited. All rights reserved.
//

import CloudKit

struct CloudKit {
    
    static let ZoneName = "CustomPrivateZone"
    
    static var container:CKContainer {
        return CKContainer.defaultContainer()
    }
    
    static var database: CKDatabase {
        return CKContainer.defaultContainer().privateCloudDatabase
    }
    
    static var zoneID:CKRecordZoneID {
        return CKRecordZoneID(zoneName: ZoneName, ownerName: CKOwnerDefaultName)
    }
    
    static var recordZone:CKRecordZone {
        return CKRecordZone(zoneID: zoneID)
    }
    
}
