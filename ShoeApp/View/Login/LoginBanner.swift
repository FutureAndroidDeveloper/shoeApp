//
//  LoginBanner.swift
//  ShoeApp
//
//  Created by Klimenkov, Kirill on 12.05.21.
//

import UIKit

class LoginBanner: UIView {
    
    private struct Constants {
        static let closeButtonEdgeInsets = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 20)
        
        static let closeIconSize = CGSize(width: 15, height: 15)
        
        struct ContentContainer {
            static let betweenOffset: CGFloat = 15
            static let edgeInsets = UIEdgeInsets(top: 40, left: 20, bottom: 0, right: 20)
            
            struct Description {
                static let edgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
            }
        }
        
        struct ButtonsContainer {
            static let edgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            static let betweenOffset: CGFloat = 20
        }
        
    }
    
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let signUpButton = UIButton()
    private let signInButton = UIButton()
    
    init() {
        super.init(frame: .zero)
        build()
        bind()
        setStyles()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func build() {
        let closeButton = ButtonsFactory.createIconedButton(icon: UIImage(named: "close")!) {
            print("Close tapped")
        }
        addView(closeButton) {
            $0.top.trailing.equalToSuperview().inset(Constants.closeButtonEdgeInsets)
            $0.size.equalTo(Constants.closeIconSize)
        }
        
        let buttonsContainer = UIView()
        buttonsContainer.buildHorizontalStackOf(views: [signUpButton, signInButton],
                                                equalWidth: true,
                                                betweenOffset: Constants.ButtonsContainer.betweenOffset,
                                                insets: Constants.ButtonsContainer.edgeInsets)
        
        let contentContainer = UIView()
        let descriptionContainer = createViewContainer(for: descriptionLabel,
                                                       insets: Constants.ContentContainer.Description.edgeInsets)
        
        contentContainer.buildVerticalStackOf([titleLabel, descriptionContainer, buttonsContainer],
                                              betweenOffset: Constants.ContentContainer.betweenOffset,
                                              insets: Constants.ContentContainer.edgeInsets)
        
        addView(contentContainer) {
            $0.edges.equalToSuperview()
        }
    }
    
    private func createViewContainer(for view: UIView, insets: UIEdgeInsets) -> UIView {
        let container = UIView()
        container.addView(view) {
            $0.edges.equalToSuperview().inset(insets)
        }
        return container
    }
    
    private func bind() {
        titleLabel.text = "ДАВАЙТЕ СТАНЕМ БЛИЖЕ"
        descriptionLabel.text = "Ввойдите в систему, чтобы открыть мир эксклюзивного шопинга"
        signUpButton.setTitle("Зарегистрироваться", for: .normal)
        signInButton.setTitle("Войти", for: .normal)
    }
    
    private func setStyles() {
        titleLabel.textAlignment = .center
        
        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 0
        
        signUpButton.setTitleColor(.black, for: .normal)
        signUpButton.backgroundColor = .clear
        signUpButton.layer.cornerRadius = 5
        signUpButton.layer.borderWidth = 1
        signUpButton.layer.borderColor = UIColor.black.cgColor
        
//        signUpButton.titleEdgeInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        signUpButton.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        signUpButton.titleLabel?.adjustsFontSizeToFitWidth = true
        
        signInButton.setTitleColor(.white, for: .normal)
        signInButton.backgroundColor = .black
        signInButton.layer.cornerRadius = 5
        
//        signUpButton.layer.borderWidth = 1
//        signUpButton.layer.borderColor = UIColor.black.cgColor
    }
    
}
