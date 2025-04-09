//
//  CustomSegmentedControlsView.swift
//  TMDB Port
//
//  Created by Mohamad Mohamad on 2025. 04. 07..
//

import UIKit

protocol CustomSegmentedControlsDelegate<Option>: AnyObject {
    associatedtype Option: CaseIterable & RawRepresentable & Equatable where Option.RawValue == String
    func customSegmentedControls(_ segmentedControls: CustomSegmentedControlsView<Option>, didSelectOption option: Option)
}

class CustomSegmentedControlsView<Option>: UIView where Option: CaseIterable, Option: RawRepresentable, Option.RawValue == String, Option: Equatable {
    var label: String
    var selectedOption: Option
    var delegate: (any CustomSegmentedControlsDelegate<Option>)?
    
    private var stackView: UIStackView!
    private var buttons = [UIButton]()
    
    //views
    private let labelView: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    private let background: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let selectionBackground: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .accent
        return view
    }()
    
    private var maxOptionWidth = 0
    
    init(label: String, option: Option) {
        self.label = label
        self.selectedOption = option
        super.init(frame: .zero)
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpView() {
        setupLabel()
        calculateMaxOptionWidth()
        setupBackground()
        configureGradient()
        setupSelectionBackground()
        setupSections()
    }
    
    private func setupLabel() {
        addSubview(labelView)
        labelView.text = label
        NSLayoutConstraint.activate([
            labelView.topAnchor.constraint(equalTo: topAnchor),
            labelView.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
        
        DispatchQueue.main.async{ 
            self.updateBackgroundLocation(type: self.selectedOption)
        }
    }

    private func calculateMaxOptionWidth() {
        let label = UILabel()
        for option in Option.allCases {
            label.text = option.rawValue
            label.sizeToFit()
            maxOptionWidth = max(maxOptionWidth, Int(label.frame.width))
        }
    }

    private func setupBackground() {
        addSubview(background)
        background.addSubview(selectionBackground)
        
        let width = (maxOptionWidth + 24) * Option.allCases.count
        NSLayoutConstraint.activate([
            background.leadingAnchor.constraint(equalTo: labelView.trailingAnchor, constant: 8),
            background.topAnchor.constraint(equalTo: labelView.topAnchor),
            background.bottomAnchor.constraint(equalTo: labelView.bottomAnchor),
            background.trailingAnchor.constraint(equalTo: trailingAnchor),
            background.widthAnchor.constraint(equalToConstant: CGFloat(width))
        ])
    }
    
    private func setupSections() {
        stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        for option in Option.allCases {
            let button = UIButton()
            button.setTitle(option.rawValue, for: .normal)
            button.accessibilityIdentifier = option.rawValue
            stackView.addArrangedSubview(button)
            buttons.append(button)
        }
        
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: background.leadingAnchor , constant: 12),
            stackView.trailingAnchor.constraint(equalTo: background.trailingAnchor , constant: -12),
            stackView.centerYAnchor.constraint(equalTo: background.centerYAnchor),
            stackView.centerXAnchor.constraint(equalTo: background.centerXAnchor),
            stackView.heightAnchor.constraint(equalTo: background.heightAnchor, constant: -8),
        ])
        
        DispatchQueue.main.async{
            self.buttons.forEach { button in
                button.widthAnchor.constraint(equalTo: self.stackView.widthAnchor, multiplier: 1.0 / CGFloat(Option.allCases.count)).isActive = true
                button.addTarget(self, action: #selector(self.onTapClicked(_:)), for: .touchUpInside)
            }
        }
    }
    
    private func setupSelectionBackground() {
        NSLayoutConstraint.activate([
            selectionBackground.leadingAnchor.constraint(equalTo: background.leadingAnchor, constant: 10),
            selectionBackground.topAnchor.constraint(equalTo: labelView.topAnchor, constant: 4),
            selectionBackground.bottomAnchor.constraint(equalTo: labelView.bottomAnchor, constant: -4),
            selectionBackground.centerYAnchor.constraint(equalTo: labelView.centerYAnchor),
            selectionBackground.widthAnchor.constraint(equalToConstant: CGFloat(maxOptionWidth + 16)),
        ])
    }
    
    private func configureGradient() {
        DispatchQueue.main.async {
            let gradientLayer = CAGradientLayer()
            gradientLayer.colors = [UIColor.gradientStart.cgColor,UIColor.gradientMid.cgColor, UIColor.gradientEnd.cgColor]
            gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
            gradientLayer.frame = self.background.bounds
            self.background.layer.insertSublayer(gradientLayer, at: 0)
        }
    }
    
    @objc private func onTapClicked(_ sender: UIButton) {
        let selectedTap = Option.init(rawValue: sender.accessibilityIdentifier!)!
        delegate?.customSegmentedControls(self, didSelectOption: selectedTap)
        
        updateBackgroundLocation(type: selectedTap)
        selectedOption = selectedTap
    }
    
    private func updateBackgroundLocation(type: Option) {
        guard let index = Option.allCases.firstIndex(of: type) else { return }
        let intIndex = Option.allCases.distance(from: Option.allCases.startIndex, to: index)
        
        let newLabelWidth = Int(stackView.frame.width / CGFloat(Option.allCases.count))
        let position = intIndex * newLabelWidth

        UIView.animate(withDuration: 0.3) {
            self.selectionBackground.center.x = CGFloat(12 + position + newLabelWidth / 2)
        }
    }
}
