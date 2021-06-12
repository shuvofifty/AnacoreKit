//
//  JRABaseModal.swift
//  Anacore
//
//  Created by Shubroto Shuvo on 3/31/21.
//

import Foundation
import UIKit

/**
 All popup modal should be part of this class. JRAOverlay only use this type to display modal
 */
open class JRABaseModal: UIView {
    
    /**
     All view of the modal including design and everything will go underneath this
     */
    lazy open var baseView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    /**
     Delegate for passing event or other general function. Check the protocol for all the functions
     */
    public var delegate: JRABaseModalGeneralProtocol?
    /// BaseView Constraint for spacing from main modal view
    public var baseViewConstraint: JRAConstraintStruct = JRAConstraintStruct()
    
    private var id: String = ""
    
    init(id: String) {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.id = id
        
        // Setup UI
        self.addSubview(baseView)
        
        baseViewConstraint = baseView.jraLayoutHookToAllSide(of: self)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension JRABaseModal {
    open func modalWillShow() {
        delegate?.jraBaseModalGeneralModal(willShow: self, id: id)
    }
    
    open func modalDidShow() {
        delegate?.jraBaseModalGeneralModal(didShow: self, id: id)
    }
    
    open func modalWillHide() {
        delegate?.jraBaseModalGeneralModal(willHide: self, id: id)
    }
    
    open func modalDidHide() {
        delegate?.jraBaseModalGeneralModal(didHide: self, id: id)
    }
}

public protocol JRABaseModalGeneralProtocol {
    /**
     Used in the modal to send event back to the caller or parent when any action is done inside the modal.
     
     - It can be used for anything to send event back and use id to uniquely identify modal instead of comparing two modal object
     
     - Parameters:
        - modal: Reference of the modal object in order to control any element inside if necessary or compare modal object
        - id: An unique to identify the modal which should be done during intialization
        - eventId: An unique id to pass about the event
        - object: Any object to pass to the caller
     
     */
    func jraBaseModalGeneralSendAction(_ modal: JRABaseModal, id: String, eventId: String, object: Any)
    /**
     Delegate function when the modal will be shown with unique id
     
     - Parameters:
        - modal: Reference of the modal
        - id: An unique id to identify the modal
     */
    func jraBaseModalGeneralModal(willShow modal: JRABaseModal, id: String)
    /**
     Delegate function when the modal did shown with unique id
     
     - Parameters:
        - modal: Reference of the modal
        - id: An unique id to identify the modal
     */
    func jraBaseModalGeneralModal(didShow modal: JRABaseModal, id: String)
    /**
     Delegate function when the modal will be hidden with unique id
     
     - Parameters:
        - modal: Reference of the modal
        - id: An unique id to identify the modal
     */
    func jraBaseModalGeneralModal(willHide modal: JRABaseModal, id: String)
    /**
     Delegate function when the modal did hide with unique id
     
     - Parameters:
        - modal: Reference of the modal
        - id: An unique id to identify the modal
     */
    func jraBaseModalGeneralModal(didHide modal: JRABaseModal, id: String)
    
}

extension JRABaseModalGeneralProtocol {
    func jraBaseModalGeneralSendAction(_ modal: JRABaseModal, id: String, eventId: String, object: Any) {/* Default */}
    func jraBaseModalGeneralModal(willShow modal: JRABaseModal, id: String) {/* Default */}
    func jraBaseModalGeneralModal(didShow modal: JRABaseModal, id: String) {/* Default */}
    func jraBaseModalGeneralModal(willHide modal: JRABaseModal, id: String) {/* Default */}
    func jraBaseModalGeneralModal(didHide modal: JRABaseModal, id: String) {/* Default */}
    
}
