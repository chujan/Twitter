//
//  TweetTableViewCell.swift
//  Twitter
//
//  Created by Jennifer Chukwuemeka on 06/11/2022.
//

import UIKit
protocol TweetTableViewCellDelegate: AnyObject {
   func TweetTableViewCellDidTapReply()
   func TweetTableViewCellDidTapRetweet()
   func TweetTableViewCellDidTapLike()
   func TweetTableViewCellDidTapShare()
    
}

class TweetTableViewCell: UITableViewCell {
    weak var delegate: TweetTableViewCellDelegate?
    private let actionSpacing: CGFloat = 60

   static let identifier = "TweetTableViewCell"
    
    
    
    private let avaterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 25
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.image = UIImage(systemName: "person")
        imageView.backgroundColor = .red
        return imageView
        
    }()
    
    private let displayName: UILabel = {
        let label = UILabel()
        label.text = "chioma"
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "@chioma"
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    private let tweetTextContentLabel: UILabel = {
        let label = UILabel()
        label.text = "This is mockup tweet sratc  hvhgcfsasnbvhdew3rqrFNBM KNIUOGFNCXREA NB BKJUHIU"
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    private let replyButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "bubble.right"), for: .normal)
        button.tintColor = .systemGray2
        return button
        
    }()
    private let retweetButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "arrow.2.squarepath"), for: .normal)
        button.tintColor = .systemGray2
        return button
        
    }()
    
    private let likeButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.tintColor = .systemGray2
        return button
        
    }()
    private let shareButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        button.tintColor = .systemGray2
        return button
        
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(avaterImageView)
        contentView.addSubview(displayName)
        contentView.addSubview(usernameLabel)
        contentView.addSubview(tweetTextContentLabel)
        contentView.addSubview(replyButton)
        contentView.addSubview(retweetButton)
        contentView.addSubview(likeButton)
        contentView.addSubview(shareButton)
        configureConstrants()
        configureButton()
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    @objc private func didTapReply() {
        delegate?.TweetTableViewCellDidTapReply()
        
        
    }
    @objc private func didTapRetweet() {
        delegate?.TweetTableViewCellDidTapRetweet()
        
    }
    @objc private func didTapShare() {
        delegate?.TweetTableViewCellDidTapShare()
        
    }
    
    @objc private func didTapLike() {
        delegate?.TweetTableViewCellDidTapLike()
        
    }
    
    
     
    
    
    private func configureButton() {
        replyButton.addTarget(self, action: #selector(didTapReply), for: .touchUpInside)
        retweetButton.addTarget(self, action: #selector(didTapRetweet), for: .touchUpInside)
        likeButton.addTarget(self, action: #selector(didTapLike), for: .touchUpInside)
        shareButton.addTarget(self, action: #selector(didTapShare), for: .touchUpInside)
        
        
    }
    
    private func configureConstrants() {
        let avaterImageConstraints = [
            avaterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            avaterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 14),
            avaterImageView.heightAnchor.constraint(equalToConstant: 50),
            avaterImageView.widthAnchor.constraint(equalToConstant: 50)
            
        ]
        
        
       let displayNameContraints = [
        displayName.leadingAnchor.constraint(equalTo: avaterImageView.trailingAnchor, constant: 20),
        displayName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20)
       ]
        let usernameLabelContraints = [
         usernameLabel.leadingAnchor.constraint(equalTo: displayName.trailingAnchor, constant: 10),
         usernameLabel.centerYAnchor.constraint(equalTo: displayName.centerYAnchor)
        ]
        
        let tweetTextContentLabelContraints = [
        tweetTextContentLabel.leadingAnchor.constraint(equalTo: displayName.leadingAnchor),
        tweetTextContentLabel.topAnchor.constraint(equalTo: displayName.bottomAnchor, constant: 10),
        tweetTextContentLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
        
       
        ]
        let replyButtonConstraints = [
            replyButton.leadingAnchor.constraint(equalTo: tweetTextContentLabel.leadingAnchor),
            replyButton.topAnchor.constraint(equalTo: tweetTextContentLabel.bottomAnchor, constant: 10),
            replyButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15)
        ]
        let retweetButtonConstraints = [
            retweetButton.leadingAnchor.constraint(equalTo: replyButton.trailingAnchor,constant: actionSpacing),
            retweetButton.centerYAnchor.constraint(equalTo: replyButton.centerYAnchor)
        ]
        
        let likeButtonConstraints = [
          likeButton.leadingAnchor.constraint(equalTo: retweetButton.trailingAnchor,constant: actionSpacing),
            likeButton.centerYAnchor.constraint(equalTo: replyButton.centerYAnchor)
        ]
        
        let shareButtonConstraints = [
          shareButton.leadingAnchor.constraint(equalTo: likeButton.trailingAnchor,constant: actionSpacing),
            shareButton.centerYAnchor.constraint(equalTo: replyButton.centerYAnchor)
        ]
        
        
        
        NSLayoutConstraint.activate(avaterImageConstraints)
        NSLayoutConstraint.activate(displayNameContraints)
        NSLayoutConstraint.activate(usernameLabelContraints)
        NSLayoutConstraint.activate(tweetTextContentLabelContraints)
        NSLayoutConstraint.activate(replyButtonConstraints)
        NSLayoutConstraint.activate(retweetButtonConstraints)
        NSLayoutConstraint.activate(likeButtonConstraints)
        NSLayoutConstraint.activate(shareButtonConstraints)
        
        
    }

}
