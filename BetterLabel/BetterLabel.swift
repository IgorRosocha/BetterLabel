//
//  BetterLabel.swift
//  BetterLabel
//
//  Created by Jakub Olejník on 23/10/2018.
//  Copyright © 2018 Jakub Olejník. All rights reserved.
//

import UIKit

open class BetterLabel: UIView {
    open var text = "" {
        didSet { updateAttributedString() }
    }
    
    open var font = UIFont.preferredFont(forTextStyle: .body) {
        didSet {
            updateAttributedString()
        }
    }
    
    open var textColor = UIColor.black {
        didSet {
            updateAttributedString()
        }
    }
    
    open var textAlignment = NSTextAlignment.natural {
        didSet { updateAttributedString() }
    }
    
    
    open var lineHeight: CGFloat? = nil {
        didSet { updateAttributedString() }
    }
    
    open var kern: CGFloat? = nil {
        didSet { updateAttributedString() }
    }
    
    open var contentInset = UIEdgeInsets.zero {
        didSet {
            updateLayout()
        }
    }
    
    private weak var label: UILabel!
    private var leadingConstraint: NSLayoutConstraint!
    private var trailingConstraint: NSLayoutConstraint!
    private var topConstraint: NSLayoutConstraint!
    private var bottomConstraint: NSLayoutConstraint!
    
    // MARK: Initializers
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        leadingConstraint = label.leadingAnchor.constraint(equalTo: leadingAnchor)
        trailingConstraint = label.trailingAnchor.constraint(equalTo: trailingAnchor)
        topConstraint = label.topAnchor.constraint(equalTo: topAnchor)
        bottomConstraint = label.bottomAnchor.constraint(equalTo: bottomAnchor)
        NSLayoutConstraint.activate([leadingConstraint, trailingConstraint, topConstraint, bottomConstraint])
        self.label = label
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Private helpers
    
    private func updateAttributedString() {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = textAlignment
        
        if let lineHeight = lineHeight {
            paragraphStyle.minimumLineHeight = lineHeight
            paragraphStyle.maximumLineHeight = lineHeight
        }
        
        var attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: textColor,
            .paragraphStyle: paragraphStyle
        ]
        
        if let kern = kern {
            attributes[.kern] = kern
        }
        
        label.attributedText = NSAttributedString(string: text, attributes: attributes)
    }
    
    private func updateLayout() {
        leadingConstraint.constant = contentInset.left
        trailingConstraint.constant = -contentInset.right
        topConstraint.constant = contentInset.top
        bottomConstraint.constant = -contentInset.bottom
        layoutIfNeeded()
    }
}

extension BetterLabel {
    open var lineBreakMode: NSLineBreakMode {
        get { return label.lineBreakMode }
        set { label.lineBreakMode = newValue }
    }
    
    open var isEnabled: Bool {
        get { return label.isEnabled }
        set { label.isEnabled = newValue }
    }
    
    open var adjustsFontSizeToFitWidth: Bool {
        get { return label.adjustsFontSizeToFitWidth }
        set { label.adjustsFontSizeToFitWidth = newValue }
    }
    
    open var allowsDefaultTighteningForTruncation: Bool {
        get { return label.allowsDefaultTighteningForTruncation }
        set { label.allowsDefaultTighteningForTruncation = newValue }
    }
    
    open var baselineAdjustment: UIBaselineAdjustment {
        get { return label.baselineAdjustment }
        set { label.baselineAdjustment = newValue }
    }
    
    open var minimumScaleFactor: CGFloat {
        get { return label.minimumScaleFactor }
        set { label.minimumScaleFactor = newValue }
    }
    
    open var numberOfLines: Int {
        get { return label.numberOfLines }
        set { label.numberOfLines = newValue }
    }
    
    override open var isUserInteractionEnabled: Bool {
        get { return label.isUserInteractionEnabled }
        set { label.isUserInteractionEnabled = newValue }
    }
}
