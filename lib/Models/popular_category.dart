import 'package:flutter/foundation.dart';

class PopularCategory {
  final String image;
  final String name;

  PopularCategory({
    @required this.image,
    @required this.name,
  });

  static List<PopularCategory> getPopularCategories() {
    return [
      PopularCategory(
        image: 'assets/icons/coffee.png',
        name: 'Cold\nBeverages',
      ),
      PopularCategory(
        image: 'assets/icons/natural-food.png',
        name: 'Veg &\nNon-Veg',
      ),
      PopularCategory(
        image: 'assets/icons/milkshake.png',
        name: 'Milkshakes',
      ),
      PopularCategory(
        image: 'assets/icons/food.png',
        name: 'Pasta\n& Pizza',
      ),
      PopularCategory(
        image: 'assets/icons/kawaii-sushi.png',
        name: 'Rice Bowls',
      ),
      PopularCategory(
        image: 'assets/icons/bread.png',
        name: 'Sandwich',
      ),
      PopularCategory(
        image: 'assets/icons/only-on-swiggy.png',
        name: 'Fast Food',
      ),
    ];
  }
}
