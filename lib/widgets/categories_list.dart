import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class CategoriesList extends StatelessWidget {
  const CategoriesList({super.key});

  Future<List<dynamic>> fetchCategories() async {
    final response = await http.get(Uri.parse(
        'https://virginorganicfoods.themetaworld.in/wp-json/wc/v3/products/categories?consumer_key=ENTER_KEY&consumer_secret=ENTER_SECRET_KEY'));

    List<dynamic> list = [];
    if (response.statusCode == 200) {
      print(jsonDecode(response.body).length);
      list = jsonDecode(response.body) as List<dynamic>;
    } else {
      throw Exception('Failed to load album');
    }

    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(
            'TOP CATEGORIES OF THE MONTH',
            style: GoogleFonts.nunito(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        FutureBuilder<List<dynamic>>(
          future: fetchCategories(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  SizedBox(
                    height: 200,
                    child: ListView.builder(
                      itemCount: snapshot.data?.length ?? 0,
                      // shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final category = snapshot.data![index] ?? {};
                        return categoryCard(category, context);
                      },
                    ),
                  )
                ],
              );
            }
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            return CircularProgressIndicator();
          },
        ),
      ],
    );
  }

  Widget categoryCard(category, BuildContext context) {
    return Container(
      width: 150,
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          if (category['images'] != null)
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  width: 0.5,
                  color: Color.fromARGB(200, 151, 164, 171),
                ),
              ),
              child: Image.network(
                category['images'],
                fit: BoxFit.cover,
                height: 80,
                width: 80,
              ),
            ),
          if (category['images'] == null)
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  width: 0.2,
                  color: Color.fromARGB(200, 151, 164, 171),
                ),
              ),
              child: Image.network(
                'https://demoapus2.com/freshen/wp-content/uploads/2021/09/s11-400x300.jpg',
                fit: BoxFit.cover,
                height: 80,
                width: 80,
              ),
            ),
          const SizedBox(height: 15),
          Text(
            category['name'].toString().toUpperCase(),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ],
      ),
    );
  }
}
