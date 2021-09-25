//
//  JRALogging.swift
//  AnacoreKit
//
//  Created by Shubroto Shuvo on 9/22/21.
//

import Foundation

/**
 For logging end to end event with an event key use this protocol in enum and let the framework hand rest
 
 - Register all end to end event key only with this protocol
 */
public protocol JRAEventKeyFlowLogProtocol {
    /**
     Get the flow of the event name that will be tracked from start
     
     - It should be Unique key that can be tracked
     */
    func getEventFlowKey() -> String
    /**
     Get the default description of the event key for more logging info
     */
    func getDefaultDescription() -> String
}

/**
 For logging end to end event with event action followed with key. Use this in action enum where it will send event action name
 
 - Register all end to end event action only with this protocol
 */
public protocol JRAEventActionFlowLogProtocol {
    /**
     Get the description or the data to log as string
     */
    func getActionDescription() -> String
}

public protocol JRALoggingEngineProtocol {
    /**
    Log basic data which don't have any keys
     
     - Parameters:
        - data: The data in string format to log
     */
    func log(_ data: String)
    
    /**
     Log with a key attached
     
     - Best ued for logging to some third party tools like dynatrace or app center
     
     - Parameters:
        - key: The key to map the logging
        - data: The data for logging
     */
    func log(with key: String, _ data: Any)
    
    /**
     Start the event flow with the event flow key
     
     - Parameters:
        - event: The unique event key id
        - description: Custom description if not default description will be added
     */
    func startEvent(for event: JRAEventKeyFlowLogProtocol, description: String?)
    /**
     Log action event for a partical event key
     
     - Parameters:
        - action: Action to log
        - event: Event key for the action to be associated with
     */
    func eventLog(_ action: JRAEventActionFlowLogProtocol, for event: JRAEventKeyFlowLogProtocol)
    /**
     Dispatch event to somewhere without destroying the logging store for the event key
     
     - Parameters:
        - event: The event key for logs to dispatch
     */
    func dispatchEvent(for event: JRAEventKeyFlowLogProtocol)
    /**
     End an event flow for a particular event key and clear the event key mapping
     
     - Parameters:
        - event: The event key for clearing out the log data
     */
    func endEvent(for event: JRAEventKeyFlowLogProtocol)
}

public protocol JRALoggingProtocol {
    /**
     Logging implementation injected from outside if something custom needed. If not **JRADefaultLogEngine** is used as default
     */
    var logEngine: JRALoggingEngineProtocol { get }
}

/**
 Helper class to log all your dev stuffs
 
 - Use this instead of basic print functionality for advance and easy level of logging
 - Inject your implementation class of how you want to display or do with the logs
 - Use the shared instance for logging and set delegate implementation in app delegate
 */
class JRALogging: JRALoggingProtocol {
    static let shared = JRALogging().logEngine
    
    public var logEngine: JRALoggingEngineProtocol
    
    private init() {
        logEngine = JRADefaultLogEngine()
    }
}

/**
 A default loggin engine from JRA for logging all the events or actions. This is injected in JRA Logging class by default. If you want to add your own implementation then directly set JRALogging -> logEngine value at the start of the app
 */
public class JRADefaultLogEngine: JRALoggingEngineProtocol {
    private var eventMap: [String:[String]] = [:]
    
    public func log(_ data: String) {
        print(data)
    }
    
    public func log(with key: String, _ data: Any) {
        print("\(key):- \(data)")
    }
    
    public func startEvent(for event: JRAEventKeyFlowLogProtocol, description: String?) {
        eventMap[event.getEventFlowKey()] = ["Started event: \(event.getEventFlowKey()). Description: \(description ?? event.getDefaultDescription())"]
    }
    
    public func eventLog(_ action: JRAEventActionFlowLogProtocol, for event: JRAEventKeyFlowLogProtocol) {
        if eventMap[event.getEventFlowKey()] == nil {
            startEvent(for: event, description: nil)
        }
        eventMap[event.getEventFlowKey()]?.append(action.getActionDescription())
    }
    
    public func dispatchEvent(for event: JRAEventKeyFlowLogProtocol) {
        var log = ""
        log += "JRALog: Dispatch for event \(event.getEventFlowKey())\n\n"
        for action in eventMap[event.getEventFlowKey()] ?? [] {
            log += "-> \(action)\n"
        }
        log += "JRALog: Ending dispatch event for \(event.getEventFlowKey())\n"
        print(log)
    }
    
    public func endEvent(for event: JRAEventKeyFlowLogProtocol) {
        eventMap.removeValue(forKey: event.getEventFlowKey())
    }
    
    
}
