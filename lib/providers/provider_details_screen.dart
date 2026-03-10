import 'package:flutter/material.dart';

class ProviderDetailsScreen extends StatelessWidget {
  final String name, profession, rate, reviews, imageUrl;

  const ProviderDetailsScreen({
    super.key,
    required this.name,
    required this.profession,
    required this.rate,
    required this.reviews,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1B2A),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            backgroundColor: const Color(0xFF1B263B),
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(imageUrl, fit: BoxFit.cover),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            profession,
                            style: const TextStyle(
                              color: Colors.cyanAccent,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      const Icon(
                        Icons.verified,
                        color: Colors.cyanAccent,
                        size: 35,
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    "About Me",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Highly skilled professional with years of experience. Committed to providing the best service to all clients.",
                    style: TextStyle(color: Colors.grey, height: 1.5),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    "Recent Reviews",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),
                  _buildReview(
                    "Hossam Sayed",
                    "Excellent work, very professional!",
                    "5.0",
                  ),
                  _buildReview("Mona Ahmed", "Fair prices and on time.", "4.8"),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomSheet: Container(
        color: const Color(0xFF0D1B2A),
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white10,
                borderRadius: BorderRadius.circular(15),
              ),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.phone, color: Colors.cyanAccent),
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.cyanAccent,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                onPressed: () {},
                child: const Text(
                  "Book Now",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReview(String user, String comment, String rating) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFF1B263B),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                user,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  const Icon(Icons.star, color: Colors.amber, size: 14),
                  Text(
                    rating,
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            comment,
            style: const TextStyle(color: Colors.grey, fontSize: 13),
          ),
        ],
      ),
    );
  }
}
