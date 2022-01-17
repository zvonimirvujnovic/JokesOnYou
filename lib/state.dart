import 'package:flutter_riverpod/flutter_riverpod.dart';

final allJokesProvider = Provider<List<String>>((ref) => [
      "Joke 1",
      "Joke 2",
      "Joke 3",
      "Joke 4",
      "Joke 5",
    ]);

final jokesProvider = StateNotifierProvider<JokesController, String>((ref) {
  final allJokes = ref.watch(allJokesProvider);
  return JokesController(allJokes);
});

class JokesController extends StateNotifier<String> {
  JokesController(this.jokes) : super(jokes[0]);

  int currentJokeIndex = 0;
  int currentFavouriteJokeIndex = 0;
  List<String> jokes;
  List<String> favouriteJokes = [];

  void nextJoke() {
    if (jokes.isEmpty) {
      return;
    }
    currentJokeIndex =
        currentJokeIndex == jokes.length - 1 ? 0 : currentJokeIndex + 1;
    state = jokes[currentJokeIndex];
  }

  void nextFavouriteJoke() {
    if (favouriteJokes.isEmpty) {
      return;
    }
    currentFavouriteJokeIndex =
        currentFavouriteJokeIndex == favouriteJokes.length - 1
            ? 0
            : currentFavouriteJokeIndex + 1;
    state = favouriteJokes[currentFavouriteJokeIndex];
  }

  void addFavouriteJoke(String joke) {
    if (!favouriteJokes.contains(joke)) {
      favouriteJokes.add(joke);
    }
  }
}
