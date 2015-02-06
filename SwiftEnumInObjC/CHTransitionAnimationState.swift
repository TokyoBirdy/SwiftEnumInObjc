//
//  CHTransitionAnimationState.swift
//  SwiftEnumInObjC
//
//  Created by Cecilia Humlelu on 06/02/15.
//  Copyright (c) 2015 Cecilia Humlelu. All rights reserved.
//

import UIKit

private let CHTransitionAnimationStatePush = CHTransitionAnimationState(0)
private let CHTransitionAnimationStateRotate = CHTransitionAnimationState(1)

@objc public class CHTransitionAnimationState: DebugPrintable,Printable,Equatable {
    let value: Int
    private init(_ val:Int){value = val}
    class var Push:CHTransitionAnimationState {return CHTransitionAnimationStatePush}
    class var Rotate:CHTransitionAnimationState {return CHTransitionAnimationStateRotate}
    
    public  var description:String {
        switch self.value {
        case 0:  return "CHTransitionAnimationStatePush"
        case 1:  return "CHTransitionAnimationStateRotate"
        default: return "No State"
        }
    }
    public  var debugDescription:String { return self.description + ", value: \(self.value)" }
}

public func ==(lhs:CHTransitionAnimationState, rhs:CHTransitionAnimationState) -> Bool { return lhs.value == rhs.value }