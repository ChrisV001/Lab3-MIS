import 'package:flutter/material.dart';
import 'package:labs2/models/favorites_provider.dart';
import 'package:labs2/repo/joke_repo.dart';
import 'package:provider/provider.dart';

class JokeCategoryScreen extends StatelessWidget {
  final String category;

  JokeCategoryScreen({required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Jokes: $category"),
      ),
      body: FutureBuilder<List<String>>(
        future: JokeRepo().getJokesByCategory(category),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No jokes found for this category.'),
            );
          }

          final jokes = snapshot.data!;

          return ListView.builder(
            itemCount: jokes.length,
            itemBuilder: (context, index) {
              final joke = jokes[index];
              final favoritesProvider = Provider.of<FavoritesProvider>(context);

              final isFavorite = favoritesProvider.favorites.contains(joke);

              return ListTile(
                title: Text(joke),
                trailing: IconButton(
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : null,
                  ),
                  onPressed: () {
                    if (isFavorite) {
                      favoritesProvider.removeFavorite(joke);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Removed from favorites")),
                      );
                    } else {
                      favoritesProvider.addFavorite(joke);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Added to favorites")),
                      );
                    }
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}

