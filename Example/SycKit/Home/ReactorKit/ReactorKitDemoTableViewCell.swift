//
//  ReactorKitDemoTableViewCell.swift
//  SycKit_Example
//
//  Created by syc on 2021/1/26.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class ReactorKitDemoTableViewCell: UITableViewCell {

    let disposeBag = DisposeBag()
    
    fileprivate let selectButton = UIButton()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

extension ReactorKitDemoTableViewCell {
    private func setupUI() {
        selectButton.setImage(UIImage(named: ""), for: UIControlState.normal)
        selectButton.setImage(UIImage(named: ""), for: UIControlState.selected)
    }
    func setData(model: ReactorKitDemoModel){
        self.selectButton.isSelected = model.selected
        self.textLabel?.text = model.title
    }
}

extension Reactive where Base: ReactorKitDemoTableViewCell {
    var touchUpInsideSelected: ControlEvent<Void> {
        let source = base.selectButton.rx.tap
        return ControlEvent(events: source)
    }
}

