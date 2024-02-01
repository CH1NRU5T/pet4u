import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet4u/features/home/bloc/home_bloc.dart';
import 'package:pet4u/features/home/screens/home_screen.dart';
import 'package:pet4u/features/theme/bloc/theme_bloc.dart';
import 'package:pet4u/features/theme/bloc/theme_event.dart';
import 'package:pet4u/features/theme/bloc/theme_state.dart';
import 'package:pet4u/features/theme/custom_theme.dart';
import 'package:pet4u/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  List<Map<String, dynamic>> data = [
    {
      "name": "Buddy",
      "species": "Dog",
      "breed": "Golden Retriever",
      "age": 3,
      "weight": 30,
      "height": 22,
      "urlToImage": "https://example.com/buddy_image.jpg",
      "description":
          "Buddy is a friendly and energetic Golden Retriever. He loves playing fetch and going for long walks."
    },
    {
      "name": "Whiskers",
      "species": "Cat",
      "breed": "Siamese",
      "age": 2,
      "weight": 10,
      "height": 12,
      "urlToImage": "https://example.com/whiskers_image.jpg",
      "description":
          "Whiskers is a graceful Siamese cat with striking blue eyes. She enjoys lounging in the sun and chasing feather toys."
    },
    {
      "name": "Rex",
      "species": "Other",
      "breed": "Parrot",
      "age": 5,
      "weight": 1,
      "height": 8,
      "urlToImage": "https://example.com/rex_image.jpg",
      "description":
          "Rex is a colorful parrot with a vibrant plumage. He loves mimicking human speech and enjoys perching on shoulders."
    },
    {
      "name": "Buddy",
      "species": "Dog",
      "breed": "Golden Retriever",
      "age": 3,
      "weight": 30,
      "height": 22,
      "urlToImage": "https://example.com/buddy_image.jpg",
      "description":
          "Buddy is a friendly and energetic Golden Retriever. He loves playing fetch and going for long walks."
    },
    {
      "name": "Whiskers",
      "species": "Cat",
      "breed": "Siamese",
      "age": 2,
      "weight": 10,
      "height": 12,
      "urlToImage": "https://example.com/whiskers_image.jpg",
      "description":
          "Whiskers is a graceful Siamese cat with striking blue eyes. She enjoys lounging in the sun and chasing feather toys."
    },
    {
      "name": "Rex",
      "species": "Other",
      "breed": "Parrot",
      "age": 5,
      "weight": 1,
      "height": 8,
      "urlToImage": "https://example.com/rex_image.jpg",
      "description":
          "Rex is a colorful parrot with a vibrant plumage. He loves mimicking human speech and enjoys perching on shoulders."
    },
    {
      "name": "Mittens",
      "species": "Cat",
      "breed": "Persian",
      "age": 4,
      "weight": 12,
      "height": 10,
      "urlToImage": "https://example.com/mittens_image.jpg",
      "description":
          "Mittens is a regal Persian cat with a luxurious fur coat. She prefers quiet naps and gentle cuddles."
    },
    {
      "name": "Rocky",
      "species": "Dog",
      "breed": "Boxer",
      "age": 2,
      "weight": 25,
      "height": 20,
      "urlToImage": "https://example.com/rocky_image.jpg",
      "description":
          "Rocky is a playful and muscular Boxer. He enjoys running in the park and is great with children."
    },
    {
      "name": "Luna",
      "species": "Dog",
      "breed": "Labrador Retriever",
      "age": 2,
      "weight": 28,
      "height": 24,
      "urlToImage": "https://example.com/luna_image.jpg",
      "description":
          "Luna is an intelligent and loyal Labrador Retriever. She loves swimming and is always eager to learn new tricks."
    },
    {
      "name": "Oliver",
      "species": "Cat",
      "breed": "Maine Coon",
      "age": 3,
      "weight": 15,
      "height": 14,
      "urlToImage": "https://example.com/oliver_image.jpg",
      "description":
          "Oliver is a majestic Maine Coon with a fluffy tail. He enjoys exploring high places and is incredibly social with everyone."
    },
    {
      "name": "Kiwi",
      "species": "Other",
      "breed": "Ferret",
      "age": 1,
      "weight": 2,
      "height": 6,
      "urlToImage": "https://example.com/kiwi_image.jpg",
      "description":
          "Kiwi is a playful ferret with boundless energy. She enjoys tunneling and playing hide and seek with her human friends."
    },
    {
      "name": "Simba",
      "species": "Cat",
      "breed": "Bengal",
      "age": 2,
      "weight": 14,
      "height": 11,
      "urlToImage": "https://example.com/simba_image.jpg",
      "description":
          "Simba is a sleek and adventurous Bengal cat. He loves climbing and exploring his surroundings, and he's always ready for a game of chase."
    },
    {
      "name": "Maximus",
      "species": "Dog",
      "breed": "German Shepherd",
      "age": 4,
      "weight": 35,
      "height": 26,
      "urlToImage": "https://example.com/maximus_image.jpg",
      "description":
          "Maximus is a strong and protective German Shepherd. He is loyal to his family and enjoys obedience training and agility exercises."
    },
    {
      "name": "Daisy",
      "species": "Dog",
      "breed": "Poodle",
      "age": 3,
      "weight": 15,
      "height": 18,
      "urlToImage": "https://example.com/daisy_image.jpg",
      "description":
          "Daisy is a sweet and curly-haired Poodle. She enjoys dressing up in cute outfits and is great with kids."
    },
    {
      "name": "Smokey",
      "species": "Cat",
      "breed": "Scottish Fold",
      "age": 1,
      "weight": 8,
      "height": 10,
      "urlToImage": "https://example.com/smokey_image.jpg",
      "description":
          "Smokey is an adorable Scottish Fold kitten with folded ears. He loves chasing laser pointers and cuddling on laps."
    },
    {
      "name": "Ziggy",
      "species": "Other",
      "breed": "Iguana",
      "age": 5,
      "weight": 4,
      "height": 18,
      "urlToImage": "https://example.com/ziggy_image.jpg",
      "description":
          "Ziggy is a laid-back iguana who enjoys basking under heat lamps. He's a vegetarian and loves munching on fresh greens."
    },
    {
      "name": "Mochi",
      "species": "Cat",
      "breed": "Ragdoll",
      "age": 2,
      "weight": 12,
      "height": 14,
      "urlToImage": "https://example.com/mochi_image.jpg",
      "description":
          "Mochi is a gentle and fluffy Ragdoll cat. She goes limp when picked up and loves to nap in cozy spots around the house."
    },
    {
      "name": "Thunder",
      "species": "Dog",
      "breed": "Siberian Husky",
      "age": 1,
      "weight": 25,
      "height": 20,
      "urlToImage": "https://example.com/thunder_image.jpg",
      "description":
          "Thunder is an energetic Siberian Husky with striking blue eyes. He enjoys long runs and needs plenty of exercise to stay happy."
    },
    {
      "name": "Coco",
      "species": "Dog",
      "breed": "Shih Tzu",
      "age": 4,
      "weight": 12,
      "height": 10,
      "urlToImage": "https://example.com/coco_image.jpg",
      "description":
          "Coco is a charming Shih Tzu with a fluffy coat. She enjoys being pampered and is always ready for a cuddle."
    },
    {
      "name": "Mittens",
      "species": "Cat",
      "breed": "Sphynx",
      "age": 2,
      "weight": 8,
      "height": 12,
      "urlToImage": "https://example.com/mittens_sphynx_image.jpg",
      "description":
          "Mittens is a unique Sphynx cat with no fur. Despite her hairless appearance, she loves warmth and snuggling under blankets."
    },
    {
      "name": "Rocket",
      "species": "Other",
      "breed": "Ferret",
      "age": 1,
      "weight": 1.5,
      "height": 6,
      "urlToImage": "https://example.com/rocket_image.jpg",
      "description":
          "Rocket is a playful ferret who loves to dart around. He enjoys exploring tunnels and is a master of hide-and-seek."
    },
    {
      "name": "Whiskey",
      "species": "Cat",
      "breed": "British Shorthair",
      "age": 3,
      "weight": 14,
      "height": 11,
      "urlToImage": "https://example.com/whiskey_image.jpg",
      "description":
          "Whiskey is a laid-back British Shorthair cat with a round face. He enjoys lounging on comfortable furniture and watching the world go by."
    },
    {
      "name": "Lola",
      "species": "Dog",
      "breed": "French Bulldog",
      "age": 2,
      "weight": 18,
      "height": 14,
      "urlToImage": "https://example.com/lola_image.jpg",
      "description":
          "Lola is a friendly French Bulldog with a distinctive bat ear. She loves short walks and is a great companion for apartment living."
    },
    {
      "name": "Oreo",
      "species": "Dog",
      "breed": "Dalmatian",
      "age": 2,
      "weight": 25,
      "height": 22,
      "urlToImage": "https://example.com/oreo_image.jpg",
      "description":
          "Oreo is a playful Dalmatian with distinctive black spots. He enjoys outdoor activities and is always ready for a game of frisbee."
    },
    {
      "name": "Mango",
      "species": "Cat",
      "breed": "Birman",
      "age": 1,
      "weight": 9,
      "height": 11,
      "urlToImage": "https://example.com/mango_image.jpg",
      "description":
          "Mango is a curious Birman cat with striking blue eyes. She loves exploring high places and is known for her graceful jumps."
    },
    {
      "name": "Bubbles",
      "species": "Other",
      "breed": "Goldfish",
      "age": 1,
      "weight": 0.5,
      "height": 2,
      "urlToImage": "https://example.com/bubbles_image.jpg",
      "description":
          "Bubbles is a vibrant goldfish with shimmering scales. She enjoys swimming gracefully in her aquarium and watching the world outside."
    },
    {
      "name": "Shadow",
      "species": "Cat",
      "breed": "Russian Blue",
      "age": 3,
      "weight": 11,
      "height": 10,
      "urlToImage": "https://example.com/shadow_image.jpg",
      "description":
          "Shadow is a calm and elegant Russian Blue cat. She enjoys quiet moments and is known for her luxurious, soft fur."
    },
    {
      "name": "Bentley",
      "species": "Dog",
      "breed": "Cavalier King Charles Spaniel",
      "age": 1,
      "weight": 15,
      "height": 12,
      "urlToImage": "https://example.com/bentley_image.jpg",
      "description":
          "Bentley is a friendly and affectionate Cavalier King Charles Spaniel. He loves snuggling on the couch and going for leisurely walks."
    },
    {
      "name": "Casper",
      "species": "Dog",
      "breed": "Cockapoo",
      "age": 2,
      "weight": 18,
      "height": 16,
      "urlToImage": "https://example.com/casper_image.jpg",
      "description":
          "Casper is a friendly and outgoing Cockapoo. He loves meeting new people and is always ready for a game of fetch in the backyard."
    },
    {
      "name": "Lily",
      "species": "Cat",
      "breed": "Calico",
      "age": 4,
      "weight": 10,
      "height": 9,
      "urlToImage": "https://example.com/lily_image.jpg",
      "description":
          "Lily is a graceful Calico cat with a mix of colors. She enjoys sunbathing by the windowsill and playing with feather toys."
    },
    {
      "name": "Rocky",
      "species": "Other",
      "breed": "Rabbit",
      "age": 1,
      "weight": 3,
      "height": 8,
      "urlToImage": "https://example.com/rocky_rabbit_image.jpg",
      "description":
          "Rocky is a playful rabbit with soft fur. He loves hopping around in his play area and munching on fresh vegetables."
    },
    {
      "name": "Whiskey",
      "species": "Cat",
      "breed": "Tabby",
      "age": 3,
      "weight": 12,
      "height": 10,
      "urlToImage": "https://example.com/whiskey_tabby_image.jpg",
      "description":
          "Whiskey is a curious Tabby cat with distinctive stripes. He enjoys exploring new spaces and pouncing on feather toys."
    },
    {
      "name": "Bella",
      "species": "Dog",
      "breed": "Shiba Inu",
      "age": 1,
      "weight": 20,
      "height": 14,
      "urlToImage": "https://example.com/bella_shiba_inu_image.jpg",
      "description":
          "Bella is an independent and spirited Shiba Inu. She loves outdoor adventures and has a strong sense of loyalty to her family."
    }
    // Add more pets as needed
  ];
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // for (Map<String, dynamic> map in data) {
  // QuerySnapshot qs = await FirebaseFirestore.instance.collection('pets').get();
  // for (var pet in qs.docs) {
  //   Pet p = Pet.fromMap(pet.data() as Map<String, dynamic>);
  //   p.id = pet.id;
  //   await FirebaseFirestore.instance.collection('pets').doc(p.id).update({
  //     'urlToImage': p.species == Species.other
  //         ? 'https://firebasestorage.googleapis.com/v0/b/pet-shop-21fe1.appspot.com/o/pets%2Fother.png?alt=media&token=54f913eb-ac86-4187-a223-7f2d9dea7c01'
  //         : p.species == Species.cat
  //             ? 'https://firebasestorage.googleapis.com/v0/b/pet-shop-21fe1.appspot.com/o/pets%2Fcat.png?alt=media&token=3edac9fe-e798-4fe8-bf59-0afdbc11fbb0'
  //             : 'https://firebasestorage.googleapis.com/v0/b/pet-shop-21fe1.appspot.com/o/pets%2Fdog.png?alt=media&token=44c259a1-e035-4ab0-9b97-f083e41ee113'
  //   });
  // }
  // }
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<HomeBloc>(
          create: (context) => HomeBloc(),
        ),
        BlocProvider<ThemeBloc>(
          create: (context) => ThemeBloc()..add(ThemeInitEvent()),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        if (state is ThemeLoadingState) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: customLightTheme,
            home: const CircularProgressIndicator(),
          );
        }
        if (state is ThemeChangedState) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: state.themeData,
            home: const HomeScreen(),
          );
        }
        return MaterialApp(
          title: 'Flutter Demo',
          theme: customLightTheme,
          home: const HomeScreen(),
        );
      },
    );
  }
}
