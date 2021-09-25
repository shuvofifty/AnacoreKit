//
//  JRAOverlay.swift
//  Anacore
//
//  Created by Shubroto Shuvo on 3/21/21.
//

import Foundation
import UIKit

/**
 Overlay for the modal to display on. Each overlay is separate from the modal and modals have to be injected into overlay which will be responsible to show the modal.
 
 - **How to Use**:
    - First intialize with the desired style and background color
    - Set the delegate and id, if you want to hook some custom code after events. Check the protocol **JRAOverlayProtocols**
    - Second, call setOn(). Set the view param if you want to set the overlay on something else otherwise it will set on keywindow
    - Third, call the showOverlay() to show the overlay and hideOverlay to hide the overlay
    - If you want to call the modal, then use showModal() directly which will open Overlay with it if not opened
 - ** IMPORTANT **
    - All modal shown here will be part of **JRABaseModal**
    - The base constraint of the modal is set from the overlay which is hooked to sides at 0 constraint
        - All your design of the modal should be in a seperate view instead of the main modal view and add constraint on that seperate view to the main modal for your desired padding or coloring
 - Can be used for multiple modal display under one overlay
 - Use delegate to add codes on the different point of action
 */
open class JRAOverlay: UIView {
    private let loggingKey = "JRAOverlay"
    
    /**
     Configuration setting for the modal in JRAOverlay. Feel free to change the default value to have different animations on overlay
     */
    public struct ModalInfoStruct {
        var modal: JRABaseModal
        var position: JRAAnimationHelper.Position = .end
        var enterDirection: JRAAnimationHelper.Direction = .top
        var leaveDirection: JRAAnimationHelper.Direction = .bottom
        var entryTime: CFTimeInterval = 0.5
        var leaveTime: CFTimeInterval = 0.5
        /// This flag is used by the overlay only to set if modal is on or not
        var isOn: Bool = false
        
        init(modal: JRABaseModal) {
            self.modal = modal
        }
    }
    
    public enum Style {
        case Transparent, Clear
    }
    
    var backgroundStyle: Style = .Transparent {
        didSet {
            setBackground()
        }
    }
    
    /// Overlay delegates
    public var delegate: JRAOverlayProtocols?
    /// Unique ID to distinguish the overlay object
    public var id: String = ""
    
    /// The view on which the overlay will sit on. Set by setOn Functions
    private var baseWindow: UIView?
    /// Boolean if overlay is on display
    private var isOverlayOn: Bool = false
    
    /**
     The modal views to display on this overlay represented on the map with all the configuration for each modal just for this overlay
     
     - Assign the modal view and call showModal(key)  to display the modal with specific configuration
     */
    private var modalMap: [String:ModalInfoStruct] = [:]
    
