//
//  ViewModel.swift
//  NewsFeed
//
//  Created by Nikita Entin on 12.06.2021.
//

import Foundation

struct ViewModel: Codable {
    let data: UserData?
}

struct UserData: Codable {
    var items: [Item]
    let cursor: String?
    
}

struct Item: Codable {
    let id: String
    let isCreatedByPage: Bool?
    let status: Status
    let type: ItemType
    let coordinates: Coordinates?
    let isCommentable, hasAdultContent, isAuthorHidden, isHiddenInProfile: Bool
    let contents: [Content]
    let language: Language
    let awards: Awards
    let createdAt, updatedAt: Int
    let isSecret: Bool
    let author: Author?
    let stats: Stats
    let isMyFavorite: Bool
}

enum Status: String, Codable {
    case published = "PUBLISHED"
}

enum ItemType: String, Codable {
    case audioCover = "AUDIO_COVER"
    case plain = "PLAIN"
    case plainCover = "PLAIN_COVER"
    case video = "VIDEO"
}

struct Stats: Codable {
    let likes, views, comments, shares: Comments
    let replies: Comments
    let timeLeftToSpace: TimeLeftToSpace
}

struct Coordinates: Codable {
    let latitude, longitude: Double
}

struct Content: Codable {
    let data: ContentData
    let type: BannerType
    let id: String?
}

struct ContentData: Codable {
    let value: String?
    let extraSmall, small, original, medium: ExtraLarge?
    let large: ExtraLarge?
    let duration: Double?
    let url: String?
    let size: Size?
    let previewImage: PreviewImage?
    let extraLarge: ExtraLarge?
    let values: [String]?
}

struct PreviewImage: Codable {
    let type: BannerType
    let id: String
    let data: PreviewImageData
}

struct PreviewImageData: Codable {
    let extraSmall, medium: ExtraLarge
}

enum Language: String, Codable {
    case en = "en"
    case ru = "ru"
}

struct Awards: Codable {
    let recent: [String]
        let statistics: [Statistic]
        let voices: Double
        let awardedByMe: Bool
}

struct Statistic: Codable {
    let id: String
        let count: Int
}

struct Author: Codable {
    let id: String
    let url: String?
    let name: String
    let banner: Banner?
    let photo: Photo?
    let isHidden, isBlocked, allowNewSubscribers, showSubscriptions: Bool
    let showSubscribers, isMessagingAllowed: Bool
    let auth: Auth
    let statistics: Statistics
    let tagline: String
    let data: AuthorData
    let photoSpecialStyle, photoSpecialVariant, nameSpecialStyle: Int?
}

struct Banner: Codable  {
    let type: BannerType
    let id: String
    let data: BannerData
}

struct BannerData: Codable {
    let extraSmall, small, medium: ExtraLarge
       let large: ExtraLarge?
       let original: ExtraLarge
       let extraLarge: ExtraLarge?
}

struct ExtraLarge: Codable {
    let url: String
    let size: Size
}

struct Size: Codable {
    let width, height: Int
}

enum BannerType: String, Codable {
    case audio = "AUDIO"
    case image = "IMAGE"
    case imageGIF = "IMAGE_GIF"
    case tags = "TAGS"
    case text = "TEXT"
    case video = "VIDEO"
}

struct Photo: Codable  {
    let type: BannerType
    let id: String
    let data: PhotoData
}

struct PhotoData: Codable {
    let extraSmall: ExtraLarge
    let small, medium: ExtraLarge?
    let original: ExtraLarge
}

enum Gender: String, Codable {
    case male = "MALE"
    case other = "OTHER"
}

struct Auth: Codable  {
    let isDisabled: Bool
    let lastSeenAt, level: Int
}

struct Statistics: Codable  {
    let likes: Int
    let thanks: Double
    let uniqueName: Bool
    let thanksNextLevel: Int
}

struct AuthorData: Codable  {
    
}

struct TimeLeftToSpace: Codable {
    let count: Int?
    let my: Bool
}

struct Comments: Codable {
    let count: Int
    let my: Bool
}
