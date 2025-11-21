// import "dart:convert";
// import "dart:developer";
// import "dart:ui";

// import "package:al_quran_v3/src/theme/controller/theme_cubit.dart";
// import "package:al_quran_v3/src/theme/controller/theme_state.dart";
// import "package:firebase_ai/firebase_ai.dart";
// import "package:fluentui_system_icons/fluentui_system_icons.dart";
// import "package:flutter/material.dart";
// import "package:flutter_bloc/flutter_bloc.dart";
// import "package:fluttertoast/fluttertoast.dart";
// import "package:gap/gap.dart";

// class SearchScreen extends StatefulWidget {
//   const SearchScreen({super.key});

//   @override
//   State<SearchScreen> createState() => _SearchScreenState();
// }

// class _SearchScreenState extends State<SearchScreen> {
//   TextEditingController textEditingController = TextEditingController();
//   bool resultView = false;
//   Map? result;
//   String? errorText;

//   Future<void> onSearch(String query) async {
//     setState(() {
//       result = null;
//       resultView = true;
//       errorText = null;
//     });

//     String prompt = """
// You are an intelligent backend API for a Quran Mobile Application. Your task is to perform a semantic search based on a user's query and return a structured JSON response.

// **Input:**
// User Query: "$query"

// **Instructions:**
// 1. Analyze the user's query semantically (look for meaning, not just keyword matching).
// 2. Identify relevant Quranic Ayahs that answer or relate to the query.
// 3. Group these Ayahs logically based on sub-themes or contexts within the query.
// 4. **Strict Output Rule:** Return ONLY valid JSON. Do not include introduction text, markdown formatting (like ```json), or explanations.

// **Data Constraints:**
// - Do NOT include Arabic text.
// - Do NOT include translations.
// - Only return `surah_number` and `ayah_number`.
// - Include a short, descriptive `group_title` for each cluster of verses.

// **JSON Structure:**
// The output must strictly follow this schema:
// {
//   "search_meta": {
//     "query_analyzed": "String",
//     "total_groups": Integer
//   },
//   "data": [
//     {
//       "group_title": "String (Context of this group)",
//       "relevance_score": Float (0.0 to 1.0),
//       "verses": [
//         {
//           "surah_number": Integer,
//           "ayah_number": Integer
//         }
//       ]
//     }
//   ]
// }

// **Example:**
// If query is "patience and prayer", output:
// {
//   "search_meta": {
//     "query_analyzed": "patience and prayer",
//     "total_groups": 1
//   },
//   "data": [
//     {
//       "group_title": "Seeking help through patience and prayer",
//       "relevance_score": 0.98,
//       "verses": [
//         { "surah_number": 2, "ayah_number": 45 },
//         { "surah_number": 2, "ayah_number": 153 }
//       ]
//     }
//   ]
// }
// """;
//     final model = FirebaseAI.googleAI().generativeModel(
//       model: "gemini-2.5-flash-lite",
//     );

//     try {
//       log("Going to call AI");
//       final response = await model.generateContent([Content.text(prompt)]);
//       result = jsonDecode(response.text ?? "{}");
//       log(response.text.toString(), name: "AI Response");
//     } catch (e) {
//       errorText = e.toString();
//       log(e.toString(), name: "AI Response");
//     }
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     ThemeState themeState = context.read<ThemeCubit>().state;
//     bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

//     return Scaffold(
//       body: Stack(
//         children: [
//           if (resultView)
//             ListView.builder(
//               padding: EdgeInsets.only(
//                 top: MediaQuery.of(context).padding.top + 90,
//                 bottom: 100,
//                 left: 15,
//                 right: 15,
//               ),
//               itemCount: result?.length ?? 1,
//               itemBuilder: (context, index) {
//                 if (result != null) {
//                   return Container();
//                 }
//                 return SizedBox(
//                   height: MediaQuery.of(context).size.height * 0.7,
//                   child: Center(
//                     child:
//                         errorText != null
//                             ? Text(errorText.toString())
//                             : CircularProgressIndicator(
//                               backgroundColor: themeState.primaryShade100,
//                             ),
//                   ),
//                 );
//               },
//             ),
//           AnimatedContainer(
//             duration: const Duration(milliseconds: 300),
//             margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
//             height: resultView ? 100 : MediaQuery.of(context).size.height,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 if (!resultView)
//                   const Text(
//                     "AI Search",
//                     style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
//                   ),
//                 if (!resultView) const Gap(8),
//                 if (!resultView)
//                   Text(
//                     "Find Ayahs using natural language",
//                     style: TextStyle(
//                       fontSize: 16,
//                       color: Colors.grey.shade600,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 if (!resultView) const Gap(20),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16),
//                   child: ClipRRect(
//                     child: BackdropFilter(
//                       filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
//                       child: SearchBar(
//                         hintText: "e.g., verses about patience",
//                         hintStyle: const WidgetStatePropertyAll(
//                           TextStyle(color: Colors.grey),
//                         ),
//                         controller: textEditingController,
//                         onSubmitted: (value) {
//                           if (value.trim().isNotEmpty) {
//                             onSearch(value);
//                           } else {
//                             Fluttertoast.showToast(
//                               msg: "Please enter a search query",
//                             );
//                           }
//                         },
//                         elevation: const WidgetStatePropertyAll(0),
//                         leading: const Icon(FluentIcons.search_24_filled),
//                         backgroundColor: WidgetStatePropertyAll(
//                           themeState.primaryShade100,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 if (!resultView) const Gap(16),
//                 if (!resultView)
//                   const Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 16),
//                     child: Text(
//                       "This search utilizes Al models to find relevant Ayahs",
//                       style: TextStyle(fontSize: 12, color: Colors.grey),
//                     ),
//                   ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
