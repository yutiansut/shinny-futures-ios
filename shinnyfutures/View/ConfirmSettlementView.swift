//
//  ConfirmSettlementView.swift
//  shinnyfutures
//
//  Created by chenli on 2018/5/10.
//  Copyright © 2018年 xinyi. All rights reserved.
//

import UIKit

class ConfirmSettlementView {
    private let label: UITextView!
    private let ok: UIButton!
    private let cancel: UIButton!
    private let background: UIView!

    private static let instance: ConfirmSettlementView = {
        let confirmSettlementView = ConfirmSettlementView()
        return confirmSettlementView
    }()

    class func getInstance() -> ConfirmSettlementView {
        return instance
    }

    private init() {
        label = UITextView(frame: CGRect.zero )
        ok = UIButton(frame: CGRect.zero)
        cancel = UIButton(frame: CGRect.zero)
        background = UIView(frame: CGRect.zero)

        label.isEditable = false
        label.isSelectable = false
        label.textAlignment = NSTextAlignment.center
        label.text = "message"
        label.backgroundColor =   UIColor.darkGray //UIColor.whiteColor()
        label.textColor = UIColor.white //TEXT COLOR
        label.layer.shadowColor = UIColor.gray.cgColor
        label.layer.shadowOffset = CGSize(width: 4, height: 3)
        label.layer.shadowOpacity = 0.3
        if let font = UIFont(name: "Helvetica Neue", size: 10) {
            label.font = font
        }
        label.frame = CGRect(x: UIScreen.main.bounds.width, y: UIApplication.shared.statusBarFrame.height, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - UIApplication.shared.statusBarFrame.height - 44)

        ok.setTitle("确认账单", for: .normal)
        ok.showsTouchWhenHighlighted = true
        ok.setTitleColor(UIColor.white, for: .normal)
        ok.backgroundColor = UIColor.black
        ok.layer.cornerRadius = 10.0
        ok.layer.masksToBounds = true
        ok.frame = CGRect(x: UIScreen.main.bounds.width, y: UIApplication.shared.statusBarFrame.height + label.frame.height, width: UIScreen.main.bounds.width / 2, height: 44)
        ok.addTarget(self, action: #selector(okAction), for: .touchUpInside)

        cancel.setTitle("暂不确认", for: .normal)
        cancel.showsTouchWhenHighlighted = true
        cancel.setTitleColor(UIColor.white, for: .normal)
        cancel.backgroundColor = UIColor.black
        cancel.layer.cornerRadius = 10.0
        cancel.layer.masksToBounds = true
        cancel.frame = CGRect(x: UIScreen.main.bounds.width + ok.frame.width, y: UIApplication.shared.statusBarFrame.height + label.frame.height, width: UIScreen.main.bounds.width / 2, height: 44)
        cancel.addTarget(self, action: #selector(cancelAction), for: .touchUpInside)

        background.backgroundColor = UIColor.darkGray
        background.frame = CGRect(x: UIScreen.main.bounds.width, y: UIApplication.shared.statusBarFrame.height + label.frame.height, width: UIScreen.main.bounds.width, height: 44)
    }

    @objc func okAction() {
        TDWebSocketUtils.getInstance().sendReqConfirmSettlement()
        dismiss()
    }

    @objc func cancelAction() {
        dismiss()
    }

    private func dismiss() {
        UIView.animate(withDuration: 1.0, animations: { () -> Void in
            self.label.alpha = 0
            self.ok.alpha = 0
            self.cancel.alpha = 0
            self.background.alpha = 0
        }, completion: { (_: Bool) in
            self.label.removeFromSuperview()
            self.ok.removeFromSuperview()
            self.cancel.removeFromSuperview()
            self.background.removeFromSuperview()
        })

    }

    func showConfirmSettlement(message: String) {
        label.text = message
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window!.addSubview(label)
        appDelegate.window!.addSubview(background)
        appDelegate.window!.addSubview(ok)
        appDelegate.window!.addSubview(cancel)

        UIView.animate(withDuration: 1.0, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.6, options: UIViewAnimationOptions.curveEaseOut, animations: { () -> Void in
            self.label.frame.origin.x = 0
            self.ok.frame.origin.x = 0
            self.background.frame.origin.x = 0
            self.cancel.frame.origin.x = self.ok.frame.width
        }, completion: nil)

    }
}
