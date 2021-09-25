//
//  JRAAnimationHelper.swift
//  Anacore
//
//  Created by Shubroto Shuvo on 3/22/21.
//

import Foundation
import UIKit

/**
 Helper class for all the basic animation configuration to use on the elements
 
 - Animations which returns CAKeyframeAnimation must be added to layer by the caller. Reason for this if you want to do more customization you can do it indepndently after calling with the basic configs
 */
public class JRAAnimationHelper {
    
    /**
     This is how the element will act like will it enter or leave
     */
    public enum Entry {
        case Enter, Leave
    }
    
    /**
     This is from where the element will enter to the main position.
     
     - Example: If set top means the element will move top direction to its main position
     - There is no tight rule how to use this however, its always recommended to follow the standard.
     */
    public enum Direction {
        case top, bottom, left, right, none
    }
    
    /**
     This is the final position of the element
     
     - Example: If set start means no matter what the animation is the element will be at the start position like left or top
     - There is no tight rule how to use this however, its always recommended to follow the standard.
     */
    public enum Position {
        case start, center, end
    }
    
    /**
     This is the indication of moving from the main position or to the main position
     
     - Example: If set to **from** means the element will move from the main position
     */
    public enum Move {
        case from, to
    }
    
    static let shared = JRAAnimationHelper()
    
    private init() {}
    
    /**
     Fade in and Fade out animation with appropriate configuration
     
     - Parameters:
            - entry: Entry mode if enter or leave fading
            - duration: How long to finish the animation
     
     - Returns Key frame animation object to add it the view layer
     */
    public func fade(_ entry: Entry, duration: CFTimeInterval) -> CAKeyframeAnimation {
        let animation = CAKeyframeAnimation(keyPath: "opacity")
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        animation.duration = duration
        animation.repeatCount = 1
        switch entry {
        case .Enter:
            animation.values = [0,1]
        case .Leave:
            animation.values = [1,0]
        }
        animation.fillMode = .both
        animation.isRemovedOnCompletion = false
        return animation
    }
    
    public func move(_ moveDirection: Move, direction: Direction, offset: Double = 80.0, duration: CFTimeInterval) -> CAKeyframeAnimation {
        let animation = CAKeyframeAnimation()
        
        switch direction {
        case .top, .none, .bottom:
            animation.keyPath = "transform.translation.y"
        case .left, .right:
            animation.keyPath = "transform.translation.x"
        }
        
        switch moveDirection {
        case .from:
            animation.values = [0, offset]
        case .to:
            animation.values = [offset, 0]
        }
        animation.duration = duration
        animation.repeatCount = 1
        animation.fillMode = .both
        animation.isRemovedOnCompletion = false
        return animation
    }
}
