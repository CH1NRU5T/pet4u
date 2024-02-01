import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pet4u/constants/custom_colors.dart';
import 'package:pet4u/models/pet_model.dart';

class PetDetailScreen extends StatelessWidget {
  const PetDetailScreen({super.key, required this.pet});
  final Pet pet;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: const Color(0xfffbd9b9),
      //   elevation: 0,
      //   actions: [
      //     IconButton(
      //       onPressed: () {},
      //       icon: const Icon(Icons.favorite_border),
      //     ),
      //   ],
      // ),
      body: CustomScrollView(
        shrinkWrap: true,
        slivers: [
          SliverAppBar(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.elliptical(300, 100),
                bottomRight: Radius.elliptical(300, 100),
              ),
            ),
            backgroundColor: const Color(0xfffbd9b9),
            expandedHeight: MediaQuery.of(context).size.height * 0.5,
            elevation: 0,
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: pet.id,
                child: CachedNetworkImage(
                  imageUrl: pet.urlToImage,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12)
                    .copyWith(bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      pet.name,
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 100,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          DetailBox(
                            value: pet.age.toString(),
                            title: 'Age',
                            color: CustomColors.ageColor,
                          ),
                          const SizedBox(width: 5),
                          DetailBox(
                            value: pet.weight.toString(),
                            title: 'Weight',
                            color: CustomColors.weightColor,
                          ),
                          const SizedBox(width: 5),
                          DetailBox(
                            value: pet.height.toString(),
                            title: 'Height',
                            color: CustomColors.heightColor,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'About',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      pet.description,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    // const Spacer(),
                  ],
                ),
              ),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Spacer(),
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(),
                    child: Text(
                      'Adopt',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Colors.white,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      // SingleChildScrollView(
      //   child: SizedBox(
      //     height: MediaQuery.of(context).size.height,
      //     child: Column(
      //       children: [
      //         Expanded(
      //           flex: 3,
      //           child: Container(
      //             decoration: BoxDecoration(
      //               image: DecorationImage(
      //                 image: CachedNetworkImageProvider(pet.urlToImage),
      //                 fit: BoxFit.cover,
      //               ),
      //               color: const Color(0xfffbd9b9),
      //               borderRadius: const BorderRadius.only(
      //                 bottomLeft: Radius.elliptical(200, 80),
      //                 bottomRight: Radius.elliptical(200, 80),
      //               ),
      //             ),
      //             child: Hero(
      //               tag: pet.id,
      //               child: CachedNetworkImage(
      //                 imageUrl: pet.urlToImage,
      //                 fit: BoxFit.cover,
      //               ),
      //             ),
      //           ),
      //         ),
      //         Expanded(
      //           flex: 2,
      //           child: Padding(
      //             padding: const EdgeInsets.symmetric(horizontal: 12)
      //                 .copyWith(bottom: 10),
      //             child: Column(
      //               crossAxisAlignment: CrossAxisAlignment.stretch,
      //               children: [
      //                 Text(pet.name,
      //                     style: Theme.of(context).textTheme.headlineLarge),
      //                 const SizedBox(height: 10),
      //                 Row(
      //                   // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //                   children: [
      //                     DetailBox(
      //                       value: pet.age.toString(),
      //                       title: 'Age',
      //                       color: CustomColors.ageColor,
      //                     ),
      //                     const SizedBox(width: 5),
      //                     DetailBox(
      //                       value: pet.weight.toString(),
      //                       title: 'Weight',
      //                       color: CustomColors.weightColor,
      //                     ),
      //                     const SizedBox(width: 5),
      //                     DetailBox(
      //                       value: pet.height.toString(),
      //                       title: 'Height',
      //                       color: CustomColors.heightColor,
      //                     ),
      //                   ],
      //                 ),
      //                 const SizedBox(height: 10),
      //                 Text(
      //                   'About',
      //                   style: Theme.of(context).textTheme.titleLarge,
      //                 ),
      //                 const SizedBox(height: 10),
      //                 Text(
      //                   pet.description,
      //                   style: Theme.of(context).textTheme.bodyLarge,
      //                 ),
      //                 const Spacer(),
      //                 TextButton(
      //                   onPressed: () {},
      //                   style: TextButton.styleFrom(),
      //                   child: Text(
      //                     'Adopt',
      //                     style:
      //                         Theme.of(context).textTheme.titleLarge!.copyWith(
      //                               color: Colors.white,
      //                             ),
      //                   ),
      //                 ),
      //               ],
      //             ),
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}

class DetailBox extends StatelessWidget {
  const DetailBox(
      {super.key,
      required this.value,
      required this.title,
      required this.color});
  final String value;
  final String title;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(value, style: Theme.of(context).textTheme.titleLarge),
            Text(title, style: Theme.of(context).textTheme.bodyLarge),
          ],
        ),
      ),
    );
  }
}
