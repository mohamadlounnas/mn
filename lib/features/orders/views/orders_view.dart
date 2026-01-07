import 'package:flutter/material.dart';
import 'package:mn/features/auth/data/repositries/users_repositry.dart';
import 'package:mn/features/orders/data/models/order_model.dart';
import 'package:mn/features/orders/data/repositries/orders_repositry.dart';

class OrdersView extends StatefulWidget {
  final OrdersRepository ordersRepository;
  final UsersRepository usersRepository;

  const OrdersView({
    super.key,
    required this.ordersRepository,
    required this.usersRepository,
  });

  @override
  State<OrdersView> createState() => _OrdersViewState();
}

class _OrdersViewState extends State<OrdersView> {
  @override
  Widget build(BuildContext context) {
    final isWideScreen = MediaQuery.of(context).size.width > 800;
    final orders = widget.ordersRepository.getOrders();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Center(
              child: Text(
                'Welcome, ${widget.usersRepository.currentUser?.name ?? 'User'}',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ),
        ],
      ),
      body: isWideScreen
          ? _buildWebLayout(orders)
          : _buildMobileLayout(orders),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddOrderDialog,
        icon: const Icon(Icons.add),
        label: const Text('New Order'),
      ),
    );
  }

  // Web layout - Always show dashboard
  Widget _buildWebLayout(List<OrdersModel> orders) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header stats - always visible
          Row(
            children: [
              _buildStatCard('Total Orders', orders.length.toString(), Icons.receipt_long, Colors.blue),
              const SizedBox(width: 16),
              _buildStatCard('Pending', orders.where((o) => !o.isDone).length.toString(), Icons.pending, Colors.orange),
              const SizedBox(width: 16),
              _buildStatCard('Completed', orders.where((o) => o.isDone).length.toString(), Icons.check_circle, Colors.green),
            ],
          ),
          const SizedBox(height: 24),

          // Orders table card - always visible
          Expanded(
            child: Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('All Orders', style: Theme.of(context).textTheme.titleLarge),
                        Text(
                          '${orders.length} orders',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Divider(),
                    Expanded(
                      child: orders.isEmpty
                          ? _buildEmptyTableState()
                          : SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: SingleChildScrollView(
                                child: DataTable(
                                  columns: const [
                                    DataColumn(label: Text('Product')),
                                    DataColumn(label: Text('Quantity')),
                                    DataColumn(label: Text('Date')),
                                    DataColumn(label: Text('Status')),
                                    DataColumn(label: Text('Actions')),
                                  ],
                                  rows: orders.map((order) {
                                    return DataRow(
                                      cells: [
                                        DataCell(Text(order.product)),
                                        DataCell(Text(order.quantity.toString())),
                                        DataCell(Text(_formatDate(order.created))),
                                        DataCell(_buildStatusChip(order.isDone)),
                                        DataCell(
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              IconButton(
                                                icon: Icon(
                                                  order.isDone ? Icons.undo : Icons.check,
                                                  color: order.isDone ? Colors.orange : Colors.green,
                                                ),
                                                onPressed: () => _toggleOrderStatus(order),
                                                tooltip: order.isDone ? 'Mark as pending' : 'Mark as done',
                                              ),
                                              IconButton(
                                                icon: const Icon(Icons.delete, color: Colors.red),
                                                onPressed: () => _deleteOrder(order),
                                                tooltip: 'Delete order',
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Empty state inside table card for web
  Widget _buildEmptyTableState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.inbox_outlined, size: 64, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            'No orders yet',
            style: TextStyle(fontSize: 18, color: Colors.grey[600], fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          Text(
            'Click "New Order" to create your first order',
            style: TextStyle(color: Colors.grey[500]),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Expanded(
      child: Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 28),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(color: Colors.grey[600], fontSize: 14)),
                  Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusChip(bool isDone) {
    return Chip(
      label: Text(
        isDone ? 'Completed' : 'Pending',
        style: TextStyle(
          color: isDone ? Colors.green[700] : Colors.orange[700],
          fontSize: 12,
        ),
      ),
      backgroundColor: isDone ? Colors.green[50] : Colors.orange[50],
      side: BorderSide.none,
      padding: EdgeInsets.zero,
    );
  }

  // Mobile layout
  Widget _buildMobileLayout(List<OrdersModel> orders) {
    if (orders.isEmpty) {
      return _buildEmptyMobileState();
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            leading: CircleAvatar(
              backgroundColor: order.isDone ? Colors.green[100] : Colors.orange[100],
              child: Icon(
                order.isDone ? Icons.check : Icons.shopping_bag,
                color: order.isDone ? Colors.green : Colors.orange,
              ),
            ),
            title: Text(
              order.product,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                decoration: order.isDone ? TextDecoration.lineThrough : null,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Text('Quantity: ${order.quantity}'),
                Text(
                  _formatDate(order.created),
                  style: TextStyle(color: Colors.grey[500], fontSize: 12),
                ),
              ],
            ),
            trailing: PopupMenuButton<String>(
              onSelected: (value) {
                if (value == 'toggle') {
                  _toggleOrderStatus(order);
                } else if (value == 'delete') {
                  _deleteOrder(order);
                }
              },
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 'toggle',
                  child: Row(
                    children: [
                      Icon(order.isDone ? Icons.undo : Icons.check),
                      const SizedBox(width: 8),
                      Text(order.isDone ? 'Mark Pending' : 'Mark Done'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'delete',
                  child: Row(
                    children: [
                      Icon(Icons.delete, color: Colors.red),
                      SizedBox(width: 8),
                      Text('Delete', style: TextStyle(color: Colors.red)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Empty state for mobile
  Widget _buildEmptyMobileState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.shopping_cart_outlined, size: 80, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            'No orders yet',
            style: TextStyle(fontSize: 20, color: Colors.grey[600]),
          ),
          const SizedBox(height: 8),
          Text(
            'Tap the button below to create your first order',
            style: TextStyle(color: Colors.grey[500]),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} at ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }

  void _toggleOrderStatus(OrdersModel order) {
    setState(() {
      widget.ordersRepository.markAsDone(order.id);
    });
  }

  void _deleteOrder(OrdersModel order) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Order'),
        content: Text('Are you sure you want to delete "${order.product}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                widget.ordersRepository.deleteOrder(order.id);
              });
              Navigator.pop(context);
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _showAddOrderDialog() async {
    String productName = '';
    int quantity = 1;

    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text('Add New Order'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    decoration: const InputDecoration(
                      labelText: 'Product Name',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.shopping_bag),
                    ),
                    onChanged: (value) => productName = value,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Text('Quantity: '),
                      IconButton(
                        onPressed: () {
                          if (quantity > 1) setDialogState(() => quantity--);
                        },
                        icon: const Icon(Icons.remove_circle_outline),
                      ),
                      Text(
                        quantity.toString(),
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        onPressed: () => setDialogState(() => quantity++),
                        icon: const Icon(Icons.add_circle_outline),
                      ),
                    ],
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                FilledButton(
                  onPressed: () {
                    if (productName.isNotEmpty) {
                      Navigator.pop(context, {'product': productName, 'quantity': quantity});
                    }
                  },
                  child: const Text('Add Order'),
                ),
              ],
            );
          },
        );
      },
    );

    if (result != null) {
      setState(() {
        widget.ordersRepository.createOrder(
          OrdersModel(
            id: DateTime.now().microsecondsSinceEpoch.toString(),
            userId: widget.usersRepository.currentUser!.id,
            product: result['product'],
            quantity: result['quantity'],
            created: DateTime.now(),
          ),
        );
      });
    }
  }
}