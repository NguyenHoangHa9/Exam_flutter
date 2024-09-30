import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, String>> places = []; // Danh sách địa điểm
  bool isLoading = true; // Trạng thái loading

  @override
  void initState() {
    super.initState();
    fetchPlaces(); // Gọi API khi khởi tạo
  }

  Future<void> fetchPlaces() async {
    final String apiUrl = 'http://localhost:3000/places'; // URL của API giả lập
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        setState(() {
          places = data.map<Map<String, String>>((place) {
            return {
              'name': place['name'] as String, // Chuyển đổi về String
              'imageUrl': place['imageUrl'] as String, // Chuyển đổi về String
            };
          }).toList();
          isLoading = false; // Đánh dấu đã hoàn thành việc tải dữ liệu
        });
      } else {
        throw Exception('Failed to load places');
      }
    } catch (e) {
      setState(() {
        isLoading = false; // Đánh dấu đã hoàn thành việc tải dữ liệu ngay cả khi có lỗi
      });
      print('Error fetching places: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator()) // Hiển thị loading khi đang tải
          : PopularDestinations(places: places), // Gọi widget hiển thị danh sách
    );
  }
}

// Widget cho danh sách các địa điểm phổ biến
class PopularDestinations extends StatelessWidget {
  final List<Map<String, String>> places;

  const PopularDestinations({required this.places});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Popular Destinations',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          height: 200, // Chiều cao của các card
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: places.length,
            itemBuilder: (context, index) {
              final place = places[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: DestinationCard(
                  name: place['name']!,
                  imageUrl: place['imageUrl']!,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class DestinationCard extends StatelessWidget {
  final String name;
  final String imageUrl;

  const DestinationCard({required this.name, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: 16,
            left: 16,
            child: Text(
              name,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                backgroundColor: Colors.black54,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
