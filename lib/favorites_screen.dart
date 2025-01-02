import 'package:flutter/material.dart';
import 'package:labs2/models/favorites_provider.dart';
import 'package:provider/provider.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favoritesProvider = Provider.of<FavoritesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorites"),
      ),
      body: favoritesProvider.favorites.isEmpty
      ? const Center(child: Text("No favorite jokes added yet!"))
      : ListView.builder(
        itemCount: favoritesProvider.favorites.length,
        itemBuilder: (context, index) {
          final favoriteJoke = favoritesProvider.favorites[index];

          return ListTile(
            title: Text(favoriteJoke),
            trailing: IconButton(
              icon: const Icon(Icons.remove_circle, color: Colors.red),
              onPressed: () {
                favoritesProvider.removeFavorite(favoriteJoke);
              },
            ),
          );
        },
      )
    );
  }
}