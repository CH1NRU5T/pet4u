import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet4u/constants/custom_colors.dart';
import 'package:pet4u/features/pet_details/widgets/pet_detail_box.dart';
import 'package:pet4u/features/theme/bloc/theme_bloc.dart';
import 'package:pet4u/features/theme/bloc/theme_event.dart';
import 'package:pet4u/models/pet_model.dart';

class PetDetailScreen extends StatelessWidget {
  const PetDetailScreen({super.key, required this.pet});
  final Pet pet;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        shrinkWrap: true,
        slivers: [
          SliverAppBar(
            actions: [
              PopupMenuButton(itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    value: 'logout',
                    child: Row(
                      children: [
                        Text(
                            '${(context.read<ThemeBloc>().isDark ?? false) ? 'Light' : 'Dark'} mode'),
                      ],
                    ),
                  ),
                ];
              }, onSelected: (_) {
                context.read<ThemeBloc>().add(ThemeChangeEvent());
              }),
            ],
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
                          PetDetailBox(
                            value: pet.age.toString(),
                            title: 'Age',
                            color: CustomColors.ageColor,
                          ),
                          const SizedBox(width: 5),
                          PetDetailBox(
                            value: pet.weight.toString(),
                            title: 'Weight',
                            color: CustomColors.weightColor,
                          ),
                          const SizedBox(width: 5),
                          PetDetailBox(
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
    );
  }
}
