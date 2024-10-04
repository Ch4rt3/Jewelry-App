import 'package:flutter/material.dart';
import 'detalle_orders_page.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> with TickerProviderStateMixin {
  late TabController _tabController;
  List<dynamic> _deliveredOrders = [];
  List<dynamic> _processingOrders = [];
  List<dynamic> _canceledOrders = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    
    // Datos estáticos para las órdenes
    setState(() {
      _deliveredOrders = [
        {
          "orderNo": "238562312",
          "date": "20/03/2020",
          "quantity": "01",
          "totalAmount": "150",
          "status": "Delivered",
          "products": [
            {"name": "Product 1", "price": "50"},
            {"name": "Product 2", "price": "100"}
          ]
        },
        {
          "orderNo": "238562313",
          "date": "21/03/2020",
          "quantity": "02",
          "totalAmount": "200",
          "status": "Delivered",
          "products": [
            {"name": "Product 3", "price": "200"}
          ]
        }
      ];

      _processingOrders = [
        {
          "orderNo": "238562314",
          "date": "22/03/2020",
          "quantity": "01",
          "totalAmount": "100",
          "status": "Processing",
          "products": [
            {"name": "Product 4", "price": "100"}
          ]
        }
      ];

      _canceledOrders = [
        {
          "orderNo": "238562315",
          "date": "23/03/2020",
          "quantity": "03",
          "totalAmount": "300",
          "status": "Canceled",
          "products": [
            {"name": "Product 5", "price": "300"}
          ]
        }
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Orders"),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Delivered'),
            Tab(text: 'Processing'),
            Tab(text: 'Canceled'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildOrdersList(_deliveredOrders),
          _buildOrdersList(_processingOrders),
          _buildOrdersList(_canceledOrders),
        ],
      ),
    );
  }

  Widget _buildOrdersList(List<dynamic> orders) {
    return ListView.builder(
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        return Card(
          elevation: 2,
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Order No${order['orderNo']}",
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      order['date'],
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text("Quantity: ${order['quantity']}", style: const TextStyle(fontSize: 14)),
                const SizedBox(height: 4),
                Text("Total Amount: \$${order['totalAmount']}", style: const TextStyle(fontSize: 14)),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 0, 0, 0),  // Fondo blanco
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        side: const BorderSide(color: Colors.black),  // Borde negro
                      ),
                      onPressed: () {
                        // Navega al detalle de la orden
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetalleOrdenPage(order: order),
                          ),
                        );
                      },
                      child: const Text(
                        "Detail",
                        style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),  // Texto en negro
                      ),
                    ),
                    Text(
                      order['status'],
                      style: TextStyle(
                        color: order['status'] == 'Delivered'
                            ? Colors.green
                            : order['status'] == 'Processing'
                                ? Colors.orange
                                : Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}