//  This file was automatically generated and should not be edited.

import Apollo

public final class HomeQuery: GraphQLQuery {
  public let operationDefinition =
    "query Home {\n  layoutCollection(limit: 1) {\n    __typename\n    items {\n      __typename\n      title\n      slug\n      contentModulesCollection {\n        __typename\n        items {\n          __typename\n          ... on LayoutHighlightedCourse {\n            course {\n              __typename\n              ...HightlightedCourseFragment\n            }\n          }\n          ... on LayoutCopy {\n            title\n            headline\n            copy\n            ctaTitle\n            ctaLink\n            visualStyle\n          }\n          ... on LayoutHeroImage {\n            title\n            headline\n            backgroundImage {\n              __typename\n              url\n            }\n          }\n        }\n      }\n    }\n  }\n}"

  public var queryDocument: String { return operationDefinition.appending(HightlightedCourseFragment.fragmentDefinition) }

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("layoutCollection", arguments: ["limit": 1], type: .object(LayoutCollection.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(layoutCollection: LayoutCollection? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "layoutCollection": layoutCollection.flatMap { (value: LayoutCollection) -> ResultMap in value.resultMap }])
    }

    public var layoutCollection: LayoutCollection? {
      get {
        return (resultMap["layoutCollection"] as? ResultMap).flatMap { LayoutCollection(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "layoutCollection")
      }
    }

    public struct LayoutCollection: GraphQLSelectionSet {
      public static let possibleTypes = ["LayoutCollection"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("items", type: .nonNull(.list(.object(Item.selections)))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(items: [Item?]) {
        self.init(unsafeResultMap: ["__typename": "LayoutCollection", "items": items.map { (value: Item?) -> ResultMap? in value.flatMap { (value: Item) -> ResultMap in value.resultMap } }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var items: [Item?] {
        get {
          return (resultMap["items"] as! [ResultMap?]).map { (value: ResultMap?) -> Item? in value.flatMap { (value: ResultMap) -> Item in Item(unsafeResultMap: value) } }
        }
        set {
          resultMap.updateValue(newValue.map { (value: Item?) -> ResultMap? in value.flatMap { (value: Item) -> ResultMap in value.resultMap } }, forKey: "items")
        }
      }

      public struct Item: GraphQLSelectionSet {
        public static let possibleTypes = ["Layout"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("title", type: .scalar(String.self)),
          GraphQLField("slug", type: .scalar(String.self)),
          GraphQLField("contentModulesCollection", type: .object(ContentModulesCollection.selections)),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(title: String? = nil, slug: String? = nil, contentModulesCollection: ContentModulesCollection? = nil) {
          self.init(unsafeResultMap: ["__typename": "Layout", "title": title, "slug": slug, "contentModulesCollection": contentModulesCollection.flatMap { (value: ContentModulesCollection) -> ResultMap in value.resultMap }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var title: String? {
          get {
            return resultMap["title"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "title")
          }
        }

        public var slug: String? {
          get {
            return resultMap["slug"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "slug")
          }
        }

        public var contentModulesCollection: ContentModulesCollection? {
          get {
            return (resultMap["contentModulesCollection"] as? ResultMap).flatMap { ContentModulesCollection(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "contentModulesCollection")
          }
        }

        public struct ContentModulesCollection: GraphQLSelectionSet {
          public static let possibleTypes = ["LayoutContentModulesCollection"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("items", type: .nonNull(.list(.object(Item.selections)))),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(items: [Item?]) {
            self.init(unsafeResultMap: ["__typename": "LayoutContentModulesCollection", "items": items.map { (value: Item?) -> ResultMap? in value.flatMap { (value: Item) -> ResultMap in value.resultMap } }])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var items: [Item?] {
            get {
              return (resultMap["items"] as! [ResultMap?]).map { (value: ResultMap?) -> Item? in value.flatMap { (value: ResultMap) -> Item in Item(unsafeResultMap: value) } }
            }
            set {
              resultMap.updateValue(newValue.map { (value: Item?) -> ResultMap? in value.flatMap { (value: Item) -> ResultMap in value.resultMap } }, forKey: "items")
            }
          }

          public struct Item: GraphQLSelectionSet {
            public static let possibleTypes = ["LayoutCopy", "LayoutHeroImage", "LayoutHighlightedCourse"]

            public static let selections: [GraphQLSelection] = [
              GraphQLTypeCase(
                variants: ["LayoutHighlightedCourse": AsLayoutHighlightedCourse.selections, "LayoutCopy": AsLayoutCopy.selections, "LayoutHeroImage": AsLayoutHeroImage.selections],
                default: [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                ]
              )
            ]

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public static func makeLayoutHighlightedCourse(course: AsLayoutHighlightedCourse.Course? = nil) -> Item {
              return Item(unsafeResultMap: ["__typename": "LayoutHighlightedCourse", "course": course.flatMap { (value: AsLayoutHighlightedCourse.Course) -> ResultMap in value.resultMap }])
            }

            public static func makeLayoutCopy(title: String? = nil, headline: String? = nil, copy: String? = nil, ctaTitle: String? = nil, ctaLink: String? = nil, visualStyle: String? = nil) -> Item {
              return Item(unsafeResultMap: ["__typename": "LayoutCopy", "title": title, "headline": headline, "copy": copy, "ctaTitle": ctaTitle, "ctaLink": ctaLink, "visualStyle": visualStyle])
            }

            public static func makeLayoutHeroImage(title: String? = nil, headline: String? = nil, backgroundImage: AsLayoutHeroImage.BackgroundImage? = nil) -> Item {
              return Item(unsafeResultMap: ["__typename": "LayoutHeroImage", "title": title, "headline": headline, "backgroundImage": backgroundImage.flatMap { (value: AsLayoutHeroImage.BackgroundImage) -> ResultMap in value.resultMap }])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            public var asLayoutHighlightedCourse: AsLayoutHighlightedCourse? {
              get {
                if !AsLayoutHighlightedCourse.possibleTypes.contains(__typename) { return nil }
                return AsLayoutHighlightedCourse(unsafeResultMap: resultMap)
              }
              set {
                guard let newValue = newValue else { return }
                resultMap = newValue.resultMap
              }
            }

            public struct AsLayoutHighlightedCourse: GraphQLSelectionSet {
              public static let possibleTypes = ["LayoutHighlightedCourse"]

              public static let selections: [GraphQLSelection] = [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("course", type: .object(Course.selections)),
              ]

              public private(set) var resultMap: ResultMap

              public init(unsafeResultMap: ResultMap) {
                self.resultMap = unsafeResultMap
              }

              public init(course: Course? = nil) {
                self.init(unsafeResultMap: ["__typename": "LayoutHighlightedCourse", "course": course.flatMap { (value: Course) -> ResultMap in value.resultMap }])
              }

              public var __typename: String {
                get {
                  return resultMap["__typename"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "__typename")
                }
              }

              public var course: Course? {
                get {
                  return (resultMap["course"] as? ResultMap).flatMap { Course(unsafeResultMap: $0) }
                }
                set {
                  resultMap.updateValue(newValue?.resultMap, forKey: "course")
                }
              }

              public struct Course: GraphQLSelectionSet {
                public static let possibleTypes = ["Course"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLFragmentSpread(HightlightedCourseFragment.self),
                ]

                public private(set) var resultMap: ResultMap

                public init(unsafeResultMap: ResultMap) {
                  self.resultMap = unsafeResultMap
                }

                public var __typename: String {
                  get {
                    return resultMap["__typename"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "__typename")
                  }
                }

                public var fragments: Fragments {
                  get {
                    return Fragments(unsafeResultMap: resultMap)
                  }
                  set {
                    resultMap += newValue.resultMap
                  }
                }

                public struct Fragments {
                  public private(set) var resultMap: ResultMap

                  public init(unsafeResultMap: ResultMap) {
                    self.resultMap = unsafeResultMap
                  }

                  public var hightlightedCourseFragment: HightlightedCourseFragment {
                    get {
                      return HightlightedCourseFragment(unsafeResultMap: resultMap)
                    }
                    set {
                      resultMap += newValue.resultMap
                    }
                  }
                }
              }
            }

            public var asLayoutCopy: AsLayoutCopy? {
              get {
                if !AsLayoutCopy.possibleTypes.contains(__typename) { return nil }
                return AsLayoutCopy(unsafeResultMap: resultMap)
              }
              set {
                guard let newValue = newValue else { return }
                resultMap = newValue.resultMap
              }
            }

            public struct AsLayoutCopy: GraphQLSelectionSet {
              public static let possibleTypes = ["LayoutCopy"]

              public static let selections: [GraphQLSelection] = [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("title", type: .scalar(String.self)),
                GraphQLField("headline", type: .scalar(String.self)),
                GraphQLField("copy", type: .scalar(String.self)),
                GraphQLField("ctaTitle", type: .scalar(String.self)),
                GraphQLField("ctaLink", type: .scalar(String.self)),
                GraphQLField("visualStyle", type: .scalar(String.self)),
              ]

              public private(set) var resultMap: ResultMap

              public init(unsafeResultMap: ResultMap) {
                self.resultMap = unsafeResultMap
              }

              public init(title: String? = nil, headline: String? = nil, copy: String? = nil, ctaTitle: String? = nil, ctaLink: String? = nil, visualStyle: String? = nil) {
                self.init(unsafeResultMap: ["__typename": "LayoutCopy", "title": title, "headline": headline, "copy": copy, "ctaTitle": ctaTitle, "ctaLink": ctaLink, "visualStyle": visualStyle])
              }

              public var __typename: String {
                get {
                  return resultMap["__typename"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "__typename")
                }
              }

              public var title: String? {
                get {
                  return resultMap["title"] as? String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "title")
                }
              }

              public var headline: String? {
                get {
                  return resultMap["headline"] as? String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "headline")
                }
              }

              public var copy: String? {
                get {
                  return resultMap["copy"] as? String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "copy")
                }
              }

              public var ctaTitle: String? {
                get {
                  return resultMap["ctaTitle"] as? String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "ctaTitle")
                }
              }

              public var ctaLink: String? {
                get {
                  return resultMap["ctaLink"] as? String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "ctaLink")
                }
              }

              public var visualStyle: String? {
                get {
                  return resultMap["visualStyle"] as? String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "visualStyle")
                }
              }
            }

            public var asLayoutHeroImage: AsLayoutHeroImage? {
              get {
                if !AsLayoutHeroImage.possibleTypes.contains(__typename) { return nil }
                return AsLayoutHeroImage(unsafeResultMap: resultMap)
              }
              set {
                guard let newValue = newValue else { return }
                resultMap = newValue.resultMap
              }
            }

            public struct AsLayoutHeroImage: GraphQLSelectionSet {
              public static let possibleTypes = ["LayoutHeroImage"]

              public static let selections: [GraphQLSelection] = [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("title", type: .scalar(String.self)),
                GraphQLField("headline", type: .scalar(String.self)),
                GraphQLField("backgroundImage", type: .object(BackgroundImage.selections)),
              ]

              public private(set) var resultMap: ResultMap

              public init(unsafeResultMap: ResultMap) {
                self.resultMap = unsafeResultMap
              }

              public init(title: String? = nil, headline: String? = nil, backgroundImage: BackgroundImage? = nil) {
                self.init(unsafeResultMap: ["__typename": "LayoutHeroImage", "title": title, "headline": headline, "backgroundImage": backgroundImage.flatMap { (value: BackgroundImage) -> ResultMap in value.resultMap }])
              }

              public var __typename: String {
                get {
                  return resultMap["__typename"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "__typename")
                }
              }

              public var title: String? {
                get {
                  return resultMap["title"] as? String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "title")
                }
              }

              public var headline: String? {
                get {
                  return resultMap["headline"] as? String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "headline")
                }
              }

              public var backgroundImage: BackgroundImage? {
                get {
                  return (resultMap["backgroundImage"] as? ResultMap).flatMap { BackgroundImage(unsafeResultMap: $0) }
                }
                set {
                  resultMap.updateValue(newValue?.resultMap, forKey: "backgroundImage")
                }
              }

              public struct BackgroundImage: GraphQLSelectionSet {
                public static let possibleTypes = ["Asset"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("url", type: .scalar(String.self)),
                ]

                public private(set) var resultMap: ResultMap

                public init(unsafeResultMap: ResultMap) {
                  self.resultMap = unsafeResultMap
                }

                public init(url: String? = nil) {
                  self.init(unsafeResultMap: ["__typename": "Asset", "url": url])
                }

                public var __typename: String {
                  get {
                    return resultMap["__typename"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "__typename")
                  }
                }

                public var url: String? {
                  get {
                    return resultMap["url"] as? String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "url")
                  }
                }
              }
            }
          }
        }
      }
    }
  }
}

public final class CourseBySlugQuery: GraphQLQuery {
  public let operationDefinition =
    "query CourseBySlug($slug: String!) {\n  courseCollection(where: {slug: $slug}) {\n    __typename\n    items {\n      __typename\n      ...CourseFragment\n    }\n  }\n}"

  public var queryDocument: String { return operationDefinition.appending(CourseFragment.fragmentDefinition).appending(LessonFragment.fragmentDefinition).appending(LessonCodeSnippetFragment.fragmentDefinition).appending(LessonImageFragment.fragmentDefinition).appending(LessonCopyFragment.fragmentDefinition).appending(CategoryFragment.fragmentDefinition) }

  public var slug: String

  public init(slug: String) {
    self.slug = slug
  }

  public var variables: GraphQLMap? {
    return ["slug": slug]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("courseCollection", arguments: ["where": ["slug": GraphQLVariable("slug")]], type: .object(CourseCollection.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(courseCollection: CourseCollection? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "courseCollection": courseCollection.flatMap { (value: CourseCollection) -> ResultMap in value.resultMap }])
    }

    public var courseCollection: CourseCollection? {
      get {
        return (resultMap["courseCollection"] as? ResultMap).flatMap { CourseCollection(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "courseCollection")
      }
    }

    public struct CourseCollection: GraphQLSelectionSet {
      public static let possibleTypes = ["CourseCollection"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("items", type: .nonNull(.list(.object(Item.selections)))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(items: [Item?]) {
        self.init(unsafeResultMap: ["__typename": "CourseCollection", "items": items.map { (value: Item?) -> ResultMap? in value.flatMap { (value: Item) -> ResultMap in value.resultMap } }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var items: [Item?] {
        get {
          return (resultMap["items"] as! [ResultMap?]).map { (value: ResultMap?) -> Item? in value.flatMap { (value: ResultMap) -> Item in Item(unsafeResultMap: value) } }
        }
        set {
          resultMap.updateValue(newValue.map { (value: Item?) -> ResultMap? in value.flatMap { (value: Item) -> ResultMap in value.resultMap } }, forKey: "items")
        }
      }

      public struct Item: GraphQLSelectionSet {
        public static let possibleTypes = ["Course"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLFragmentSpread(CourseFragment.self),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var fragments: Fragments {
          get {
            return Fragments(unsafeResultMap: resultMap)
          }
          set {
            resultMap += newValue.resultMap
          }
        }

        public struct Fragments {
          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public var courseFragment: CourseFragment {
            get {
              return CourseFragment(unsafeResultMap: resultMap)
            }
            set {
              resultMap += newValue.resultMap
            }
          }
        }
      }
    }
  }
}

public final class CoursesOfCategoryIdQuery: GraphQLQuery {
  public let operationDefinition =
    "query CoursesOfCategoryId($categoryId: String!) {\n  category(id: $categoryId) {\n    __typename\n    linkedFrom {\n      __typename\n      entryCollection {\n        __typename\n        items {\n          __typename\n          ...CourseFragment\n        }\n      }\n    }\n  }\n}"

  public var queryDocument: String { return operationDefinition.appending(CourseFragment.fragmentDefinition).appending(LessonFragment.fragmentDefinition).appending(LessonCodeSnippetFragment.fragmentDefinition).appending(LessonImageFragment.fragmentDefinition).appending(LessonCopyFragment.fragmentDefinition).appending(CategoryFragment.fragmentDefinition) }

  public var categoryId: String

  public init(categoryId: String) {
    self.categoryId = categoryId
  }

  public var variables: GraphQLMap? {
    return ["categoryId": categoryId]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("category", arguments: ["id": GraphQLVariable("categoryId")], type: .object(Category.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(category: Category? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "category": category.flatMap { (value: Category) -> ResultMap in value.resultMap }])
    }

    public var category: Category? {
      get {
        return (resultMap["category"] as? ResultMap).flatMap { Category(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "category")
      }
    }

    public struct Category: GraphQLSelectionSet {
      public static let possibleTypes = ["Category"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("linkedFrom", type: .object(LinkedFrom.selections)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(linkedFrom: LinkedFrom? = nil) {
        self.init(unsafeResultMap: ["__typename": "Category", "linkedFrom": linkedFrom.flatMap { (value: LinkedFrom) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var linkedFrom: LinkedFrom? {
        get {
          return (resultMap["linkedFrom"] as? ResultMap).flatMap { LinkedFrom(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "linkedFrom")
        }
      }

      public struct LinkedFrom: GraphQLSelectionSet {
        public static let possibleTypes = ["CategoryLinkingCollections"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("entryCollection", type: .object(EntryCollection.selections)),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(entryCollection: EntryCollection? = nil) {
          self.init(unsafeResultMap: ["__typename": "CategoryLinkingCollections", "entryCollection": entryCollection.flatMap { (value: EntryCollection) -> ResultMap in value.resultMap }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var entryCollection: EntryCollection? {
          get {
            return (resultMap["entryCollection"] as? ResultMap).flatMap { EntryCollection(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "entryCollection")
          }
        }

        public struct EntryCollection: GraphQLSelectionSet {
          public static let possibleTypes = ["EntryCollection"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("items", type: .nonNull(.list(.object(Item.selections)))),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(items: [Item?]) {
            self.init(unsafeResultMap: ["__typename": "EntryCollection", "items": items.map { (value: Item?) -> ResultMap? in value.flatMap { (value: Item) -> ResultMap in value.resultMap } }])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var items: [Item?] {
            get {
              return (resultMap["items"] as! [ResultMap?]).map { (value: ResultMap?) -> Item? in value.flatMap { (value: ResultMap) -> Item in Item(unsafeResultMap: value) } }
            }
            set {
              resultMap.updateValue(newValue.map { (value: Item?) -> ResultMap? in value.flatMap { (value: Item) -> ResultMap in value.resultMap } }, forKey: "items")
            }
          }

          public struct Item: GraphQLSelectionSet {
            public static let possibleTypes = ["Course", "Lesson", "LessonCodeSnippets", "LessonCopy", "LessonImage", "Category", "LayoutCopy", "LayoutHeroImage", "LayoutHighlightedCourse", "Layout"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLFragmentSpread(CourseFragment.self),
            ]

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public static func makeLesson() -> Item {
              return Item(unsafeResultMap: ["__typename": "Lesson"])
            }

            public static func makeLessonCodeSnippets() -> Item {
              return Item(unsafeResultMap: ["__typename": "LessonCodeSnippets"])
            }

            public static func makeLessonCopy() -> Item {
              return Item(unsafeResultMap: ["__typename": "LessonCopy"])
            }

            public static func makeLessonImage() -> Item {
              return Item(unsafeResultMap: ["__typename": "LessonImage"])
            }

            public static func makeCategory() -> Item {
              return Item(unsafeResultMap: ["__typename": "Category"])
            }

            public static func makeLayoutCopy() -> Item {
              return Item(unsafeResultMap: ["__typename": "LayoutCopy"])
            }

            public static func makeLayoutHeroImage() -> Item {
              return Item(unsafeResultMap: ["__typename": "LayoutHeroImage"])
            }

            public static func makeLayoutHighlightedCourse() -> Item {
              return Item(unsafeResultMap: ["__typename": "LayoutHighlightedCourse"])
            }

            public static func makeLayout() -> Item {
              return Item(unsafeResultMap: ["__typename": "Layout"])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            public var fragments: Fragments {
              get {
                return Fragments(unsafeResultMap: resultMap)
              }
              set {
                resultMap += newValue.resultMap
              }
            }

            public struct Fragments {
              public private(set) var resultMap: ResultMap

              public init(unsafeResultMap: ResultMap) {
                self.resultMap = unsafeResultMap
              }

              public var courseFragment: CourseFragment? {
                get {
                  if !CourseFragment.possibleTypes.contains(resultMap["__typename"]! as! String) { return nil }
                  return CourseFragment(unsafeResultMap: resultMap)
                }
                set {
                  guard let newValue = newValue else { return }
                  resultMap += newValue.resultMap
                }
              }
            }
          }
        }
      }
    }
  }
}

public final class CoursesQuery: GraphQLQuery {
  public let operationDefinition =
    "query Courses {\n  courseCollection {\n    __typename\n    items {\n      __typename\n      ...CourseFragment\n    }\n  }\n}"

  public var queryDocument: String { return operationDefinition.appending(CourseFragment.fragmentDefinition).appending(LessonFragment.fragmentDefinition).appending(LessonCodeSnippetFragment.fragmentDefinition).appending(LessonImageFragment.fragmentDefinition).appending(LessonCopyFragment.fragmentDefinition).appending(CategoryFragment.fragmentDefinition) }

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("courseCollection", type: .object(CourseCollection.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(courseCollection: CourseCollection? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "courseCollection": courseCollection.flatMap { (value: CourseCollection) -> ResultMap in value.resultMap }])
    }

    public var courseCollection: CourseCollection? {
      get {
        return (resultMap["courseCollection"] as? ResultMap).flatMap { CourseCollection(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "courseCollection")
      }
    }

    public struct CourseCollection: GraphQLSelectionSet {
      public static let possibleTypes = ["CourseCollection"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("items", type: .nonNull(.list(.object(Item.selections)))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(items: [Item?]) {
        self.init(unsafeResultMap: ["__typename": "CourseCollection", "items": items.map { (value: Item?) -> ResultMap? in value.flatMap { (value: Item) -> ResultMap in value.resultMap } }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var items: [Item?] {
        get {
          return (resultMap["items"] as! [ResultMap?]).map { (value: ResultMap?) -> Item? in value.flatMap { (value: ResultMap) -> Item in Item(unsafeResultMap: value) } }
        }
        set {
          resultMap.updateValue(newValue.map { (value: Item?) -> ResultMap? in value.flatMap { (value: Item) -> ResultMap in value.resultMap } }, forKey: "items")
        }
      }

      public struct Item: GraphQLSelectionSet {
        public static let possibleTypes = ["Course"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLFragmentSpread(CourseFragment.self),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var fragments: Fragments {
          get {
            return Fragments(unsafeResultMap: resultMap)
          }
          set {
            resultMap += newValue.resultMap
          }
        }

        public struct Fragments {
          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public var courseFragment: CourseFragment {
            get {
              return CourseFragment(unsafeResultMap: resultMap)
            }
            set {
              resultMap += newValue.resultMap
            }
          }
        }
      }
    }
  }
}

public final class CategoriesQuery: GraphQLQuery {
  public let operationDefinition =
    "query Categories {\n  categoryCollection {\n    __typename\n    items {\n      __typename\n      ...CategoryFragment\n    }\n  }\n}"

  public var queryDocument: String { return operationDefinition.appending(CategoryFragment.fragmentDefinition) }

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("categoryCollection", type: .object(CategoryCollection.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(categoryCollection: CategoryCollection? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "categoryCollection": categoryCollection.flatMap { (value: CategoryCollection) -> ResultMap in value.resultMap }])
    }

    public var categoryCollection: CategoryCollection? {
      get {
        return (resultMap["categoryCollection"] as? ResultMap).flatMap { CategoryCollection(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "categoryCollection")
      }
    }

    public struct CategoryCollection: GraphQLSelectionSet {
      public static let possibleTypes = ["CategoryCollection"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("items", type: .nonNull(.list(.object(Item.selections)))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(items: [Item?]) {
        self.init(unsafeResultMap: ["__typename": "CategoryCollection", "items": items.map { (value: Item?) -> ResultMap? in value.flatMap { (value: Item) -> ResultMap in value.resultMap } }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var items: [Item?] {
        get {
          return (resultMap["items"] as! [ResultMap?]).map { (value: ResultMap?) -> Item? in value.flatMap { (value: ResultMap) -> Item in Item(unsafeResultMap: value) } }
        }
        set {
          resultMap.updateValue(newValue.map { (value: Item?) -> ResultMap? in value.flatMap { (value: Item) -> ResultMap in value.resultMap } }, forKey: "items")
        }
      }

      public struct Item: GraphQLSelectionSet {
        public static let possibleTypes = ["Category"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLFragmentSpread(CategoryFragment.self),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var fragments: Fragments {
          get {
            return Fragments(unsafeResultMap: resultMap)
          }
          set {
            resultMap += newValue.resultMap
          }
        }

        public struct Fragments {
          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public var categoryFragment: CategoryFragment {
            get {
              return CategoryFragment(unsafeResultMap: resultMap)
            }
            set {
              resultMap += newValue.resultMap
            }
          }
        }
      }
    }
  }
}

public struct HightlightedCourseFragment: GraphQLFragment {
  public static let fragmentDefinition =
    "fragment HightlightedCourseFragment on Course {\n  __typename\n  sys {\n    __typename\n    id\n  }\n  slug\n  title\n  shortDescription\n  image {\n    __typename\n    url\n  }\n}"

  public static let possibleTypes = ["Course"]

  public static let selections: [GraphQLSelection] = [
    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
    GraphQLField("sys", type: .nonNull(.object(Sy.selections))),
    GraphQLField("slug", type: .scalar(String.self)),
    GraphQLField("title", type: .scalar(String.self)),
    GraphQLField("shortDescription", type: .scalar(String.self)),
    GraphQLField("image", type: .object(Image.selections)),
  ]

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public init(sys: Sy, slug: String? = nil, title: String? = nil, shortDescription: String? = nil, image: Image? = nil) {
    self.init(unsafeResultMap: ["__typename": "Course", "sys": sys.resultMap, "slug": slug, "title": title, "shortDescription": shortDescription, "image": image.flatMap { (value: Image) -> ResultMap in value.resultMap }])
  }

  public var __typename: String {
    get {
      return resultMap["__typename"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "__typename")
    }
  }

  public var sys: Sy {
    get {
      return Sy(unsafeResultMap: resultMap["sys"]! as! ResultMap)
    }
    set {
      resultMap.updateValue(newValue.resultMap, forKey: "sys")
    }
  }

  public var slug: String? {
    get {
      return resultMap["slug"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "slug")
    }
  }

  public var title: String? {
    get {
      return resultMap["title"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "title")
    }
  }

  public var shortDescription: String? {
    get {
      return resultMap["shortDescription"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "shortDescription")
    }
  }

  public var image: Image? {
    get {
      return (resultMap["image"] as? ResultMap).flatMap { Image(unsafeResultMap: $0) }
    }
    set {
      resultMap.updateValue(newValue?.resultMap, forKey: "image")
    }
  }

  public struct Sy: GraphQLSelectionSet {
    public static let possibleTypes = ["Sys"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("id", type: .nonNull(.scalar(String.self))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(id: String) {
      self.init(unsafeResultMap: ["__typename": "Sys", "id": id])
    }

    public var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

    public var id: String {
      get {
        return resultMap["id"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "id")
      }
    }
  }

  public struct Image: GraphQLSelectionSet {
    public static let possibleTypes = ["Asset"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("url", type: .scalar(String.self)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(url: String? = nil) {
      self.init(unsafeResultMap: ["__typename": "Asset", "url": url])
    }

    public var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

    public var url: String? {
      get {
        return resultMap["url"] as? String
      }
      set {
        resultMap.updateValue(newValue, forKey: "url")
      }
    }
  }
}

public struct CourseFragment: GraphQLFragment {
  public static let fragmentDefinition =
    "fragment CourseFragment on Course {\n  __typename\n  sys {\n    __typename\n    id\n  }\n  title\n  slug\n  image {\n    __typename\n    url\n  }\n  lessonsCollection {\n    __typename\n    items {\n      __typename\n      ...LessonFragment\n    }\n  }\n  categoriesCollection {\n    __typename\n    items {\n      __typename\n      ...CategoryFragment\n    }\n  }\n  shortDescription\n  description\n  duration\n  skillLevel\n}"

  public static let possibleTypes = ["Course"]

  public static let selections: [GraphQLSelection] = [
    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
    GraphQLField("sys", type: .nonNull(.object(Sy.selections))),
    GraphQLField("title", type: .scalar(String.self)),
    GraphQLField("slug", type: .scalar(String.self)),
    GraphQLField("image", type: .object(Image.selections)),
    GraphQLField("lessonsCollection", type: .object(LessonsCollection.selections)),
    GraphQLField("categoriesCollection", type: .object(CategoriesCollection.selections)),
    GraphQLField("shortDescription", type: .scalar(String.self)),
    GraphQLField("description", type: .scalar(String.self)),
    GraphQLField("duration", type: .scalar(Int.self)),
    GraphQLField("skillLevel", type: .scalar(String.self)),
  ]

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public init(sys: Sy, title: String? = nil, slug: String? = nil, image: Image? = nil, lessonsCollection: LessonsCollection? = nil, categoriesCollection: CategoriesCollection? = nil, shortDescription: String? = nil, description: String? = nil, duration: Int? = nil, skillLevel: String? = nil) {
    self.init(unsafeResultMap: ["__typename": "Course", "sys": sys.resultMap, "title": title, "slug": slug, "image": image.flatMap { (value: Image) -> ResultMap in value.resultMap }, "lessonsCollection": lessonsCollection.flatMap { (value: LessonsCollection) -> ResultMap in value.resultMap }, "categoriesCollection": categoriesCollection.flatMap { (value: CategoriesCollection) -> ResultMap in value.resultMap }, "shortDescription": shortDescription, "description": description, "duration": duration, "skillLevel": skillLevel])
  }

  public var __typename: String {
    get {
      return resultMap["__typename"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "__typename")
    }
  }

  public var sys: Sy {
    get {
      return Sy(unsafeResultMap: resultMap["sys"]! as! ResultMap)
    }
    set {
      resultMap.updateValue(newValue.resultMap, forKey: "sys")
    }
  }

  public var title: String? {
    get {
      return resultMap["title"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "title")
    }
  }

  public var slug: String? {
    get {
      return resultMap["slug"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "slug")
    }
  }

  public var image: Image? {
    get {
      return (resultMap["image"] as? ResultMap).flatMap { Image(unsafeResultMap: $0) }
    }
    set {
      resultMap.updateValue(newValue?.resultMap, forKey: "image")
    }
  }

  public var lessonsCollection: LessonsCollection? {
    get {
      return (resultMap["lessonsCollection"] as? ResultMap).flatMap { LessonsCollection(unsafeResultMap: $0) }
    }
    set {
      resultMap.updateValue(newValue?.resultMap, forKey: "lessonsCollection")
    }
  }

  public var categoriesCollection: CategoriesCollection? {
    get {
      return (resultMap["categoriesCollection"] as? ResultMap).flatMap { CategoriesCollection(unsafeResultMap: $0) }
    }
    set {
      resultMap.updateValue(newValue?.resultMap, forKey: "categoriesCollection")
    }
  }

  public var shortDescription: String? {
    get {
      return resultMap["shortDescription"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "shortDescription")
    }
  }

  public var description: String? {
    get {
      return resultMap["description"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "description")
    }
  }

  public var duration: Int? {
    get {
      return resultMap["duration"] as? Int
    }
    set {
      resultMap.updateValue(newValue, forKey: "duration")
    }
  }

  public var skillLevel: String? {
    get {
      return resultMap["skillLevel"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "skillLevel")
    }
  }

  public struct Sy: GraphQLSelectionSet {
    public static let possibleTypes = ["Sys"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("id", type: .nonNull(.scalar(String.self))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(id: String) {
      self.init(unsafeResultMap: ["__typename": "Sys", "id": id])
    }

    public var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

    public var id: String {
      get {
        return resultMap["id"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "id")
      }
    }
  }

  public struct Image: GraphQLSelectionSet {
    public static let possibleTypes = ["Asset"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("url", type: .scalar(String.self)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(url: String? = nil) {
      self.init(unsafeResultMap: ["__typename": "Asset", "url": url])
    }

    public var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

    public var url: String? {
      get {
        return resultMap["url"] as? String
      }
      set {
        resultMap.updateValue(newValue, forKey: "url")
      }
    }
  }

  public struct LessonsCollection: GraphQLSelectionSet {
    public static let possibleTypes = ["CourseLessonsCollection"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("items", type: .nonNull(.list(.object(Item.selections)))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(items: [Item?]) {
      self.init(unsafeResultMap: ["__typename": "CourseLessonsCollection", "items": items.map { (value: Item?) -> ResultMap? in value.flatMap { (value: Item) -> ResultMap in value.resultMap } }])
    }

    public var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

    public var items: [Item?] {
      get {
        return (resultMap["items"] as! [ResultMap?]).map { (value: ResultMap?) -> Item? in value.flatMap { (value: ResultMap) -> Item in Item(unsafeResultMap: value) } }
      }
      set {
        resultMap.updateValue(newValue.map { (value: Item?) -> ResultMap? in value.flatMap { (value: Item) -> ResultMap in value.resultMap } }, forKey: "items")
      }
    }

    public struct Item: GraphQLSelectionSet {
      public static let possibleTypes = ["Lesson"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLFragmentSpread(LessonFragment.self),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var fragments: Fragments {
        get {
          return Fragments(unsafeResultMap: resultMap)
        }
        set {
          resultMap += newValue.resultMap
        }
      }

      public struct Fragments {
        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public var lessonFragment: LessonFragment {
          get {
            return LessonFragment(unsafeResultMap: resultMap)
          }
          set {
            resultMap += newValue.resultMap
          }
        }
      }
    }
  }

  public struct CategoriesCollection: GraphQLSelectionSet {
    public static let possibleTypes = ["CourseCategoriesCollection"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("items", type: .nonNull(.list(.object(Item.selections)))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(items: [Item?]) {
      self.init(unsafeResultMap: ["__typename": "CourseCategoriesCollection", "items": items.map { (value: Item?) -> ResultMap? in value.flatMap { (value: Item) -> ResultMap in value.resultMap } }])
    }

    public var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

    public var items: [Item?] {
      get {
        return (resultMap["items"] as! [ResultMap?]).map { (value: ResultMap?) -> Item? in value.flatMap { (value: ResultMap) -> Item in Item(unsafeResultMap: value) } }
      }
      set {
        resultMap.updateValue(newValue.map { (value: Item?) -> ResultMap? in value.flatMap { (value: Item) -> ResultMap in value.resultMap } }, forKey: "items")
      }
    }

    public struct Item: GraphQLSelectionSet {
      public static let possibleTypes = ["Category"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLFragmentSpread(CategoryFragment.self),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var fragments: Fragments {
        get {
          return Fragments(unsafeResultMap: resultMap)
        }
        set {
          resultMap += newValue.resultMap
        }
      }

      public struct Fragments {
        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public var categoryFragment: CategoryFragment {
          get {
            return CategoryFragment(unsafeResultMap: resultMap)
          }
          set {
            resultMap += newValue.resultMap
          }
        }
      }
    }
  }
}

public struct LessonFragment: GraphQLFragment {
  public static let fragmentDefinition =
    "fragment LessonFragment on Lesson {\n  __typename\n  title\n  slug\n  modulesCollection {\n    __typename\n    items {\n      __typename\n      ... on LessonCodeSnippets {\n        ...LessonCodeSnippetFragment\n      }\n      ... on LessonImage {\n        ...LessonImageFragment\n      }\n      ... on LessonCopy {\n        ...LessonCopyFragment\n      }\n    }\n  }\n}"

  public static let possibleTypes = ["Lesson"]

  public static let selections: [GraphQLSelection] = [
    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
    GraphQLField("title", type: .scalar(String.self)),
    GraphQLField("slug", type: .scalar(String.self)),
    GraphQLField("modulesCollection", type: .object(ModulesCollection.selections)),
  ]

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public init(title: String? = nil, slug: String? = nil, modulesCollection: ModulesCollection? = nil) {
    self.init(unsafeResultMap: ["__typename": "Lesson", "title": title, "slug": slug, "modulesCollection": modulesCollection.flatMap { (value: ModulesCollection) -> ResultMap in value.resultMap }])
  }

  public var __typename: String {
    get {
      return resultMap["__typename"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "__typename")
    }
  }

  public var title: String? {
    get {
      return resultMap["title"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "title")
    }
  }

  public var slug: String? {
    get {
      return resultMap["slug"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "slug")
    }
  }

  public var modulesCollection: ModulesCollection? {
    get {
      return (resultMap["modulesCollection"] as? ResultMap).flatMap { ModulesCollection(unsafeResultMap: $0) }
    }
    set {
      resultMap.updateValue(newValue?.resultMap, forKey: "modulesCollection")
    }
  }

  public struct ModulesCollection: GraphQLSelectionSet {
    public static let possibleTypes = ["LessonModulesCollection"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("items", type: .nonNull(.list(.object(Item.selections)))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(items: [Item?]) {
      self.init(unsafeResultMap: ["__typename": "LessonModulesCollection", "items": items.map { (value: Item?) -> ResultMap? in value.flatMap { (value: Item) -> ResultMap in value.resultMap } }])
    }

    public var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

    public var items: [Item?] {
      get {
        return (resultMap["items"] as! [ResultMap?]).map { (value: ResultMap?) -> Item? in value.flatMap { (value: ResultMap) -> Item in Item(unsafeResultMap: value) } }
      }
      set {
        resultMap.updateValue(newValue.map { (value: Item?) -> ResultMap? in value.flatMap { (value: Item) -> ResultMap in value.resultMap } }, forKey: "items")
      }
    }

    public struct Item: GraphQLSelectionSet {
      public static let possibleTypes = ["LessonCodeSnippets", "LessonCopy", "LessonImage"]

      public static let selections: [GraphQLSelection] = [
        GraphQLTypeCase(
          variants: ["LessonCodeSnippets": AsLessonCodeSnippets.selections, "LessonImage": AsLessonImage.selections, "LessonCopy": AsLessonCopy.selections],
          default: [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          ]
        )
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public static func makeLessonCodeSnippets(title: String? = nil, curl: String? = nil, dotNet: String? = nil, javascript: String? = nil, java: String? = nil, javaAndroid: String? = nil, php: String? = nil, python: String? = nil, ruby: String? = nil, swift: String? = nil) -> Item {
        return Item(unsafeResultMap: ["__typename": "LessonCodeSnippets", "title": title, "curl": curl, "dotNet": dotNet, "javascript": javascript, "java": java, "javaAndroid": javaAndroid, "php": php, "python": python, "ruby": ruby, "swift": swift])
      }

      public static func makeLessonCopy(title: String? = nil, copy: String? = nil) -> Item {
        return Item(unsafeResultMap: ["__typename": "LessonCopy", "title": title, "copy": copy])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var asLessonCodeSnippets: AsLessonCodeSnippets? {
        get {
          if !AsLessonCodeSnippets.possibleTypes.contains(__typename) { return nil }
          return AsLessonCodeSnippets(unsafeResultMap: resultMap)
        }
        set {
          guard let newValue = newValue else { return }
          resultMap = newValue.resultMap
        }
      }

      public struct AsLessonCodeSnippets: GraphQLSelectionSet {
        public static let possibleTypes = ["LessonCodeSnippets"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLFragmentSpread(LessonCodeSnippetFragment.self),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(title: String? = nil, curl: String? = nil, dotNet: String? = nil, javascript: String? = nil, java: String? = nil, javaAndroid: String? = nil, php: String? = nil, python: String? = nil, ruby: String? = nil, swift: String? = nil) {
          self.init(unsafeResultMap: ["__typename": "LessonCodeSnippets", "title": title, "curl": curl, "dotNet": dotNet, "javascript": javascript, "java": java, "javaAndroid": javaAndroid, "php": php, "python": python, "ruby": ruby, "swift": swift])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var fragments: Fragments {
          get {
            return Fragments(unsafeResultMap: resultMap)
          }
          set {
            resultMap += newValue.resultMap
          }
        }

        public struct Fragments {
          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public var lessonCodeSnippetFragment: LessonCodeSnippetFragment {
            get {
              return LessonCodeSnippetFragment(unsafeResultMap: resultMap)
            }
            set {
              resultMap += newValue.resultMap
            }
          }
        }
      }

      public var asLessonImage: AsLessonImage? {
        get {
          if !AsLessonImage.possibleTypes.contains(__typename) { return nil }
          return AsLessonImage(unsafeResultMap: resultMap)
        }
        set {
          guard let newValue = newValue else { return }
          resultMap = newValue.resultMap
        }
      }

      public struct AsLessonImage: GraphQLSelectionSet {
        public static let possibleTypes = ["LessonImage"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLFragmentSpread(LessonImageFragment.self),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var fragments: Fragments {
          get {
            return Fragments(unsafeResultMap: resultMap)
          }
          set {
            resultMap += newValue.resultMap
          }
        }

        public struct Fragments {
          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public var lessonImageFragment: LessonImageFragment {
            get {
              return LessonImageFragment(unsafeResultMap: resultMap)
            }
            set {
              resultMap += newValue.resultMap
            }
          }
        }
      }

      public var asLessonCopy: AsLessonCopy? {
        get {
          if !AsLessonCopy.possibleTypes.contains(__typename) { return nil }
          return AsLessonCopy(unsafeResultMap: resultMap)
        }
        set {
          guard let newValue = newValue else { return }
          resultMap = newValue.resultMap
        }
      }

      public struct AsLessonCopy: GraphQLSelectionSet {
        public static let possibleTypes = ["LessonCopy"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLFragmentSpread(LessonCopyFragment.self),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(title: String? = nil, copy: String? = nil) {
          self.init(unsafeResultMap: ["__typename": "LessonCopy", "title": title, "copy": copy])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var fragments: Fragments {
          get {
            return Fragments(unsafeResultMap: resultMap)
          }
          set {
            resultMap += newValue.resultMap
          }
        }

        public struct Fragments {
          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public var lessonCopyFragment: LessonCopyFragment {
            get {
              return LessonCopyFragment(unsafeResultMap: resultMap)
            }
            set {
              resultMap += newValue.resultMap
            }
          }
        }
      }
    }
  }
}

public struct LessonCodeSnippetFragment: GraphQLFragment {
  public static let fragmentDefinition =
    "fragment LessonCodeSnippetFragment on LessonCodeSnippets {\n  __typename\n  title\n  curl\n  dotNet\n  javascript\n  java\n  javaAndroid\n  php\n  python\n  ruby\n  swift\n}"

  public static let possibleTypes = ["LessonCodeSnippets"]

  public static let selections: [GraphQLSelection] = [
    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
    GraphQLField("title", type: .scalar(String.self)),
    GraphQLField("curl", type: .scalar(String.self)),
    GraphQLField("dotNet", type: .scalar(String.self)),
    GraphQLField("javascript", type: .scalar(String.self)),
    GraphQLField("java", type: .scalar(String.self)),
    GraphQLField("javaAndroid", type: .scalar(String.self)),
    GraphQLField("php", type: .scalar(String.self)),
    GraphQLField("python", type: .scalar(String.self)),
    GraphQLField("ruby", type: .scalar(String.self)),
    GraphQLField("swift", type: .scalar(String.self)),
  ]

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public init(title: String? = nil, curl: String? = nil, dotNet: String? = nil, javascript: String? = nil, java: String? = nil, javaAndroid: String? = nil, php: String? = nil, python: String? = nil, ruby: String? = nil, swift: String? = nil) {
    self.init(unsafeResultMap: ["__typename": "LessonCodeSnippets", "title": title, "curl": curl, "dotNet": dotNet, "javascript": javascript, "java": java, "javaAndroid": javaAndroid, "php": php, "python": python, "ruby": ruby, "swift": swift])
  }

  public var __typename: String {
    get {
      return resultMap["__typename"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "__typename")
    }
  }

  public var title: String? {
    get {
      return resultMap["title"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "title")
    }
  }

  public var curl: String? {
    get {
      return resultMap["curl"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "curl")
    }
  }

  public var dotNet: String? {
    get {
      return resultMap["dotNet"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "dotNet")
    }
  }

  public var javascript: String? {
    get {
      return resultMap["javascript"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "javascript")
    }
  }

  public var java: String? {
    get {
      return resultMap["java"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "java")
    }
  }

  public var javaAndroid: String? {
    get {
      return resultMap["javaAndroid"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "javaAndroid")
    }
  }

  public var php: String? {
    get {
      return resultMap["php"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "php")
    }
  }

  public var python: String? {
    get {
      return resultMap["python"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "python")
    }
  }

  public var ruby: String? {
    get {
      return resultMap["ruby"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "ruby")
    }
  }

  public var swift: String? {
    get {
      return resultMap["swift"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "swift")
    }
  }
}

public struct LessonImageFragment: GraphQLFragment {
  public static let fragmentDefinition =
    "fragment LessonImageFragment on LessonImage {\n  __typename\n  title\n  caption\n  image {\n    __typename\n    url\n  }\n}"

  public static let possibleTypes = ["LessonImage"]

  public static let selections: [GraphQLSelection] = [
    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
    GraphQLField("title", type: .scalar(String.self)),
    GraphQLField("caption", type: .scalar(String.self)),
    GraphQLField("image", type: .object(Image.selections)),
  ]

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public init(title: String? = nil, caption: String? = nil, image: Image? = nil) {
    self.init(unsafeResultMap: ["__typename": "LessonImage", "title": title, "caption": caption, "image": image.flatMap { (value: Image) -> ResultMap in value.resultMap }])
  }

  public var __typename: String {
    get {
      return resultMap["__typename"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "__typename")
    }
  }

  public var title: String? {
    get {
      return resultMap["title"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "title")
    }
  }

  public var caption: String? {
    get {
      return resultMap["caption"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "caption")
    }
  }

  public var image: Image? {
    get {
      return (resultMap["image"] as? ResultMap).flatMap { Image(unsafeResultMap: $0) }
    }
    set {
      resultMap.updateValue(newValue?.resultMap, forKey: "image")
    }
  }

  public struct Image: GraphQLSelectionSet {
    public static let possibleTypes = ["Asset"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("url", type: .scalar(String.self)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(url: String? = nil) {
      self.init(unsafeResultMap: ["__typename": "Asset", "url": url])
    }

    public var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

    public var url: String? {
      get {
        return resultMap["url"] as? String
      }
      set {
        resultMap.updateValue(newValue, forKey: "url")
      }
    }
  }
}

public struct LessonCopyFragment: GraphQLFragment {
  public static let fragmentDefinition =
    "fragment LessonCopyFragment on LessonCopy {\n  __typename\n  title\n  copy\n}"

  public static let possibleTypes = ["LessonCopy"]

  public static let selections: [GraphQLSelection] = [
    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
    GraphQLField("title", type: .scalar(String.self)),
    GraphQLField("copy", type: .scalar(String.self)),
  ]

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public init(title: String? = nil, copy: String? = nil) {
    self.init(unsafeResultMap: ["__typename": "LessonCopy", "title": title, "copy": copy])
  }

  public var __typename: String {
    get {
      return resultMap["__typename"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "__typename")
    }
  }

  public var title: String? {
    get {
      return resultMap["title"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "title")
    }
  }

  public var copy: String? {
    get {
      return resultMap["copy"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "copy")
    }
  }
}

public struct CategoryFragment: GraphQLFragment {
  public static let fragmentDefinition =
    "fragment CategoryFragment on Category {\n  __typename\n  sys {\n    __typename\n    id\n  }\n  title\n  slug\n}"

  public static let possibleTypes = ["Category"]

  public static let selections: [GraphQLSelection] = [
    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
    GraphQLField("sys", type: .nonNull(.object(Sy.selections))),
    GraphQLField("title", type: .scalar(String.self)),
    GraphQLField("slug", type: .scalar(String.self)),
  ]

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public init(sys: Sy, title: String? = nil, slug: String? = nil) {
    self.init(unsafeResultMap: ["__typename": "Category", "sys": sys.resultMap, "title": title, "slug": slug])
  }

  public var __typename: String {
    get {
      return resultMap["__typename"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "__typename")
    }
  }

  public var sys: Sy {
    get {
      return Sy(unsafeResultMap: resultMap["sys"]! as! ResultMap)
    }
    set {
      resultMap.updateValue(newValue.resultMap, forKey: "sys")
    }
  }

  public var title: String? {
    get {
      return resultMap["title"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "title")
    }
  }

  public var slug: String? {
    get {
      return resultMap["slug"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "slug")
    }
  }

  public struct Sy: GraphQLSelectionSet {
    public static let possibleTypes = ["Sys"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("id", type: .nonNull(.scalar(String.self))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(id: String) {
      self.init(unsafeResultMap: ["__typename": "Sys", "id": id])
    }

    public var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

    public var id: String {
      get {
        return resultMap["id"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "id")
      }
    }
  }
}