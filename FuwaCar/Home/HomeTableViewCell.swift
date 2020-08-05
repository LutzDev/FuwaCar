//
//  HomeTableViewCell.swift
//  FuwaCar
//
//  Created by Lutz Weigold on 16.07.20.
//  Copyright © 2020 Lutz Weigold. All rights reserved.
//

import UIKit
import SDWebImage

class HomeTableViewCell: UITableViewCell {

    
    // MARK: - Outlet
    
    @IBOutlet weak var cellCarImage: UIImageView!
    @IBOutlet weak var cellDepartureTime: UILabel!
    @IBOutlet weak var cellStartingDestination: UILabel!
    @IBOutlet weak var cellDescription: UILabel!
    @IBOutlet weak var cellProfileImage: UIImageView!
    @IBOutlet weak var cellUserName: UILabel!
    @IBOutlet weak var cellPhoneNumber: UIImageView!
    
    fileprivate let application = UIApplication.shared
    
    
    // MARK: - Var
    var phoneNumber: String = "123456"
    
    // MARK: - Post
    var ride: PostModel? {
        
        didSet {

            guard let _rideDescription = ride?.rideDescription else {return}
            guard let _carImageUrl = ride?.carImageUrl else {return}
            guard let _rideDestination = ride?.rideDestination else {return}
            guard let _rideStartingPoint = ride?.rideStartingPoint else {return}
            guard let _rideMonth = ride?.rideMonth else {return}
            guard let _rideMinute = ride?.rideMinutes else {return}
            guard let _rideWeekday = ride?.rideWeekday else {return}
            guard let _rideHour = ride?.rideHour else {return}
            guard let _phoneNumber = ride?.phoneNumber else {return}
            phoneNumber = _phoneNumber;
            
            updateCellView(cellCarImagePara: _carImageUrl, cellStartingDestinationPara: _rideStartingPoint, cellDescriptionPara: _rideDescription, cellDestinationPara: _rideDestination, cellHourPara: _rideHour, cellMinutePar: _rideMinute, cellWeekdayPara: _rideWeekday, cellMonthPara: _rideMonth, cellPhoneNumber: _phoneNumber)
        }
    }
    
    // MARK: - User
    var user: UserModel? {
        didSet{
            guard let _username = user?.username else {return}
            guard let _profileImageUrl = user?.profileImageUrl else {return}
            setUpUserInfo(username: _username, profileImageUrl: _profileImageUrl)
        }
    }
    
    func setUpUserInfo(username: String, profileImageUrl: String){
        cellUserName.text = username
        guard let url = URL(string: profileImageUrl) else {return}
        cellProfileImage.sd_setImage(with: url) { (_, _, _, _) in}
    }
    
    func setUpViews(){
        // Images
        cellCarImage.layer.cornerRadius = 16
        cellProfileImage.layer.cornerRadius = cellProfileImage.frame.width / 2
        
    }
    func updateCellView(cellCarImagePara: String, cellStartingDestinationPara: String, cellDescriptionPara: String, cellDestinationPara: String, cellHourPara: String, cellMinutePar: String, cellWeekdayPara: String, cellMonthPara: String, cellPhoneNumber: String){
        cellDescription.text = cellDescriptionPara
        cellDepartureTime.text = "\(cellWeekdayPara). \(cellMonthPara). um \(cellHourPara):\(cellMinutePar) Uhr"
        cellStartingDestination.text = "\(cellStartingDestinationPara) - \(cellDestinationPara)"
        guard let url = URL(string: cellCarImagePara) else {return}
        cellCarImage.sd_setImage(with: url) { (_, _, _, _) in}
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpViews()
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        cellPhoneNumber.isUserInteractionEnabled = true
        cellPhoneNumber.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        if let phoneURL = URL(string: "tel://\(phoneNumber)"){
            if application.canOpenURL(phoneURL){
                application.open(phoneURL, options: [:], completionHandler: nil)
            }else{
                //alert
            }
        }
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cellProfileImage.image = UIImage(named: "placeholder_user-profile")
    }
}
