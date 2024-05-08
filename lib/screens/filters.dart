import 'package:flutter/material.dart';

// import 'package:meals/screens/tabs.dart';
// import 'package:meals/widgets/main_drawer.dart';
import 'package:meals/widgets/filter_switch_item.dart';
import 'package:meals/providers/filters_provider.dart';

class FiltersScreen extends StatelessWidget {
  const FiltersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
      ),
      // drawer: MainDrawer(onSelectScreen: (identifier) {
      //   Navigator.of(context).pop();
      //   if (identifier == 'meals') {
      //     Navigator.of(context).pushReplacement(
      //       MaterialPageRoute(
      //         builder: (ctx) => const TabsScreen(),
      //       ),
      //     );
      //   }
      // }),
      body:
          // PopScope(
          //   canPop: true,
          //   onPopInvoked: (bool didPop) {
          //     if (didPop) return;
          //     // Navigator.of(context).pop({
          //     //   Filter.glutenFree: _isGlutenFree,
          //     //   Filter.lactoseFree: _isLactoseFree,
          //     //   Filter.vegetarian: _isVegetarian,
          //     //   Filter.vegan: _isVegan,
          //     // });
          //   },
          //   child:
          const Column(
        children: [
          FilterSwitchItem(
            filter: Filter.glutenFree,
            title: 'Gluten-Free',
          ),
          FilterSwitchItem(
            filter: Filter.lactoseFree,
            title: 'Lactose-Free',
          ),
          FilterSwitchItem(
            filter: Filter.vegetarian,
            title: 'Vegetarian',
          ),
          FilterSwitchItem(
            filter: Filter.vegan,
            title: 'Vegan',
          ),
        ],
      ),
      // ),
    );
  }
}
