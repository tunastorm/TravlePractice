//
//  BaseScrollView.swift
//  TravlePractice
//
//  Created by 유철원 on 5/28/24.
//
import UIKit

class BaseScrollView: UIScrollView {
    override init(frame: CGRect) {
        super.init(frame: frame)

        configure()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("Not implemeted xib")
    }

    func configure() {}
    func bind() {}
}
