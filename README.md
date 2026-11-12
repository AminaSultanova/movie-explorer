# Movie Explorer

A cross-platform mobile and web application built with Flutter for browsing, searching, and inspecting TV shows using the public TVMaze REST API. The project follows Clean Architecture principles and uses the BLoC pattern for predictable state management.

## Features

- **Top-Rated Catalog:** Fetches TV shows on startup and automatically sorts them by rating in descending order.
- **Real-Time Search:** Performs live search queries as the user types and automatically restores the main catalog when the search field is cleared.
- **Detailed Show View:** Displays a collapsible `SliverAppBar` banner with a gradient overlay, rating badge, premiere date, responsive genre tags (`Wrap`), and a clean synopsis.
- **Data Sanitization and Resilience:** Strips raw HTML tags (`<p>`, `<b>`, etc.) from API descriptions using regular expressions, safely handles missing or null fields via Dart Null Safety, displays fallback icons for broken images, and provides a `Retry` button on network failures.
- **Custom Dark Theme:** Styled with a dark color palette (`#121212` background, `#1E1E1E` surface cards) and amber accents (`#FFC107`).

## Architecture

The codebase is organized into three decoupled layers inside `lib/` to separate business logic from network operations and UI rendering:

- **Data Layer (`lib/data/`):** Handles HTTP communication via `Dio`, JSON deserialization, HTML tag cleanup, and rating-based sorting.
- **Logic Layer (`lib/logic/`):** Implements `MovieBloc` to process incoming UI events (`FetchMoviesEvent`, `SearchMoviesEvent`) and emit immutable states (`MovieInitial`, `MovieLoading`, `MovieLoaded`, `MovieError`). Uses `Equatable` for value-based state comparison to prevent unnecessary widget rebuilds.
- **Presentation Layer (`lib/presentation/`):** Consists exclusively of stateless widgets (`StatelessWidget`) that dispatch events to the BLoC and reactively render UI updates via `BlocBuilder`.

Dependencies (`MovieRepository` and `MovieBloc`) are injected at the root of the widget tree in `main.dart` using `RepositoryProvider` and `BlocProvider`.

## Tech Stack

- **Framework:** Flutter (Dart)
- **State Management:** `flutter_bloc`, `equatable`
- **Networking:** `dio`
- **Data Source:** TVMaze Public REST API (`https://www.tvmaze.com/api`)

## Project Structure

```text
lib/
├── data/
│   ├── models/
│   │   └── movie_model.dart        # Data model, null-safe JSON parsing, and Regex HTML cleanup
│   └── repo/
│       └── movie_repository.dart   # Dio HTTP client, error handling, and rating sorting
├── logic/
│   └── bloc/
│       ├── movie_bloc.dart         # Event handlers and state emission logic
│       ├── movie_event.dart        # FetchMoviesEvent and SearchMoviesEvent definitions
│       └── movie_state.dart        # Initial, Loading, Loaded, and Error state definitions
├── presentation/
│   ├── screens/
│   │   ├── catalog_screen.dart     # Main screen with search bar, BlocBuilder, and GridView
│   │   └── detail_screen.dart      # Details screen with CustomScrollView and SliverAppBar
│   └── widgets/
│       └── movie_card.dart         # Reusable grid card widget with rating badge and navigation
└── main.dart                       # Application entry point, dependency injection, and theme setup
```

## API Endpoints Used

- `GET https://api.tvmaze.com/shows` — retrieves the main catalog of TV shows.
- `GET https://api.tvmaze.com/search/shows?q={query}` — searches TV shows matching the user's query.

## Getting Started

### Prerequisites

- Flutter SDK (3.x or higher)
- Dart SDK
- Chrome, Android Emulator, iOS Simulator, or a physical device

### Installation and Run

1. Clone the repository:
   ```bash
   git clone https://github.com/AminaSultanova/movie-explorer.git
   cd movie-explorer
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Run the application:
   ```bash
   flutter run
   ```