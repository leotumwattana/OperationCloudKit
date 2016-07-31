////
////  StupidCondition.swift
////  OperationCloudKit
////
////  Created by Leo Tumwattana on 13/7/2016.
////  Copyright © 2016 Sorted Limited. All rights reserved.
////

//import Operations

//final class StupidCondition: Condition {
    
    //override init() {
        //super.init()
        
        //name = "CloudFeatureOn"
        //mutuallyExclusive = false
    //}
    
    //override func evaluate(operation: Operation, completion: CompletionBlockType) {
        //if true {
            //completion(.Failed(ConditionError.FalseCondition))
        //} else {
            //completion(.Satisfied)
        //}
    //}
    
//}

////struct ORCloudFeatureOnCondition: OperationCondition {

////static let name = "CloudFeatureOn"
////static let isMutuallyExclusive = false

////func dependencyForOperation(operation: Operation) -> NSOperation? {
////return nil
////}

////func evaluateForOperation(operation: Operation, completion: OperationConditionResult -> Void) {
////if Defaults[.iCloudEnabled] {
////completion(.Satisfied)
////} else {
////completion(.Failed(NSError(code: OperationErrorCode.ConditionFailed)))

////}
////}
////}