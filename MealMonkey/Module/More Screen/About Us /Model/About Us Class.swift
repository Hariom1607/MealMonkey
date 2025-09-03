//
//  About Us Class.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 05/08/25.
//

import Foundation
import UIKit

/// Model used for About Us, Notifications, and Inbox data
class AboutModel {
    
    /// General text (e.g., About Us paragraph, notification message, inbox title)
    var strText: String?
    
    /// Time info for notifications (e.g., "5m ago", "1d ago")
    var strTimezone: String?
    
    /// Right-side label (e.g., date like "6th July")
    var strRightSideText: String?
    
    /// Secondary text (e.g., inbox message description)
    var strText2: String?
    
    /// Initializer with optional fields
    init(strText: String? = nil,
         strTimezone: String? = nil,
         strRightSideText: String? = nil,
         strText2: String? = nil) {
        self.strText = strText
        self.strTimezone = strTimezone
        self.strRightSideText = strRightSideText
        self.strText2 = strText2
    }
    
    // MARK: - Static Data Providers
    
    /// Provides sample "About Us" content paragraphs
    class func addAboutData() -> [AboutModel] {
        return [
            AboutModel(
                strText:
                    Main.aboutUsModel.strText1
            ),
            AboutModel(
                strText:
                    Main.aboutUsModel.strText2
            ),
            AboutModel(
                strText:
                    Main.aboutUsModel.strText3
            ),
            AboutModel(
                strText:
                    Main.aboutUsModel.strText4
            ),
            AboutModel(
                strText:
                    Main.aboutUsModel.strText5
            ),
            AboutModel(
                strText:
                    Main.aboutUsModel.strText6
            ),
            AboutModel(
                strText:
                    Main.aboutUsModel.strText7
            ),
        ]
    }
    
    /// Provides sample notification list (title + relative time)
    class func addNotificationData() -> [AboutModel] {
        return [
            AboutModel(strText: Main.notificationModel.orderPlaced.0, strTimezone: Main.notificationModel.orderPlaced.1),
            AboutModel(strText: Main.notificationModel.paymentConfirmed.0, strTimezone: Main.notificationModel.paymentConfirmed.1),
            AboutModel(strText: Main.notificationModel.agentAssigned.0, strTimezone: Main.notificationModel.agentAssigned.1),
            AboutModel(strText: Main.notificationModel.orderOnWay.0, strTimezone: Main.notificationModel.orderOnWay.1),
            AboutModel(strText: Main.notificationModel.discount.0, strTimezone: Main.notificationModel.discount.1),
            AboutModel(strText: Main.notificationModel.appUpdate.0, strTimezone: Main.notificationModel.appUpdate.1),
            AboutModel(strText: Main.notificationModel.discount.0, strTimezone: Main.notificationModel.discount.1),
            AboutModel(strText: Main.notificationModel.referFriend.0, strTimezone: Main.notificationModel.referFriend.1),
            AboutModel(strText: Main.notificationModel.limitedDeal.0, strTimezone: Main.notificationModel.limitedDeal.1),
            AboutModel(strText: Main.notificationModel.deliveryDone.0, strTimezone: Main.notificationModel.deliveryDone.1),
            AboutModel(strText: Main.notificationModel.rateMeal.0, strTimezone: Main.notificationModel.rateMeal.1),
            AboutModel(strText: Main.notificationModel.weekendOffer.0, strTimezone: Main.notificationModel.weekendOffer.1),
            AboutModel(strText: Main.notificationModel.freeDelivery.0, strTimezone: Main.notificationModel.freeDelivery.1),
            AboutModel(strText: Main.notificationModel.thanks.0, strTimezone: Main.notificationModel.thanks.1),
            AboutModel(strText: Main.notificationModel.newRestaurants.0, strTimezone: Main.notificationModel.newRestaurants.1)
        ]
    }
    
    /// Provides sample inbox messages (title + date + short description)
    class func addInboxData() -> [AboutModel] {
        return [
            AboutModel(strText: Main.inboxModel.promotions.0,
                       strRightSideText: Main.inboxModel.promotions.1,
                       strText2: Main.inboxModel.promotions.2),
            AboutModel(strText: Main.inboxModel.orderUpdate.0,
                       strRightSideText: Main.inboxModel.orderUpdate.1,
                       strText2: Main.inboxModel.orderUpdate.2),
            AboutModel(strText: Main.inboxModel.deliveryReminders.0,
                       strRightSideText: Main.inboxModel.deliveryReminders.1,
                       strText2: Main.inboxModel.deliveryReminders.2),
            AboutModel(strText: Main.inboxModel.welcome.0,
                       strRightSideText: Main.inboxModel.welcome.1,
                       strText2: Main.inboxModel.welcome.2),
            AboutModel(strText: Main.inboxModel.experience.0,
                       strRightSideText: Main.inboxModel.experience.1,
                       strText2: Main.inboxModel.experience.2),
            AboutModel(strText: Main.inboxModel.flashSale.0,
                       strRightSideText: Main.inboxModel.flashSale.1,
                       strText2: Main.inboxModel.flashSale.2),
            AboutModel(strText: Main.inboxModel.referEarn.0,
                       strRightSideText: Main.inboxModel.referEarn.1,
                       strText2: Main.inboxModel.referEarn.2),
            AboutModel(strText: Main.inboxModel.weekendSpecial.0,
                       strRightSideText: Main.inboxModel.weekendSpecial.1,
                       strText2: Main.inboxModel.weekendSpecial.2),
            AboutModel(strText: Main.inboxModel.tips.0,
                       strRightSideText: Main.inboxModel.tips.1,
                       strText2: Main.inboxModel.tips.2),
            AboutModel(strText: Main.inboxModel.orderCancel.0,
                       strRightSideText: Main.inboxModel.orderCancel.1,
                       strText2: Main.inboxModel.orderCancel.2),
            AboutModel(strText: Main.inboxModel.loyaltyProgram.0,
                       strRightSideText: Main.inboxModel.loyaltyProgram.1,
                       strText2: Main.inboxModel.loyaltyProgram.2),
            AboutModel(strText: Main.inboxModel.securityUpdate.0,
                       strRightSideText: Main.inboxModel.securityUpdate.1,
                       strText2: Main.inboxModel.securityUpdate.2),
            AboutModel(strText: Main.inboxModel.accountVerified.0,
                       strRightSideText: Main.inboxModel.accountVerified.1,
                       strText2: Main.inboxModel.accountVerified.2),
            AboutModel(strText: Main.inboxModel.limitedDeal.0,
                       strRightSideText: Main.inboxModel.limitedDeal.1,
                       strText2: Main.inboxModel.limitedDeal.2),
            AboutModel(strText: Main.inboxModel.newRestaurants.0,
                       strRightSideText: Main.inboxModel.newRestaurants.1,
                       strText2: Main.inboxModel.newRestaurants.2)
        ]
    }
}
