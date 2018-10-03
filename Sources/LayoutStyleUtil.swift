//
//  LayoutStyleUtil.swift
//  ChatExample
//
//  Created by Luiz Felipe Albernaz Pio on 01/10/18.
//  Copyright © 2018 MessageKit. All rights reserved.
//

import UIKit
import MessageKit

class LayoutStyleUtil: NSObject {

    static let shared: LayoutStyleUtil = LayoutStyleUtil()
    
    private override init() {}
    
    private let incomingRoundedCorners: UIRectCorner = [UIRectCorner.topLeft,
                                                UIRectCorner.topRight,
                                                UIRectCorner.bottomRight]
    
    private let outgoingRoundedCorners: UIRectCorner = [UIRectCorner.topRight,
                                                UIRectCorner.topLeft,
                                                UIRectCorner.bottomLeft]
    
    private let radii: CGSize = CGSize(width: 10.0, height: 10.0)
    
    func setIncomingBubbleMask(forView view: UIView) {
        let path = UIBezierPath(roundedRect: view.bounds, byRoundingCorners: incomingRoundedCorners, cornerRadii: CGSize(width: 10.0, height: 10.0))
        
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        
        view.layer.mask = mask
        view.layer.masksToBounds = true
        view.clipsToBounds = true
    }
    
    func setOutgoingBubbleMask(forView view: UIView) {
        let path = UIBezierPath(roundedRect: view.bounds, byRoundingCorners: outgoingRoundedCorners, cornerRadii: CGSize(width: 10.0, height: 10.0))
        
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        
        view.layer.mask = mask
        view.layer.masksToBounds = true
        view.clipsToBounds = true
    }
    
    func createLayoutForOutgoingMessage(messageKind: MessageKind, superView: UIView) -> MessageStyle {

        if case MessageKind.photo = messageKind {
            
            return MessageStyle.custom { containerView in
                superView.layoutSubviews()
                
                let width = superView.frame.width * 0.3
                
                let position = CGPoint(x: containerView.frame.maxX - width,
                                       y: containerView.frame.maxY - width)
                
                let size = CGSize(width: width, height: width)
                containerView.frame = CGRect(origin: position, size: size)
                
                let roundCornersMask = CAShapeLayer()
                roundCornersMask.path = UIBezierPath(roundedRect: containerView.bounds,
                                                     byRoundingCorners: [.topLeft, .topRight, .bottomLeft],
                                                     cornerRadii: CGSize(width: 10.0, height: 10.0)).cgPath
                
                let borderMask = CAShapeLayer()
                borderMask.frame = containerView.bounds
                borderMask.path = roundCornersMask.path
                borderMask.mask = roundCornersMask
                borderMask.lineWidth = 8.0
                borderMask.strokeColor = UIColor(red: 200/255, green: 0/255, blue: 0/255, alpha: 1.0).cgColor
                borderMask.fillColor = UIColor.clear.cgColor
                
                containerView.layer.mask = roundCornersMask
                containerView.layer.addSublayer(borderMask)
                containerView.layer.masksToBounds = true
            }
        } else {
            
            return MessageStyle.custom { [weak self] containerView in
                superView.layoutSubviews()
                
                self?.setOutgoingBubbleMask(forView: containerView)
            }
        }
    }
    
    func createLayoutForIncomingMessage(messageKind: MessageKind, superView: UIView) -> MessageStyle {
        
        if case MessageKind.photo = messageKind {
            
            return MessageStyle.custom { containerView in
                superView.layoutSubviews()
                
                let width = superView.frame.width * 0.3
                
                let position = CGPoint(x: containerView.frame.minX,
                                       y: containerView.frame.maxY - width)
                
                let size = CGSize(width: width, height: width)
                containerView.frame = CGRect(origin: position, size: size)
                
                let roundCornersMask = CAShapeLayer()
                roundCornersMask.path = UIBezierPath(roundedRect: containerView.bounds, byRoundingCorners: [.topLeft, .topRight, .bottomRight], cornerRadii: CGSize(width: 10.0, height: 10.0)).cgPath
                
                let borderMask = CAShapeLayer()
                borderMask.frame = containerView.bounds
                borderMask.path = roundCornersMask.path
                borderMask.mask = roundCornersMask
                borderMask.lineWidth = 8.0
                borderMask.strokeColor = UIColor(red: 200/255, green: 0/255, blue: 0/255, alpha: 1.0).cgColor
                borderMask.fillColor = UIColor.clear.cgColor
                
                containerView.layer.mask = roundCornersMask
                containerView.layer.addSublayer(borderMask)
                containerView.layer.masksToBounds = true
            }
        } else {
        
            return MessageStyle.custom { [weak self] containerView in
                superView.layoutSubviews()

                self?.setIncomingBubbleMask(forView: containerView)
            }
        }
    }
}
