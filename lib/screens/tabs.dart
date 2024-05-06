import 'package:flutter/material.dart';

import 'package:meals/screens/categories.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/widgets/main_drawer.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {
  int _tabIndex = 0;
  final List<Meal> _favoriteMeals = [];

  void _setIndex(int index) {
    setState(() {
      _tabIndex = index;
    });
  }

  void _showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void _setFavoriteMealStatus(Meal meal) {
    final isExisting = _favoriteMeals.contains(meal);

    if (isExisting) {
      setState(() {
        _favoriteMeals.remove(meal);
        _showInfoMessage('${meal.title} is no longer a favorite.');
      });
    } else {
      setState(() {
        _favoriteMeals.add(meal);
        _showInfoMessage('${meal.title} is a favorite.');
      });
    }
  }

  void _setScreen(String title) {
    if (title == 'filters') {
    } else {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, Object>> availableTabScreens = [
      {
        'title': 'Categories',
        'screen': CategoriesScreen(
          onSelectFavorite: _setFavoriteMealStatus,
        ),
      },
      {
        'title': 'You Favorites',
        'screen': MealsScreen(
          onSelectFavorite: _setFavoriteMealStatus,
          meals: _favoriteMeals,
        )
      }
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(availableTabScreens[_tabIndex]['title'] as String),
      ),
      drawer: MainDrawer(
        onSelectScreen: _setScreen,
      ),
      body: availableTabScreens[_tabIndex]['screen'] as Widget,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _setIndex,
        currentIndex: _tabIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
