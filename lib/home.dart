import 'package:flutter/material.dart';
import 'package:labs2/category_joke.dart';
import 'package:labs2/controller/joke_controller.dart';
import 'package:labs2/favorites_screen.dart';
import 'package:labs2/repo/joke_repo.dart';
import 'package:labs2/models/favorites_provider.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text("Jokes"),
      actions: [
        IconButton(
          icon: const Icon(Icons.favorite),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FavoritesScreen(),
              )
            );
          },
        ),
      ],
    ),
    body: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () async {
              try {
                final randomJoke = await JokeRepo().getRandomJoke();
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("Random Joke"),
                      content: Text(randomJoke),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text("Close"),
                        ),
                      ],
                    );
                  },
                );
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Failed to fetch random joke: $e")),
                );
              }
            },
            child: Text("Get Random Joke"),
          ),
        ),
        Expanded(
          child: FutureBuilder(
            future: JokeController().getJokes(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              final jokes = snapshot.data! as List<String>;

              return ListView.builder(
                itemCount: jokes.length,
                itemBuilder: (context, index) {
                  final joke = jokes[index];
                  final favoritesProvider = Provider.of<FavoritesProvider>(context);

                  final isFavorite = favoritesProvider.favorites.contains(joke);

                  return ListTile(
                    title: Text(joke),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                            JokeCategoryScreen(category: joke),
                        ),
                      );
                    },
                  );
                },
              );
            },
          ),
        ),
      ],
    ),
  );
}
  
}