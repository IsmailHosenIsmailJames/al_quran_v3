import os
import json

listOfFiles = ['Indopak Nastaleeq.json', 'QPC Hafs Tajweed.json', 'Uthmani.json']

quranAyahCount = [7 ,286 ,200 ,176 ,120 ,165 ,206 ,75 ,129 ,109 ,123 ,111 ,43 ,52 ,99 ,128 ,111 ,110 ,98 ,135 ,112 ,78 ,118 ,64 ,77 ,227 ,93 ,88 ,69 ,60 ,34 ,30 ,73 ,54 ,45 ,83 ,182 ,88 ,75 ,85 ,54 ,53 ,89 ,59 ,37 ,35 ,38 ,29 ,18 ,45 ,60 ,49 ,62 ,55 ,78 ,96 ,29 ,22 ,24 ,13 ,14 ,11 ,11 ,18 ,12 ,12 ,30 ,52 ,52 ,44 ,28 ,28 ,20 ,56 ,40 ,31 ,50 ,40 ,46 ,42 ,29 ,19 ,36 ,25 ,22 ,17 ,19 ,26 ,30 ,20 ,15 ,21 ,11 ,8 ,8 ,19 ,5 ,8 ,8 ,11 ,11 ,8 ,3 ,9 ,5 ,4 ,7 ,3 ,6 ,3 ,5 ,4 ,5 ,6 ]

for scriptFileName in listOfFiles:
    with open(scriptFileName, 'r') as f:
        simplifiedScriptMap = dict()
        wordMaps = dict(json.load(f)) 
        for surahNumber in range(1, 115):
            ayahLen = quranAyahCount[surahNumber-1]
            for ayahNumber in range(1, ayahLen+1):
                wordNumber = 1
                while(True):
                    if(wordMaps.get(f"{surahNumber}:{ayahNumber}:{wordNumber}", None)==None):
                        break
                    if(simplifiedScriptMap.get(str(surahNumber), None)==None):
                        simplifiedScriptMap[str(surahNumber)] = {}
                    
                    ayahsMap = dict(simplifiedScriptMap.get(str(surahNumber), {}))
                    
                    previousWords = list(ayahsMap.get(str(ayahNumber), []))
                    
                    previousWords.append(wordMaps[f"{surahNumber}:{ayahNumber}:{wordNumber}"]['text'])
                    
                    simplifiedScriptMap[str(surahNumber)][str(ayahNumber)] = previousWords
                    wordNumber+=1

        with open(f'{scriptFileName}.simplified.json', 'w') as f:
            json.dump(simplifiedScriptMap, f, ensure_ascii=False)

