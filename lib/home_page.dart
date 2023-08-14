import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:woo_commerce_flutter_app/widgets/banner_list.dart';
import 'package:woo_commerce_flutter_app/widgets/categories_list.dart';
import 'package:http/http.dart' as http;

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  Future<List<dynamic>> fetchProductsPopular() async {
    final response = await http.get(Uri.parse(
        'https://virginorganicfoods.themetaworld.in/wp-json/wc/v3/products?orderby=popularity&order=desc&consumer_key=ENTER_KEY&consumer_secret=ENTER_SECRET_KEY'));

    List<dynamic> list = [];
    if (response.statusCode == 200) {
      print(jsonDecode(response.body).length);
      list = jsonDecode(response.body) as List<dynamic>;
    } else {
      throw Exception('Failed to load album');
    }

    return list;
  }

  Future<List<dynamic>> fetchProductsBestSeller() async {
    final response = await http.get(Uri.parse(
        'https://virginorganicfoods.themetaworld.in/wp-json/wc/v3/products?consumer_key=ENTER_KEY&consumer_secret=ENTER_SECRET_KEY'));

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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.network(
          'https://virginorganicfoods.themetaworld.in/wp-content/uploads/2021/08/Vegan-food-5.png',
          scale: 4,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Badge.count(
              count: 0,
              child: const Icon(Icons.shopping_cart_outlined),
            ),
          ),
        ],
      ),
      drawer: Container(
        color: Colors.white,
        height: double.infinity,
        width: 200,
        child: Column(
          children: [],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            topBanner(context),
            const SizedBox(height: 10),
            const CategoriesList(),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "MOST POPULAR",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "VIEW ALL",
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            color: Color(0xff86bc42),
                            decoration: TextDecoration.underline,
                            decorationColor:
                                Color(0xff86bc42), // Set underline color
                          ),
                    ),
                  ),
                ],
              ),
            ),
            FutureBuilder<List<dynamic>>(
              future: fetchProductsPopular(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      SizedBox(
                        height: 400,
                        child: ListView.builder(
                          itemCount: snapshot.data?.length ?? 0,
                          // shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            final product = snapshot.data![index] ?? {};
                            return productCard(product, context);
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
            const BannerList(),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "BEST SELLER",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "VIEW ALL",
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            color: Color(0xff86bc42),
                            decoration: TextDecoration.underline,
                            decorationColor:
                                Color(0xff86bc42), // Set underline color
                          ),
                    ),
                  ),
                ],
              ),
            ),
            FutureBuilder<List<dynamic>>(
              future: fetchProductsBestSeller(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      SizedBox(
                        height: 400,
                        child: ListView.builder(
                          itemCount: snapshot.data?.length ?? 0,
                          // shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            final product = snapshot.data![index] ?? {};
                            return productCard(product, context);
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
        ),
      ),
    );
  }

  Widget productCard(product, BuildContext context) {
    return Container(
      width: 200,
      padding: const EdgeInsets.all(20),
      child: Badge(
        label: Text(
          '${(((double.tryParse(product['sale_price']) ?? 1) - (double.tryParse(product['regular_price']) ?? 0)) / (double.tryParse(product['price']) ?? 1) * 100).toStringAsFixed(2)}%',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        textColor: Colors.white,
        isLabelVisible: product['sale_price'] != '',
        child: Column(
          children: [
            if (product['images'] != null)
              Stack(
                alignment: Alignment.topRight,
                children: [
                  Image.network(
                    product['images'][0]['src'],
                    height: 150,
                    width: 150,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.favorite_border_outlined,
                      color: Color(0xff8abe49),
                      size: 20,
                    ),
                  ),
                ],
              ),
            if (product['categories'] != null)
              Text(
                product['categories'][0]['name'].toString().toUpperCase(),
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .copyWith(color: Colors.blueGrey),
              ),
            starGenerator(double.tryParse(product['average_rating']) ?? 0),
            Text(
              product['name'].toString().toUpperCase(),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (product['sale_price'] != '')
                  Text(
                    '₹ ' + product['regular_price'].toString().toUpperCase(),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          color: Color.fromARGB(255, 104, 104, 104),
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.lineThrough,
                        ),
                  ),
                if (product['sale_price'] != '') const SizedBox(width: 10),
                Text(
                  '₹ ' + product['price'].toString().toUpperCase(),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        color: Color(0xff8abe49),
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                IconButton.filled(
                  onPressed: () {},
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    backgroundColor: MaterialStatePropertyAll(
                      Color.fromARGB(255, 36, 63, 2),
                    ),
                  ),
                  icon: const Icon(
                    Icons.shopping_cart_checkout_rounded,
                    size: 15,
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      backgroundColor: MaterialStatePropertyAll(
                        Color(0xff8abe49),
                      ),
                    ),
                    child: Text(
                      'BUY NOW',
                      style: Theme.of(context).textTheme.labelSmall!.copyWith(
                            color: Colors.white,
                          ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget starGenerator(double rating) {
    int fullStars = rating.floor();
    bool hasHalfStar = (rating - fullStars) >= 0.5;

    List<Widget> starIcons = List.generate(5, (index) {
      if (index < fullStars) {
        return Icon(
          Icons.star_rounded,
          color: Color(0xffeeba36),
          size: 20,
        );
      } else if (index == fullStars && hasHalfStar) {
        return Icon(
          Icons.star_half_rounded,
          color: Color(0xffeeba36),
          size: 20,
        );
      } else {
        return Icon(
          Icons.star_outline_rounded,
          color: Color(0xffeeba36),
          size: 20,
        );
      }
    });

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: starIcons,
      ),
    );
  }

  Container topBanner(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: NetworkImage(
            'https://demoapus2.com/freshen/wp-content/uploads/2021/11/s-1.jpg',
          ),
          fit: BoxFit.cover,
          opacity: 0.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'ALL NATURAL PRODUCTS',
            style: Theme.of(context).textTheme.labelSmall!.copyWith(
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 10),
          Text(
            'HEALTHY FOOD',
            style: GoogleFonts.montserrat(
              color: Color(0xff41544a),
              fontWeight: FontWeight.bold,
              fontSize: 23,
            ),
          ),
          Text(
            '& ORGANIC MARKET',
            style: GoogleFonts.montserrat(
              color: Color(0xff86bc42),
              fontWeight: FontWeight.bold,
              fontSize: 23,
            ),
          ),
          const Spacer(),
          ElevatedButton(
            onPressed: () {},
            style: ButtonStyle(
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              backgroundColor: MaterialStatePropertyAll(
                Color(0xff41544a),
              ),
            ),
            child: Text(
              'SHOP NOW',
              style: Theme.of(context).textTheme.labelSmall!.copyWith(
                    color: Colors.white,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
