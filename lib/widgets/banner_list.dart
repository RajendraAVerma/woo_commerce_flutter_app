import 'package:flutter/material.dart';

class BannerList extends StatelessWidget {
  const BannerList({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          banner1(context),
          const SizedBox(height: 15),
          banner3(context),
          const SizedBox(height: 15),
          banner2(context),
        ],
      ),
    );
  }

  Container banner3(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 210,
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: const DecorationImage(
          image: NetworkImage(
            'https://demoapus2.com/freshen/wp-content/uploads/2021/08/banner3.jpg',
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'TASTY HEALTHY',
            style: Theme.of(context).textTheme.labelSmall!.copyWith(
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 10),
          Text(
            'FRESH',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
          ),
          Text(
            'VEGETABLES',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Color(0xff849d72),
                  fontWeight: FontWeight.bold,
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

  Container banner2(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 210,
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: const DecorationImage(
          image: NetworkImage(
            'https://demoapus2.com/freshen/wp-content/uploads/2021/08/banner2.jpg',
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'SEASONAL SALE',
            style: Theme.of(context).textTheme.labelSmall!.copyWith(
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 10),
          Text(
            'UP TO BREADS',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
          ),
          Text(
            '50% OFF',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Color(0xff849d72),
                  fontWeight: FontWeight.bold,
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

  Container banner1(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 210,
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: const DecorationImage(
          image: NetworkImage(
            'https://demoapus2.com/freshen/wp-content/uploads/2021/08/banner1.jpg',
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'FRESH FRUIT',
            style: Theme.of(context).textTheme.labelSmall!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 10),
          Text(
            'FRESH SUMMER',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
          Text(
            'WITH JUST ₹200.99',
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
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
                Colors.white,
              ),
            ),
            child: Text(
              'SHOP NOW',
              style: Theme.of(context).textTheme.labelSmall!.copyWith(
                    color: Color(0xff41544a),
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
