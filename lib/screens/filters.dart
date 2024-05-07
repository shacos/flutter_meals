import 'package:flutter/material.dart';

// import 'package:meals/screens/tabs.dart';
// import 'package:meals/widgets/main_drawer.dart';
import 'package:meals/widgets/filter_switch_item.dart';

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key, required this.selectedFilters,});

  final Map<Filter, bool> selectedFilters;

  @override
  State<FiltersScreen> createState() {
    return _FiltersScreenState();
  }
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _isGlutenFree = false;
  bool _isLactoseFree = false;
  bool _isVegetarian = false;
  bool _isVegan = false;

  @override
  void initState() {
    super.initState();
    _isGlutenFree = widget.selectedFilters[Filter.glutenFree]!;
    _isLactoseFree = widget.selectedFilters[Filter.lactoseFree]!;
    _isVegetarian = widget.selectedFilters[Filter.vegetarian]!;
    _isVegan = widget.selectedFilters[Filter.vegan]!;
  }

  void _toggleFilterValue(bool newValue, Filter filter) {
    switch (filter) {
      case Filter.glutenFree:
        setState(() {
          _isGlutenFree = newValue;
        });
      case Filter.lactoseFree:
        setState(() {
          _isLactoseFree = newValue;
        });
      case Filter.vegetarian:
        setState(() {
          _isVegetarian = newValue;
        });
      case Filter.vegan:
        setState(() {
          _isVegan = newValue;
        });
        break;
      default:
    }
  }

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
      body: PopScope(
        canPop: false,
        onPopInvoked: (bool didPop) {
          if (didPop) return;
          Navigator.of(context).pop({
            Filter.glutenFree: _isGlutenFree,
            Filter.lactoseFree: _isLactoseFree,
            Filter.vegetarian: _isVegetarian,
            Filter.vegan: _isVegan,
          });
        },
        child: Column(
          children: [
            FilterSwitchItem(
              switchValue: _isGlutenFree,
              filter: Filter.glutenFree,
              onToggelSwitch: _toggleFilterValue,
              title: 'Gluten-Free',
            ),
            FilterSwitchItem(
              switchValue: _isLactoseFree,
              filter: Filter.lactoseFree,
              onToggelSwitch: _toggleFilterValue,
              title: 'Lactose-Free',
            ),
            FilterSwitchItem(
              switchValue: _isVegetarian,
              filter: Filter.vegetarian,
              onToggelSwitch: _toggleFilterValue,
              title: 'Vegetarian',
            ),
            FilterSwitchItem(
              switchValue: _isVegan,
              filter: Filter.vegan,
              onToggelSwitch: _toggleFilterValue,
              title: 'Vegan',
            ),
          ],
        ),
      ),
    );
  }
}
