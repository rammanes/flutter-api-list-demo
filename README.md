# Flutter API Explorer – Technical Assessment for Virtual Switch International

A simple, responsive Flutter mobile app that fetches, searches, filters, and displays details from multiple public APIs using a clean **BottomNavigationBar** structure.

**Features implemented:**
- Fetch and display lists from three public APIs:
  - JSONPlaceholder (`/posts`) – simple text-based posts
  - Open Library (`/search.json`) – book search results
  - Rick and Morty (`/character`) – character list with images and status
- Real-time search bar to filter items per tab
- Tap any item to view a detail screen with relevant information
- Loading indicators, graceful error handling, and pull-to-refresh support
- Responsive layout that adapts well to phones and tablets
- Tab state preserved when switching (no unnecessary reloads, scroll/search position kept)

**Why multiple tabs / BottomNavigationBar?**  
The task required implementing just one API, but I chose to handle three diverse public APIs (different response structures, data types, and UI requirements) in one cohesive mini-app. This demonstrates:
- Better code organization and modularity
- Proper navigation patterns for multi-feature apps
- Ability to manage multiple data sources cleanly
All while keeping the implementation focused, clean, and production-like.

**Tech choices (kept simple & clean):**
- **State management**: `flutter_bloc` (Bloc pattern) per feature/tab for clear separation of concerns, predictable state, and easy testing
- **HTTP client**: `http` package
- **Icons**: Iconsax (modern line icons for a polished look)
- **Image loading** (Rick and Morty): `cached_network_image` for better performance & placeholders
- **Local persistence**: `shared_preferences` for book search history
- **Routing**: `go_router` for declarative navigation and nested routes
- **Layout**: Responsive using `MediaQuery`, `LayoutBuilder`, flexible widgets, and `IndexedStack` for tab persistence

**Setup & Run**

1. Clone the repository:
   ```bash
   git clone https://github.com/rammanes/flutter-api-list-demo.git
   cd flutter-api-list-demo
   ```

2. Install dependencies and run:
   ```bash
   flutter pub get
   flutter run
   ```

