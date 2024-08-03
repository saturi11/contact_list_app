class Contact {
  Contact();

  T get<T>(String key) {
    // implementation of the get method
    throw UnimplementedError();
  }

  void set<T>(String key, T value) {
    // implementation of the set method
  }

  String get name => get<String>('name');
  set name(String value) => set<String>('name', value);

  String get imagePath => get<String>('imagePath');
  set imagePath(String value) => set<String>('imagePath', value);
}
