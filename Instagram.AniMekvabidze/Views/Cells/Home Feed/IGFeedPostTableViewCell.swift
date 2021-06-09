//
//  IGFeedPostTableViewCell.swift
//  Instagram.AniMekvabidze
//
//  Created by Mac User on 6/6/21.
//

import UIKit
// nobody will subclas it
final class IGFeedPostTableViewCell: UITableViewCell {
    
    static let identifier = "IGFeedPostTableViewCell"
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func configure() {
        // configure the cell
        
    }
}
