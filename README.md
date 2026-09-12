CakeList — Clean MVVM Architecture Summary

1. Model Layer
I created a Cake model conforming to Decodable, Hashable, Comparable, and Identifiable.
Since the API does not provide a unique ID, I used the title as the identifier (alternatively, the image URL could be used).


2. Service Layer (SOLID‑Friendly)
I introduced a CakeService protocol to abstract data fetching.
This follows Dependency Inversion and Single Responsibility, making the networking layer mockable for unit tests.


3. ViewModel (Business Logic + State Management)
Using @MainActor ensures UI updates remain safe and predictable.
By decoupling logic into the ViewModel, SwiftUI preserves state across orientation changes.

I added:

Duplicate removal using Set

Sorting using the model’s Comparable conformance

ViewState enum to model loading/error/success states

4. SwiftUI View with Animations & Retry SwiftUI automatically retains @State / @Observable state during orientation changes without re-fetching. List items fall down and fade into place with .transition(). Swift we have different view states, 
enum ViewState { 
case idle 
case loading 
case loaded([Cake]) 
case error(String) 
} 
code listview for each of the state cases


5. Unit Tests

I wrote isolated tests using a MockCakeService, allowing deterministic success/failure scenarios.

Tests include:

test_loadCakes_succeeds_deduplicatesAndSorts

test_loadCakes_fails_presentsError

test_load_failure_setsErrorMessage

test_viewModel_stateTransitions

I used:

Network Link Conditioner to simulate slow/poor connections

Manual testing (Wi‑Fi on/off)

Xcode Test Navigator + Coverage Report

Browser‑based AI assistance to generate test scaffolding




6. If I Had More Time
Add SwiftLint for consistent formatting

Improve test coverage using AI‑generated test cases

Add image caching

Add accessibility labels

Add offline persistence

Add skeleton loading animations

7. Pull‑to‑Refresh (Most Common Enhancement)

.refreshable {
    await model.load()
}
2. Add a default descriptive image for when image fails to load


