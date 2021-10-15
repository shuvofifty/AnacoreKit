//
//  JRAScrollView.swift
//  AnacoreKit
//
//  Created by Shubroto Shuvo on 10/1/21.
//

import Foundation
import UIKit

/**
 Helper view which will have a scroll view
 
 - **IMPORTANT** Add your content inside the **content** view
 */
public class JRAScrollView: UIView {
    public var contentSpacing: JRAConstraintStruct!
    
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        
        return scroll
    }()
    
    private lazy var contentBaseView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    public private(set) lazy var content: UIStackView = {
        let stack = JRAStackView()
        stack.axis = .vertical
        return stack
    }()
    
    public init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        
        setup()
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setContentAlignment(_ aligment: UIStackView.Alignment) {
        content.alignment = aligment
    }
    
    private func setup() {
        addSubview(scrollView)
        scrollView.addSubview(contentBaseView)
        contentBaseView.addSubview(content)
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
                    
            contentBaseView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentBaseView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentBaseView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentBaseView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentBaseView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
        ])
        
        self.contentSpacing = content.jraLayoutHookToAllSide(of: contentBaseView, top: 0, right: 0, bottom: 0, left: 0)
    }
}
