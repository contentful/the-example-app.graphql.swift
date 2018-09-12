
@testable import the_example_app_swift
import XCTest
import Nimble

class ContentfulServiceTests: XCTestCase {

    override func setUp() {
        super.setUp()
        UserDefaults().removeSuite(named: testUserDefaults)
    }

    func testTogglingAPIStates() {

        let initialState = ContentfulService.State(api: .delivery,
                                                   locale: .americanEnglish(),
                                                   editorialFeaturesEnabled: false)
        let contentfulService = ContentfulService(session: Session(userDefaults: UserDefaults(suiteName: testUserDefaults)!),
                                                  credentials: .default,
                                                  state: initialState)


        expect(contentfulService.stateMachine.state.editorialFeaturesEnabled).to(equal( false))

        contentfulService.setAPI(.preview)
        expect(contentfulService.stateMachine.state.api).to(equal(ContentfulService.State.API.preview))

        contentfulService.enableEditorialFeatures(true)
        expect(contentfulService.stateMachine.state.editorialFeaturesEnabled).to(equal(true))

        contentfulService.setAPI(.delivery)
        expect(contentfulService.stateMachine.state.api).to(equal(ContentfulService.State.API.delivery))
    }
}