    required public init(style: Style, bgColor: UIColor = .black) {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.backgroundColor = bgColor
        backgroundStyle = style
        setBackground()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
     Set the background with the style specified
     
     - Call this only after you change the background color
     */
    open func setBackground() {
        switch backgroundStyle {
        case .Transparent:
            self.backgroundColor = self.backgroundColor?.withAlphaComponent(0.6)
        case .Clear:
            self.backgroundColor = .clear
        }
    }
    
    /**
     Set the overlay on top of a view by hooking to all side of the view constraint
     */
    public func setOn(view: UIView = UIApplication.shared.windows.last!) {
        baseWindow = view
    }
    
    /**
     Add modal with a unique key to identifiy the modal
     
     - Add a bunch of modal through this and then to show the modal you have to pass the key
     
     - Parameters:
        - key: Unique key to identify the modal
        - config: **ModalInfoStruct** configuration for how to show or properties of the modal
     */
    open func addModal(with key: String, config: ModalInfoStruct) {
        if let modal = modalMap[key] { // Remove the modal from the view before doing anything
            modal.modal.removeFromSuperview()
            modalMap.removeValue(forKey: key)
        }
        modalMap[key] = config
    }
    
    /**
     Show modal on the overlay with the animation mentioned in configuration
     
     - **Important**
        - Automatically show the overlay if the overlay is not shown
        - If a modal with key is already shown and is called again then the modal is removed first and then re-added
        - Delegates in the modal will be called. Check **JRABaseModalGeneralProtocol** for more information
        - Modal will be shown on top of each other if old modals are not hidden in the overlay
     
     - Parameters:
        - key: The unique id of modal to show
     - Returns true if modal is shown else false
     */
    open func showModal(with key: String) -> Bool {
        guard let modalConfig = modalMap[key] else {
            JRALogging.shared.log(with: loggingKey, "Modal cannot be shown as no such modalConfig found with key \(key)")
            return false
        }
        guard let baseWindow = baseWindow else {
            JRALogging.shared.log(with: loggingKey, "Base window not found while triggering modal show \(key)")
            return false
        }
        if !isOverlayOn { // Activate the overlay while showing
            showOverlay()
        }
        let modal = modalConfig.modal
        modal.removeFromSuperview()
        
        CATransaction.begin()
        CATransaction.setCompletionBlock {[weak self] in
            guard let self = self else { return }
            self.modalMap[key]?.isOn = true
            modal.modalDidShow()
        }
        modal.modalWillShow()
        baseWindow.addSubview(modal)
        switch modalConfig.position {
        case .start:
            let _ = modal.jraLayoutHookToAllSide(of: baseWindow, top: 0, right: 0, bottom: nil, left: 0)
        case .end:
            let _ = modal.jraLayoutHookToAllSide(of: baseWindow, top: nil, right: 0, bottom: 0, left: 0)
        case .center:
            let _ = modal.jraLayoutHookToAllSide(of: baseWindow, top: nil, right: 0, bottom: nil, left: 0)
            let _ = modal.jraLayoutCenter(to: baseWindow, y: 0)
        }
        
        // Animations
        modal.layer.add(JRAAnimationHelper.shared.fade(.Enter, duration: modalConfig.entryTime), forKey: "\(key)modalFadeEntry")
        if modalConfig.enterDirection != .none {
            modal.layer.add(JRAAnimationHelper.shared.move(.to, direction: modalConfig.enterDirection, duration: modalConfig.entryTime), forKey: "\(key)modalMoveTo")
        }
        
        
        CATransaction.commit()
        return true
    }
    
    /**
     Hide modal  with the animation mentioned in configuration
     
     - **Important**
        - Delegates in the modal will be called. Check **JRABaseModalGeneralProtocol** for more information
     
     - Parameters:
        - key: The unique id of modal to hide
     - Returns true if modal is shown else false
     */
    func hideModal(with key: String) -> Bool {
        guard let modalConfig = modalMap[key] else {
            JRALogging.shared.log(with: loggingKey, "Modal cannot be hide as no such modalConfig found with key \(key)")
            return false
        }
        let modal = modalConfig.modal
        
        CATransaction.begin()
        CATransaction.setCompletionBlock {[weak self] in
            guard let self = self else { return }
            self.modalMap[key]?.isOn = false
            modal.removeFromSuperview()
            modal.layer.removeAllAnimations()
            modal.modalDidHide()
        }
        modal.modalWillHide()
        
        // Animations
        modal.layer.add(JRAAnimationHelper.shared.fade(.Leave, duration: modalConfig.leaveTime), forKey: "\(key)modalFadeLeave")
        if modalConfig.enterDirection != .none {
            modal.layer.add(JRAAnimationHelper.shared.move(.from, direction: modalConfig.leaveDirection, duration: modalConfig.leaveTime), forKey: "\(key)modalMoveFrom")
        }
        
        
        CATransaction.commit()
        return true
    }
    
    /**
     Shows the overlay with fade in animation
     
     - Parameter duration: How long it takes to finish the animation. Set to 0 if needed instantly
     */
    open func showOverlay(duration: CFTimeInterval = 0.5) {
        guard let baseWindow = baseWindow else {
            JRALogging.shared.log(with: loggingKey,"Base window is not set or found. Call setOn() before calling this")
            print()
            return
        }
        delegate?.JRAOverlayWillLoad(self, id: id)
        self.removeFromSuperview()
        
        baseWindow.addSubview(self)
        let _ = self.jraLayoutHookToAllSide(of: baseWindow)
        
        self.layer.add(JRAAnimationHelper.shared.fade(.Enter, duration: duration), forKey: "OverlayEnter")
        isOverlayOn = true
        delegate?.JRAOverlayDidLoad(self, id: id)
    }
    
    /**
     Hide the overlay with fade out animation
     
     - Parameter duration: How long it takes to finish the animation. Set to 0 if needed instantly
     */
    open func hideOverlay(duration: CFTimeInterval = 0.6) {
        guard isOverlayOn else {
            JRALogging.shared.log(with: loggingKey, "Overlay is not turned on. Call showOverlay() first before calling this")
            return
        }
        CATransaction.begin()
        delegate?.JRAOverlayWillDisappear(self, id: id)
        CATransaction.setCompletionBlock {[weak self] in
            guard let self = self else { return }
            self.isOverlayOn = false
            self.removeFromSuperview()
            self.layer.removeAllAnimations()
            self.delegate?.JRAOverlayDidDisappear(self, id: self.id)
        }
        self.layer.add(JRAAnimationHelper.shared.fade(.Leave, duration: duration), forKey: "OverlayLeave")
        for (k, v) in self.modalMap { // Hide all the modal while hiding overlay
            if v.isOn {
                let _ = self.hideModal(with: k)
            }
        }
        CATransaction.commit()
    }
}

public protocol JRAOverlayProtocols {
    /**
     After overlay has been shown
     
     - Parameters:
        - overlay: Reference to the overlay
        - id: Unique id set during intialization to identify overlay. Empty string if not set
     */
    func JRAOverlayDidLoad(_ overlay: JRAOverlay, id: String)
    /**
     Before overlay will be shown
     
     - Parameters:
        - overlay: Reference to the overlay
        - id: Unique id set during intialization to identify overlay. Empty string if not set
     */
    func JRAOverlayWillLoad(_ overlay: JRAOverlay, id: String)
    /**
     After overlay has been disappear
     
     - Parameters:
        - overlay: Reference to the overlay
        - id: Unique id set during intialization to identify overlay. Empty string if not set
     */
    func JRAOverlayDidDisappear(_ overlay: JRAOverlay, id: String)
    /**
     Before overlay will be disappear
     
     - Parameters:
        - overlay: Reference to the overlay
        - id: Unique id set during intialization to identify overlay. Empty string if not set
     */
    func JRAOverlayWillDisappear(_ overlay: JRAOverlay, id: String)
}

extension JRAOverlayProtocols {
    public func JRAOverlayDidLoad(_ overlay: JRAOverlay, id: String) { /* Empty */ }
    public func JRAOverlayWillLoad(_ overlay: JRAOverlay, id: String) { /* Empty */ }
    public func JRAOverlayDidDisappear(_ overlay: JRAOverlay, id: String) { /* Empty */ }
    public func JRAOverlayWillDisappear(_ overlay: JRAOverlay, id: String) { /* Empty */ }
}
