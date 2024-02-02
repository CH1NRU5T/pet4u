import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet4u/constants/custom_colors.dart';
import 'package:pet4u/features/home/bloc/home_bloc.dart';
import 'package:pet4u/features/home/bloc/home_state.dart';
import 'package:pet4u/features/pet_details/screens/pet_detail_screen.dart';
import 'package:pet4u/features/theme/bloc/theme_bloc.dart';
import 'package:pet4u/features/theme/bloc/theme_event.dart';
import 'package:pet4u/models/pet_model.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title:
              Text('History', style: Theme.of(context).textTheme.headlineLarge),
          actions: [
            PopupMenuButton(
              iconColor: (context.read<ThemeBloc>().isDark ?? false)
                  ? Colors.white
                  : Colors.black,
              itemBuilder: (context) {
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
              },
              onSelected: (_) {
                context.read<ThemeBloc>().add(ThemeChangeEvent());
              },
            ),
          ],
        ),
        body: BlocConsumer<HomeBloc, HomeState>(
          listener: (context, state) {},
          builder: (context, state) {
            List<Pet> allPets = context.read<HomeBloc>().pets;
            List<String> adoptedPets = context.read<HomeBloc>().adoptedPets!;
            List<Pet> adopted = [];
            for (Pet pet in allPets) {
              if (adoptedPets.contains(pet.id)) {
                adopted.add(pet);
              }
            }
            return adopted.isEmpty
                ? Center(
                    child: Text(
                      'No pets adopted yet!',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  )
                : ListView.separated(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(12),
                    itemCount: adopted.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return PetDetailScreen(pet: adopted[index]);
                              },
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: CustomColors.getColorForSpecie(
                                adopted[index].species),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 200,
                                child: CachedNetworkImage(
                                  imageUrl: adopted[index].urlToImage,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                adopted[index].name,
                                style:
                                    Theme.of(context).textTheme.headlineMedium,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, _) {
                      return const SizedBox(height: 10);
                    },
                  );
          },
        ),
      ),
    );
  }
}
