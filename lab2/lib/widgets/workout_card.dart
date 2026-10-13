import 'package:flutter/material.dart';

class WorkoutCard extends StatelessWidget {
  final String title;
  final String calories;
  final String time;
  final String imageUrl;
  final bool isPro;
  final VoidCallback onTap;

  const WorkoutCard({
    super.key,
    required this.title,
    required this.calories,
    required this.time,
    required this.imageUrl,
    required this.onTap,
    this.isPro = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            image: AssetImage(imageUrl),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.3),
              BlendMode.darken,
            ),
          ),
        ),
        child: Stack(
          children: [
            if (isPro)
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(color: Colors.amber, borderRadius: BorderRadius.circular(8)),
                  child: const Text("Pro", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                ),
              ),
            Positioned(
              bottom: 15,
              left: 15,
              right: 15,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Icon(Icons.local_fire_department, color: Colors.white, size: 14),
                      const SizedBox(width: 4),
                      Text(calories, style: const TextStyle(color: Colors.white, fontSize: 12)),
                      const SizedBox(width: 10),
                      const Icon(Icons.access_time, color: Colors.white, size: 14),
                      const SizedBox(width: 4),
                      Text(time, style: const TextStyle(color: Colors.white, fontSize: 12)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}