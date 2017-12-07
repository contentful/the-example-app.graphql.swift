
import Foundation
import Contentful

protocol Module: EntryDecodable, StatefulResource {}
protocol LayoutModule: Module {}
protocol LessonModule: Module {}

class HomeLayout: NSObject, EntryDecodable, ResourceQueryable, StatefulResource {

    static let contentTypeId = "layout"
    
    let sys: Sys
    let slug: String
    var modules: [LayoutModule]?

    var state = ResourceState.upToDate

    required init(from decoder: Decoder) throws {
        sys             = try! decoder.sys()
        let container   = try! decoder.contentfulFieldsContainer(keyedBy: Fields.self)
        slug            = try! container.decode(String.self, forKey: .slug)

        super.init()

        try! container.resolveLinksArray(forKey: .modules, decoder: decoder) { [weak self] array in
            self?.modules = array as? [LayoutModule]
        }
    }

    enum Fields: String, CodingKey {
        case slug
        case modules = "contentModules"
    }
}

class LayoutHeroImage: LayoutModule, EntryDecodable, ResourceQueryable, StatefulResource {

    static let contentTypeId = "layoutHeroImage"

    let sys: Sys
    let copy: String
    let headline: String
    let ctaTitle: String
    let ctaLink: URL
    let visualStyle: String?

    var state = ResourceState.upToDate

    required init(from decoder: Decoder) throws {
        sys             = try decoder.sys()
        let container   = try decoder.contentfulFieldsContainer(keyedBy: Fields.self)
        headline        = try container.decode(String.self, forKey: .headline)
        copy            = try container.decode(String.self, forKey: .copy)
        ctaTitle        = try container.decode(String.self, forKey: .ctaTitle)
        ctaLink         = try container.decode(URL.self, forKey: .ctaLink)
        visualStyle     = try container.decodeIfPresent(String.self, forKey: .visualStyle)
    }

    enum Fields: String, CodingKey {
        case headline, copy, ctaTitle, ctaLink, visualStyle
    }
}

class LayoutCopy: LayoutModule, ResourceQueryable, StatefulResource {

    static let contentTypeId = "layoutCopy"

    let sys: Sys
    let copy: String

    var state = ResourceState.upToDate

    required init(from decoder: Decoder) throws {
        sys             = try decoder.sys()
        let container   = try decoder.contentfulFieldsContainer(keyedBy: Fields.self)
        copy            = try container.decode(String.self, forKey: .copy)
    }

    enum Fields: String, CodingKey {
        case copy
    }
}


class Lesson: NSObject, EntryDecodable, ResourceQueryable, StatefulResource {

    static let contentTypeId = "lesson"

    let sys: Sys
    let title: String
    let slug: String
    var modules: [LessonModule]?

    var state = ResourceState.upToDate

    required init(from decoder: Decoder) throws {

        sys             = try decoder.sys()
        let container   = try decoder.contentfulFieldsContainer(keyedBy: Fields.self)
        title           = try container.decode(String.self, forKey: .title)
        slug            = try container.decode(String.self, forKey: .slug)
        super.init()

        try container.resolveLinksArray(forKey: .modules, decoder: decoder) { [weak self] array in
            self?.modules = array as? [LessonModule]
        }
    }

    enum Fields: String, CodingKey {
        case title, slug, modules
    }
}

class Course: EntryDecodable, ResourceQueryable, StatefulResource {

    static let contentTypeId = "course"

    let sys: Sys

    let title: String
    let slug: String
    let shortDescription: String
    let courseDescription: String
    let duration: Int
    let skillLevel: String

    var imageAsset: Asset?
    var lessons: [Lesson]?
    var categories: [Category]?

    var state = ResourceState.upToDate

