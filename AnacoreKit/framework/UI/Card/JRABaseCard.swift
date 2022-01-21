//
//  JRABaseCard.swift
//  AnacoreKit
//
//  Created by Shubroto Shuvo on 10/2/21.
//

import Foundation
import UIKit

open class JRABaseCard: JRACard {
    /// This controls the header part of the card. Use this key reference to add or remove row for extra customization
    static let headerRowKey = "headerRowKeyJRA_800098"
    /// This controls the header divider part of the card. Use this key reference to add or remove row for extra customization
    static let headerDividerRowKey = "headerDividerRowKeyJRA_800098"
    
    public private(set) lazy var header: JRALabel = {
        let label = JRALabel(text: "", font: JRASharedConfigContainer.shared.fontSizeConfig.lFontSize)
        
        return label
    }()
    
    public private(set) lazy var divider: JRADivider = {
        let label = JRADivider(axis: .horizontal, fatness: 2, color: JRASharedConfigContainer.shared.baseColorConfig.primaryColor)
        return label
    }()
    
    public required init() {
        super.init()
        
        _ = setMarginSpace(top: 15, right: 15, bottom: 15, left: 15)
        backgroundColor = .white
        jraSet(cornerRadius: 15)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        jraSetDropShadow()
    }
    
    /**
     Adds a default header label with a underline at bottom.
     
     - Use headerRowKey and headerDividerRowKey for adding views in that row or remove row
     - Change any property in header and divider to have your own custom UI
     - All elements are removed and added back
     
     - Parameter text: text for default header label
     */
    open func addHeader(text: String) -> JRABaseCard {
        let card = removeRow(key: JRABaseCard.headerRowKey)
            .removeRow(key: JRABaseCard.headerDividerRowKey)
            
            .addRow(key: JRABaseCard.headerRowKey)
            .addViewTo(key: JRABaseCard.headerRowKey, view: header)
            
            .addRow(key: JRABaseCard.headerDividerRowKey, marginBottom: 5)
            .addViewTo(key: JRABaseCard.headerDividerRowKey, view: divider)
        header.text = text
        return card as! JRABaseCard
    }
    
    /**
     Adds header with array of custom elements with a underline at bottom.
     
     - Use headerRowKey and headerDividerRowKey for adding views in that row or remove row
     - All elements are removed and added back
     
     - Parameter headerViews: an array of tuple **(view: UIView, priority: UILayoutPriority)** which will be added to headerRowKey
     */
    open func addCustomHeader(with headerViews: [(view: UIView, priority: UILayoutPriority)]) -> JRABaseCard {
        let card = removeRow(key: JRABaseCard.headerRowKey)
            .removeRow(key: JRABaseCard.headerDividerRowKey)
            
            .addRow(key: JRABaseCard.headerRowKey)
            
            .addRow(key: JRABaseCard.headerDividerRowKey, marginBottom: 5)
            .addViewTo(key: JRABaseCard.headerDividerRowKey, view: divider)
        for header in headerViews {
            _ = card
                .addViewTo(key: JRABaseCard.headerRowKey, view: header.view, huggingPriority: header.priority)
        }
        return card as! JRABaseCard
    }
}
