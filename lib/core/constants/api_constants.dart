/// API base URLs and endpoints used across the app.
class ApiConstants {
  ApiConstants._();

  // JSONPlaceholder
  static const String jsonPlaceholderBase = 'https://jsonplaceholder.typicode.com';
  static const String postsEndpoint = '/posts';
  static const String usersEndpoint = '/users';

  // Open Library
  static const String openLibraryBase = 'https://openlibrary.org';
  static const String searchEndpoint = '/search.json';

  // Rick and Morty
  static const String rickAndMortyBase = 'https://rickandmortyapi.com/api';
  static const String charactersEndpoint = '/character';
}
