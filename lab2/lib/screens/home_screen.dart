import 'package:flutter/material.dart';
import 'package:fitness_app/widgets/featured_plan_card.dart';
import 'package:fitness_app/widgets/workout_card.dart';
import 'package:fitness_app/screens/detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Friday, 20 May", style: Theme.of(context).textTheme.bodySmall),
                        const SizedBox(height: 8),
                        Text("Good Morning", style: Theme.of(context).textTheme.displayLarge),
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.notifications_none, color: Colors.black),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Today's Challenge", style: TextStyle(color: Colors.grey.shade400, fontSize: 14)),
                          const SizedBox(height: 5),
                          const Text("Running", style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            width: 50,
                            height: 50,
                            child: CircularProgressIndicator(
                              value: 15 / 20,
                              backgroundColor: Colors.grey.shade800,
                              valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                              strokeWidth: 6,
                            ),
                          ),
                          const Text("15/20", style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Featured Plan", style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 18)),
                    Text("See All", style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 15),
                SizedBox(
                  height: 180,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      FeaturedPlanCard(
                        title: "Massive Upper Body",
                        duration: "5 week",
                        frequency: "4x/week",
                        imageUrl: "assets/images/featured1.jpg", // CORECTAT .jpg
                      ),
                      FeaturedPlanCard(
                        title: "Full Body Blast",
                        duration: "3 week",
                        frequency: "3x/week",
                        imageUrl: "assets/images/featured2.jpg", // CORECTAT .jpg
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Workout Programs", style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 18)),
                    Text("See All", style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 15),
                SizedBox(
                  height: 40,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _buildFilterChip(context, "All Type", true),
                      _buildFilterChip(context, "Pilates", false),
                      _buildFilterChip(context, "Cardio", false),
                      _buildFilterChip(context, "Boxing", false),
                      _buildFilterChip(context, "Yoga", false),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    childAspectRatio: 0.85,
                  ),
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    List<Map<String, dynamic>> workouts = [
                      {"title": "Yoga", "cal": "210 kcal", "time": "120 min", "img": "assets/images/yoga.jpeg", "pro": false},
                      {"title": "Arm Strengthening", "cal": "210 kcal", "time": "120 min", "img": "assets/images/Gym.jpeg", "pro": true},
                      {"title": "Leg Day", "cal": "300 kcal", "time": "90 min", "img": "assets/images/legs.jpeg", "pro": false},
                      {"title": "Cardio Core", "cal": "400 kcal", "time": "60 min", "img": "assets/images/cardio.jpeg", "pro": true},
                    ];
                    var item = workouts[index];
                    return WorkoutCard(
                      title: item['title'],
                      calories: item['cal'],
                      time: item['time'],
                      imageUrl: item['img'],
                      isPro: item['pro'],
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const DetailScreen()));
                      },
                    );
                  },
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFilterChip(BuildContext context, String label, bool isSelected) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      child: ChoiceChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (val) {},
        selectedColor: Theme.of(context).primaryColor,
        backgroundColor: Colors.grey.shade200,
        labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.black, fontSize: 13),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}