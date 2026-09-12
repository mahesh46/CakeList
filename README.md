1. using mvvm architechure
crated cake model, needs to be hasable for list, using string as a unique identifier (or ypu could use image url)
  use url in browser to see model structure "https://raw.githubusercontent.com/Waracle/mobile-coding-test-api/refs/heads/main/cakes"

   struct Cake: Decodable, Hashable, Comparable, Identifiable {
    var id: String { title } // Using title as unique identifier
    let title: String
    let desc: String
    let image: String

     static func < (lhs: Cake, rhs: Cake) -> Bool {
        return lhs.title.localizedCaseInsensitiveCompare(rhs.title) == .orderedAscending
    }

    used stackoverflow and google to look up hasable syntax
2.   created a cake service protocol, for fetching cakes. and a service class to fetch the data from url session, using the service protocal.
     using solid principle  -abstraction (dependency inversion principle), single responsibility
     needed later for mock testing.
    
3. create viewmodel, By decoupling business logic into a @MainActor ViewModel, UI states remain preserved across orientation changes.

     need to Remove duplicates and sort , use Arry, set to remove ducplicates and sorted function.

3.SwiftUI View with Animations & Retry
 SwiftUI automatically retains @State / @Observable state during orientation changes without re-fetching.
 List items fall down and fade into place with .transition().
Swift
  we have different view states,
  enum ViewState {
    case idle
    case loading
    case loaded([Cake])
    case error(String)
}
code listview for each of the state cases

add button on list item to bring up sheet with cake descriptipn

.4. Unit Tests
First instance do manuual test. try and test for each view state
1. with wifi enabled run app and view cake list, and tap to bring up sheet with detail
2. turn wifi off and run app, should get the network error
3. uses networklink conditioner on macbook setting for slow internet connections

Fast, isolated unit tests using a mock service:
Swift

tests
    test viewmodel
        test_loadCakes_fails_presentsError
        test_load_failure_setsErrorMessage
    test success and falure of cakelist
        test_loadCakes_succeeds_deduplicatesAndSorts
        test_loadCakes_fails_presentsError
    run tests in test navigator, then show report navigator then check coverage
    
    used browser ai to generate test
    CakeListViewModelLoadCakesErrorTests
    If I had more time.
    I would use AI to help with code coverage, tests, and swift lint to keep code clean and compact.
    
