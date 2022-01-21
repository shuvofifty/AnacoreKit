//
//  HomeViewController.swift
//  AnacoreKitDemo
//
//  Created by Shubroto Shuvo on 10/1/21.
//

import Foundation
import AnacoreKit
import UIKit

class HomeViewController: JRARootVC {
    private lazy var scrollView: JRAScrollView = {
        let scroll = JRAScrollView()
        return scroll
    }()
    
    private lazy var baseCard: JRACard = {
        JRACard()
            .setMarginSpace(top: 10, right: 20, bottom: 10, left: 20)
            
            .addRow(key: "hl1", marginBottom: 15)
            .addViewTo(key: "hl1", view: welcomeLabel, huggingPriority: .defaultLow)
            .addViewTo(key: "hl1", view: versionLabel, huggingPriority: .defaultHigh)
            
            .addRow(key: "dl1", marginBottom: 30)
            .addViewTo(key: "dl1", view: demoLabel)
        
            .addRow(key: "lc1")
            .addViewTo(key: "lc1", view: labelCard)
    }()
    
    private lazy var welcomeLabel: JRALabel = {
        let label = JRALabel(text: "Welcome", font: JRASharedConfigContainer.shared.fontSizeConfig.xxlFontSize)
        print(label.font.familyName)
        return label
    }()
    
    private lazy var versionLabel: JRABorderLabel = {
        let border = JRABorderLabel(text: "v0.0.1")
        border.label.size = JRASharedConfigContainer.shared.fontSizeConfig.sFontSize.pointSize
        border.spaceConstraint.setSpacing(top: 5, right: 10, bottom: 5, left: 10)
        border.backgroundColor = JRASharedConfigContainer.shared.alertConfig.infoColor
        border.label.textColor = JRASharedConfigContainer.shared.baseColorConfig.secondaryColor
        border.jraSet(cornerRadius: 10)
        return border
    }()
    
    private lazy var demoLabel: JRALabel = {
        let label = JRALabel(text: "A demo project about the tools of Anarcore Kit. \nIts more of a documentation also to help you out how the code looks and it works")
        label.size = JRASharedConfigContainer.shared.fontSizeConfig.sFontSize.pointSize
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var demoLabel1: JRALabel = {
        let label = JRALabel(text: "A demo project about the tools of Anarcore Kit. \nIts more of a documentation also to help you out how the code looks and it works")
        label.size = JRASharedConfigContainer.shared.fontSizeConfig.sFontSize.pointSize
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var demoLabel2: JRALabel = {
        let label = JRALabel(text: "A demo project")
        label.size = JRASharedConfigContainer.shared.fontSizeConfig.sFontSize.pointSize
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var demoLabel3: JRALabel = {
        let label = JRALabel(text: ">")
        label.size = JRASharedConfigContainer.shared.fontSizeConfig.sFontSize.pointSize
        return label
    }()
    
    private lazy var labelCard: JRABaseCard = {
        let card = JRABaseCard()
            .addCustomHeader(with: [
                (view: demoLabel2, priority: .defaultLow),
                (view: demoLabel3, priority: .defaultHigh)
            ])
            .addRow(key: "h1")
            .addViewTo(key: "h1", view: demoLabel1)
        
        return card as! JRABaseCard
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = JRASharedConfigContainer.shared.baseColorConfig.background
        
        view.addSubview(scrollView)
        scrollView.content.addArrangedSubview(baseCard)
        
        _ = scrollView.jraLayoutHookToAllSide(of: view, useSafeAreaLayoutGuide: true)
        
        demoLabel3.addTapFeature(value: nil) {[weak self] (val) in
            self?.navigationToTable()
        }
    }
    
    private func navigationToTable() {
        let vc = TableViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
