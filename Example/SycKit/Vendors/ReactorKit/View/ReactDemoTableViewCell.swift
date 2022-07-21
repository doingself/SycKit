//
//  FeedbackViewModel.swift
//  SycKit
//
//  Created by syc on 2022/7/20.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift
import Reusable

class ReactDemoTableViewCell: UITableViewCell {
    
    var disposeBag = DisposeBag()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = UIColor.white
        self.selectionStyle = .none
        
        configUI()
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // 处理圆角
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    
    fileprivate let button = UIButton()
    
    func setData(model: ReactDemoModel){
        button.setTitle(model.name, for: UIControl.State.normal)
    }
}

extension ReactDemoTableViewCell {
    func configUI() {
        button.setTitleColor(UIColor.systemBlue, for: UIControl.State.normal)
        self.contentView.addSubview(button)
    }
    func layoutUI() {
        button.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(20)
            make.left.right.equalToSuperview().inset(20)
        }
    }
}

extension ReactDemoTableViewCell: Reusable {}

// MAKR: Reactive
extension Reactive where Base: ReactDemoTableViewCell {
    var touchUpInside: ControlEvent<Void> {
        let source = base.button.rx.tap
        return ControlEvent(events: source)
    }
}

