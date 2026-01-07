import 'package:flutter/material.dart';
import 'package:mn/features/auth/data/repositries/users_repositry.dart';
import 'package:mn/features/auth/views/auth.dart';
import 'package:mn/features/orders/data/repositries/orders_repositry.dart';
import 'package:mn/features/todos/data/repositires/todos_repositry.dart';
import 'package:mn/features/todos/views/todos_view.dart';
import 'package:mn/features/orders/views/orders_view.dart';

class HomePage extends StatefulWidget {
  final TodosRepository todosRepository;
  final UsersRepository usersRepository;
  final OrdersRepository ordersRepository;

  const HomePage({
    super.key,
    required this.todosRepository,
    required this.usersRepository,
    required this.ordersRepository,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  String get _userInitial {
    final name = widget.usersRepository.currentUser?.name;
    if (name != null && name.isNotEmpty) {
      return name[0].toUpperCase();
    }
    return 'U';
  }

  String get _userName {
    return widget.usersRepository.currentUser?.name ?? 'User';
  }

  String get _userEmail {
    return widget.usersRepository.currentUser?.email ?? '';
  }

  Future<void> _handleLogout() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Logout'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await widget.usersRepository.signOut();
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => AuthView(
              usersRepository: widget.usersRepository,
              todosRepository: widget.todosRepository,
              ordersRepository: widget.ordersRepository,
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isWideScreen = MediaQuery.of(context).size.width > 800;

    final pages = [
      TodosView(
        todosRepository: widget.todosRepository,
        usersRepository: widget.usersRepository,
      ),
      OrdersView(
        ordersRepository: widget.ordersRepository,
        usersRepository: widget.usersRepository,
      ),
    ];

    // Web layout with side navigation
    if (isWideScreen) {
      return Scaffold(
        body: Row(
          children: [
            // Side Navigation
            Container(
              width: MediaQuery.of(context).size.width > 1200 ? 250 : 80,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Header / Logo
                  Container(
                    padding: const EdgeInsets.all(20),
                    child: MediaQuery.of(context).size.width > 1200
                        ? Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Icon(
                                  Icons.dashboard,
                                  color: Colors.white,
                                  size: 24,
                                ),
                              ),
                              const SizedBox(width: 12),
                              const Text(
                                'Dashboard',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          )
                        : Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              Icons.dashboard,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                  ),
                  const SizedBox(height: 20),

                  // Navigation Items
                  _buildNavItem(
                    index: 0,
                    icon: Icons.check_box_outlined,
                    selectedIcon: Icons.check_box,
                    label: 'Todos',
                    isExtended: MediaQuery.of(context).size.width > 1200,
                  ),
                  _buildNavItem(
                    index: 1,
                    icon: Icons.shopping_cart_outlined,
                    selectedIcon: Icons.shopping_cart,
                    label: 'Orders',
                    isExtended: MediaQuery.of(context).size.width > 1200,
                  ),

                  const Spacer(),

                  // User Profile Section
                  Container(
                    margin: const EdgeInsets.all(12),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: MediaQuery.of(context).size.width > 1200
                        ? Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: Theme.of(context).primaryColor,
                                child: Text(
                                  _userInitial,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _userName,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      _userEmail,
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 12,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.logout, size: 20),
                                onPressed: _handleLogout,
                                tooltip: 'Logout',
                                color: Colors.red,
                              ),
                            ],
                          )
                        : Column(
                            children: [
                              CircleAvatar(
                                backgroundColor: Theme.of(context).primaryColor,
                                child: Text(
                                  _userInitial,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              IconButton(
                                icon: const Icon(Icons.logout, size: 20),
                                onPressed: _handleLogout,
                                tooltip: 'Logout',
                                color: Colors.red,
                              ),
                            ],
                          ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),

            // Main Content
            Expanded(
              child: Container(
                color: Colors.grey[50],
                child: pages[_currentIndex],
              ),
            ),
          ],
        ),
      );
    }

    // Mobile layout with bottom navigation
    return Scaffold(
      appBar: AppBar(
        title: Text(_currentIndex == 0 ? 'Todos' : 'Orders'),
        actions: [
          // User Avatar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: GestureDetector(
              onTap: () => _showUserMenu(context),
              child: CircleAvatar(
                backgroundColor: Theme.of(context).primaryColor,
                radius: 18,
                child: Text(
                  _userInitial,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: pages[_currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() => _currentIndex = index);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.check_box_outlined),
            selectedIcon: Icon(Icons.check_box),
            label: 'Todos',
          ),
          NavigationDestination(
            icon: Icon(Icons.shopping_cart_outlined),
            selectedIcon: Icon(Icons.shopping_cart),
            label: 'Orders',
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required IconData icon,
    required IconData selectedIcon,
    required String label,
    required bool isExtended,
  }) {
    final isSelected = _currentIndex == index;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Material(
        color: isSelected
            ? Theme.of(context).primaryColor.withOpacity(0.1)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: () => setState(() => _currentIndex = index),
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: isExtended
                ? Row(
                    children: [
                      Icon(
                        isSelected ? selectedIcon : icon,
                        color: isSelected
                            ? Theme.of(context).primaryColor
                            : Colors.grey[600],
                      ),
                      const SizedBox(width: 12),
                      Text(
                        label,
                        style: TextStyle(
                          color: isSelected
                              ? Theme.of(context).primaryColor
                              : Colors.grey[600],
                          fontWeight:
                              isSelected ? FontWeight.w600 : FontWeight.normal,
                        ),
                      ),
                    ],
                  )
                : Icon(
                    isSelected ? selectedIcon : icon,
                    color: isSelected
                        ? Theme.of(context).primaryColor
                        : Colors.grey[600],
                  ),
          ),
        ),
      ),
    );
  }

  void _showUserMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 24),

            // User info
            CircleAvatar(
              backgroundColor: Theme.of(context).primaryColor,
              radius: 40,
              child: Text(
                _userInitial,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              _userName,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              _userEmail,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 24),

            // Logout button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                  _handleLogout();
                },
                icon: const Icon(Icons.logout, color: Colors.red),
                label: const Text(
                  'Logout',
                  style: TextStyle(color: Colors.red),
                ),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.red),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}