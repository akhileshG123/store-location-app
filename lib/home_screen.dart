import 'package:flutter/material.dart';
import 'store_card.dart'; // Import the Store and Product models
import 'store_details.dart'; // Import the StoreDetailsScreen
import 'favourites_screen.dart'; // Import the FavouritesScreen

// Main app widget
class StoreListApp extends StatefulWidget {
  const StoreListApp({super.key});

  @override
  _StoreListAppState createState() => _StoreListAppState();
}

class _StoreListAppState extends State<StoreListApp> {
  bool isDarkMode = false; // Boolean to toggle dark mode
  final List<Store> favoriteStores = []; // List to store favorite stores

  // Method to toggle favorite status for a store
  void toggleFavorite(Store store) {
    setState(() {
      if (favoriteStores.contains(store)) {
        favoriteStores.remove(store); // Remove from favorites if already added
      } else {
        favoriteStores.add(store); // Add to favorites if not already added
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Store List', // Title of the app
      theme: isDarkMode ? ThemeData.dark() : ThemeData.light(), // Toggle between dark and light themes
      home: StoreListScreen(
        isDarkMode: isDarkMode, // Pass dark mode state to the screen
        onToggleDarkMode: () {
          setState(() {
            isDarkMode = !isDarkMode; // Toggle dark mode on button press
          });
        },
        favoriteStores: favoriteStores, // Pass the favorite stores list
        onToggleFavorite: toggleFavorite, // Pass the favorite toggle function
      ),
    );
  }
}

// Main screen showing the list of stores
class StoreListScreen extends StatefulWidget {
  final bool isDarkMode; // Dark mode flag
  final VoidCallback onToggleDarkMode; // Callback to toggle dark mode
  final List<Store> favoriteStores; // List of favorite stores
  final Function(Store) onToggleFavorite; // Function to toggle favorite status

  const StoreListScreen({
    super.key,
    required this.isDarkMode,
    required this.onToggleDarkMode,
    required this.favoriteStores,
    required this.onToggleFavorite,
  });

  @override
  _StoreListScreenState createState() => _StoreListScreenState();
}

class _StoreListScreenState extends State<StoreListScreen> {
  // List of stores to display
  final List<Store> stores = [
    // Store 1
    Store(
      name: 'Green Grocer',
      address: 'Bandra West, Mumbai',
      distance: 2.5,
      contact: '8989785677',
      openingHours: '9:00 AM - 8:00 PM',
      description: 'A general store with a variety of goods.',
      latitude: 19.0596,
      longitude: 72.8295,
      products: [
        Product(name: 'Organic Apples', price: 3.99, isAvailable: true),
        Product(name: 'Whole Wheat Bread', price: 2.49, isAvailable: false),
        Product(name: 'Almond Milk', price: 2.99, isAvailable: true),
      ],
    ),
    // Store 2
    Store(
      name: 'Quick Stop Convenience',
      address: 'Kurla',
      distance: 1.2,
      contact: '9531578426',
      openingHours: '8:00 AM - 9:00 PM',
      description: 'Convenience store for all your daily needs.',
      latitude: 19.0726,
      longitude: 72.8845,
      products: [
        Product(name: 'Soda', price: 1.50, isAvailable: true),
        Product(name: 'Chips', price: 2.00, isAvailable: true),
        Product(name: 'Candy Bar', price: 1.25, isAvailable: false),
      ],
    ),
    // Store 3
    Store(
      name: 'Health Foods Market',
      address: 'Santacruz',
      distance: 3.8,
      contact: '9769202347',
      openingHours: '10:00 AM - 7:00 PM',
      description: 'Specialty food store offering organic options.',
      latitude: 19.0843,
      longitude: 72.8360,
      products: [
        Product(name: 'Quinoa', price: 4.50, isAvailable: true),
        Product(name: 'Chia Seeds', price: 5.00, isAvailable: false),
        Product(name: 'Vegan Protein Powder', price: 24.99, isAvailable: true),
      ],
    ),
    // Store 4
    Store(
      name: 'The Irani Cafe',
      address: 'Panvel',
      distance: 4.1,
      contact: '741236985',
      openingHours: '11:00 AM - 6:00 PM',
      description: 'Local bakery known for fresh bread and pastries.',
      latitude: 18.9894,
      longitude: 73.1175,
      products: [
        Product(name: 'Chocolate Cake', price: 15.00, isAvailable: true),
        Product(name: 'Blueberry Muffin', price: 2.50, isAvailable: true),
        Product(name: 'Croissant', price: 1.75, isAvailable: false),
      ],
    ),
    // Store 5
    Store(
      name: 'Tech Haven',
      address: 'Dadar',
      distance: 6.9,
      contact: '9403363365',
      openingHours: '10:00 AM - 5:00 PM',
      description: 'Electronics store offering the latest gadgets.',
      latitude: 19.0178,
      longitude: 72.8478,
      products: [
        Product(name: 'Laptop', price: 899.99, isAvailable: true),
        Product(name: 'Smartphone', price: 699.99, isAvailable: true),
        Product(name: 'Wireless Earbuds', price: 199.99, isAvailable: false),
      ],
    ),
    // More store data...
  ];

  String query = ''; // Search query

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            SizedBox(width: 10),
            Text('Store List'), // Title of the screen
          ],
        ),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite), // Favorite button in the AppBar
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      FavouritesScreen(favoriteStores: widget.favoriteStores), // Navigate to Favourites screen
                ),
              );
            },
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.settings), // Settings button in AppBar
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Dark Mode'),
                    Switch(
                      value: widget.isDarkMode, // Show dark mode toggle switch
                      onChanged: (bool value) {
                        widget.onToggleDarkMode(); // Toggle dark mode on switch press
                        Navigator.pop(context); // Close popup menu after switching
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search), // Search icon in the text field
                labelText: 'Search Store', // Placeholder text for the search field
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8), // Rounded corners for the text field
                ),
              ),
              onChanged: (value) {
                setState(() {
                  query = value.toLowerCase(); // Update search query when text is entered
                });
              },
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 32),
              children: stores
                  .where((store) => store.name.toLowerCase().contains(query)) // Filter stores by search query
                  .map((store) => GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation, secondaryAnimation) =>
                                  StoreDetailsScreen(store: store), // Navigate to the store details screen
                              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                const begin = Offset(1.0, 0.0);
                                const end = Offset.zero;
                                const curve = Curves.ease;

                                final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                                final offsetAnimation = animation.drive(tween);

                                return SlideTransition(
                                  position: offsetAnimation,
                                  child: child, // Slide transition when navigating
                                );
                              },
                            ),
                          );
                        },
                        child: Card(
                          elevation: 7.5,
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12), // Rounded corners for store cards
                          ),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.blue.shade100, // Light blue background for the icon
                              child: Icon(Icons.store, color: Colors.blue.shade700), // Store icon
                            ),
                            title: Text(store.name), // Store name
                            subtitle: Text('${store.distance} km away'), // Store distance from user
                            trailing: IconButton(
                              icon: Icon(
                                widget.favoriteStores.contains(store)
                                    ? Icons.favorite
                                    : Icons.favorite_border, // Display favorite icon based on the store's status
                                color: widget.favoriteStores.contains(store) ? Colors.red : null, // Red color for favorited stores
                              ),
                              onPressed: () {
                                widget.onToggleFavorite(store); // Toggle favorite status on button press
                              },
                            ),
                          ),
                        ),
                      ))
                  .toList(), // Convert the filtered list of stores to widgets
            ),
          ),
        ],
      ),
    );
  }
}