    required init(from decoder: Decoder) throws {
        sys                 = try! decoder.sys()
        let container       = try! decoder.contentfulFieldsContainer(keyedBy: Fields.self)
        title               = try! container.decode(String.self, forKey: .title)
        slug                = try! container.decode(String.self, forKey: .slug)
        shortDescription    = try! container.decode(String.self, forKey: .shortDescription)
        courseDescription   = try! container.decode(String.self, forKey: .shortDescription)
        duration            = try! container.decode(Int.self, forKey: .duration)
        skillLevel          = try! container.decode(String.self, forKey: .skillLevel)

        try! container.resolveLink(forKey: .imageAsset, decoder: decoder) { [weak self] asset in
            self?.imageAsset = asset as? Asset
        }
        try! container.resolveLinksArray(forKey: .lessons, decoder: decoder) { [weak self] array in
            self?.lessons = array as? [Lesson]
        }
        try! container.resolveLinksArray(forKey: .categories, decoder: decoder) { [weak self] array in
            self?.categories = array as? [Category]
        }
    }

    enum Fields: String, CodingKey {
        case title, slug, shortDescription, duration, skillLevel, lessons, categories
        case imageAsset = "image"
        case courseDescription = "description"
    }

}

extension Category: Equatable {
    static func ==(lhs: Category, rhs: Category) -> Bool {
        return rhs.id == lhs.id
    }
}


class Category: EntryDecodable, ResourceQueryable, StatefulResource {
    
    static let contentTypeId = "category"

    let sys: Sys
    let slug: String
    let title: String

    var state = ResourceState.upToDate

    required init(from decoder: Decoder) throws {
        sys             = try decoder.sys()
        let container   = try decoder.contentfulFieldsContainer(keyedBy: Fields.self)
        title           = try container.decode(String.self, forKey: .title)
        slug            = try container.decode(String.self, forKey: .slug)
    }

    enum Fields: String, CodingKey {
        case slug, title
    }
}

class HighlightedCourse: LayoutModule, EntryDecodable, ResourceQueryable, StatefulResource {

    static let contentTypeId = "layoutHighlightedCourse"

    let sys: Sys
    let title: String

    var course: Course?

    var state = ResourceState.upToDate

    required init(from decoder: Decoder) throws {

        sys             = try decoder.sys()
        let container   = try decoder.contentfulFieldsContainer(keyedBy: Fields.self)
        title           = try container.decode(String.self, forKey: .title)

        try container.resolveLink(forKey: .course, decoder: decoder) { [weak self] course in
            self?.course = course as? Course
        }
    }

    enum Fields: String, CodingKey {
        case title, course
    }
}

class LessonCopy: LessonModule, ResourceQueryable, StatefulResource {

    static let contentTypeId = "lessonCopy"
    
    let sys: Sys
    let copy: String

    var state = ResourceState.upToDate
    
    required init(from decoder: Decoder) throws {
        sys             = try decoder.sys()
        let container   = try decoder.contentfulFieldsContainer(keyedBy: Fields.self)
        copy            = try container.decode(String.self, forKey: .copy)
    }

    enum Fields: String, CodingKey {
        case copy
    }
}

class LessonImage: LessonModule, ResourceQueryable, StatefulResource {

    static let contentTypeId = "lessonImage"

    let sys: Sys

    // Links must be declared optional.
    var image: Asset?

    var state = ResourceState.upToDate

    required init(from decoder: Decoder) throws {
        sys             = try decoder.sys()
        let container   = try decoder.contentfulFieldsContainer(keyedBy: Fields.self)

        // Resolve link.
        try container.resolveLink(forKey: .image, decoder: decoder) { [weak self] image in
            self?.image = image as? Asset
        }
    }

    enum Fields: String, CodingKey {
        case image
    }
}

class LessonSnippets: LessonModule, ResourceQueryable, StatefulResource {

    static let contentTypeId = "lessonCodeSnippets"

    let sys: Sys
    let swift: String

    var state = ResourceState.upToDate

    required init(from decoder: Decoder) throws {
        sys             = try decoder.sys()
        let container   = try decoder.contentfulFieldsContainer(keyedBy: Fields.self)
        swift           = try container.decode(String.self, forKey: .swift)
    }

    enum Fields: String, CodingKey {
        case swift
    }
}
