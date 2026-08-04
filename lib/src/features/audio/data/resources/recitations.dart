import 'package:al_quran_v3/src/features/audio/data/models/recitation_info_model.dart';

String baseOfSegmentsAudioResource =
    "audio/audio_with_segments_compressed/ayah-recitation";

List<Map<String, dynamic>> recitationsInfoList = [
  {
    "link": "https://everyayah.com/data/Abdul_Basit_Murattal_64kbps",
    "name": "Abdul Basit Abdus Samad",
    "style": "Murattal",
    "segments_url":
        "$baseOfSegmentsAudioResource-abdul-basit-abdul-samad-murattal-hafs-950.json.txt",
    "img":
        "https://www.assabile.com/media/person/200x256/abdelbasset-abdessamad.png",
    "bio":
        "https://www.assabile.com/abdelbasset-abdessamad-2/abdelbasset-abdessamad.htm",
    "source": "EveryAyah.com",
  },
  {
    "link": "https://verses.quran.foundation/AbdulBaset/Mujawwad/mp3",
    "name": "Abdul Basit Abdus Samad",
    "style": "Mujawwad",
    "segments_url":
        "$baseOfSegmentsAudioResource-abdul-basit-abdul-samad-mujawwad-hafs-949.json.txt",
    "img":
        "https://www.assabile.com/media/person/200x256/abdelbasset-abdessamad.png",
    "bio":
        "https://www.assabile.com/abdelbasset-abdessamad-2/abdelbasset-abdessamad.htm",
    "source": "Quran.com",
  },
  {
    "link": "https://everyayah.com/data/warsh/warsh_Abdul_Basit_128kbps",
    "name": "Abdul Basit Abdus Samad",
    "style": "Warsh",
    "img":
        "https://www.assabile.com/media/person/200x256/abdelbasset-abdessamad.png",
    "bio":
        "https://www.assabile.com/abdelbasset-abdessamad-2/abdelbasset-abdessamad.htm",
    "source": "EveryAyah.com",
  },
  {
    "link": "https://everyayah.com/data/Abdullah_Basfar_64kbps",
    "name": "Abdullah Basfar",
    "style": "Mujawwad",
    "img":
        "https://www.assabile.com/media/person/200x256/abdullah-ibn-ali-basfar.png",
    "bio":
        "https://www.assabile.com/abdullah-ibn-ali-basfar-6/abdullah-ibn-ali-basfar.htm",
    "source": "EveryAyah.com",
  },
  {
    "link": "https://everyayah.com/data/Ayman_Sowaid_64kbps",
    "name": "Ayman Sowaid",
    "style": "Murattal",
    "img": "https://www.assabile.com/media/person/200x256/ayman-swid.jpg",
    "bio": "https://www.assabile.com/ayman-swed-345/ayman-swed.htm",
    "source": "EveryAyah.com",
  },
  {
    "link":
        "https://mirrors.quranicaudio.com/everyayah/Mohammad_al_Tablaway_128kbps/",
    "name": "Mohamed al-Tablawi",
    "segments_url":
        "$baseOfSegmentsAudioResource-mohamed-al-tablawi-recitation-murattal-hafs-73.json.txt",
    "style": "Mujawwad",
    "img": "https://www.assabile.com/media/person/200x256/mohamed-tablawi.png",
    "bio": "https://www.assabile.com/mohamed-tablawi-31/mohamed-tablawi.htm",
    "source": "Quran.com",
  },
];

final List<ReciterInfoModel> availableRecitations = recitationsInfoList
    .map((e) => ReciterInfoModel.fromMap(e))
    .toList();
