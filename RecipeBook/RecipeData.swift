//
//  RecipeData.swift
//  RecipeBook
//
//  Created by Jonathan Wåger on 2023-11-08.
//

import Foundation

let sampleRecipes = [
    Recipe(
        title: "Lasagne",
        ingredients: [
            "450 gram nötfärs",
            "225 gram italiensk korvfärs",
            "1 lök, hackad",
            "2 vitlöksklyftor, pressade",
            "1 burk (800 gram) krossade tomater",
            "2 burkar (à 170 gram) tomatpuré",
            "2 burkar (à 170 gram) tomatkross",
            "1 1/2 dl vatten",
            "2 matskedar socker",
            "2 teskedar salt",
            "1 1/2 tesked torkad basilika",
            "1/2 tesked torkad oregano",
            "1/2 tesked fänkålsfrön",
            "1/4 tesked svartpeppar"
        ],
        instructions: [
            "I en stor stekpanna, stek nötfärsen och den italienska korvfärsen över medelvärme tills de är genomstekta. Häll bort överflödig fett.",
            "Tillsätt hackad lök och pressad vitlök till stekpannan. Stek tills löken är genomskinlig.",
            "Rör i krossade tomater, tomatpuré, tomatkross och vatten.",
            "Tillsätt socker, salt, basilika, oregano, fänkålsfrön och svartpeppar. Blanda väl.",
            "Låt såsen sjuda, utan lock, i cirka 30 minuter under omrörning då och då.",
            "I en skål, blanda ricottaost, ägg, 2 dl mozzarellaost, 1 1/2 dl riven parmesanost, hackad persilja, salt och peppar. Blanda tills det är väl blandat.",
            "Förvärm ugnen till 190°C.",
            "Sprid ett tunt lager köttfärssås i en ugnsfast form, ca 23x33 cm.",
            "Placera 3 lasagneplattor ovanpå såsen.",
            "Sprid en tredjedel av ostfyllningen över plattorna.",
            "Upprepa lagren: sås, plattor, ostfyllning, tills du har använt alla ingredienserna. Avsluta med ett lager köttfärssås på toppen.",
            "Täck formen med aluminiumfolie och grädda i den förvärmde ugnen i 25 minuter.",
            "Ta bort folien och strö över resterande 2 dl mozzarellaost och extra riven parmesanost.",
            "Grädda, utan folie, i ytterligare 25 minuter eller tills lasagnen är varm och bubblande.",
            "Låt lasagnen vila i cirka 15 minuter innan servering.",
            "Garnera med färska basilikablad om så önskas."
        ],
        imageName: "lasagna"
    ),
    Recipe(
        title: "Spaghetti Carbonara",
        ingredients: [
            "350 gram spaghetti",
            "150 gram pancetta eller guanciale, tärnad",
            "2 stora ägg",
            "100 gram Pecorino Romano ost, riven",
            "Salt och svartpeppar efter smak",
            "2 vitlöksklyftor, pressade (valfritt)",
        ],
        instructions: [
            "Koka spaghettin i en stor kastrull med saltat kokande vatten tills den är al dente. Häll av vattnet och ställ åt sidan.",
            "I en stekpanna, stek den tärnade pancettan eller guancialet tills den blir knaprig. Om du använder vitlök, tillsätt den i stekpannan och sautera tills den doftar gott.",
            "I en skål, vispa ihop äggen och den rivna Pecorino Romano osten. Krydda med svartpeppar.",
            "Tillsätt den kokta spaghettin i stekpannan med pancettan eller guancialet. Blanda ihop.",
            "Ta bort stekpannan från värmen och häll snabbt ägg- och ostblandningen över pastan. Blanda kraftigt för att skapa en krämig sås. Värmen från pastan kommer att tillaga äggen och skapa en silkeslen sås.",
            "Servera genast, garnerad med extra Pecorino Romano ost och svartpeppar."
        ],
        imageName: "carbonara"
    ),
    Recipe(
        title: "Kycklingfajitas",
        ingredients: [
            "2 kycklingbröstfiléer, benfria och utan skinn, skivade",
            "1 röd paprika, skivad",
            "1 grön paprika, skivad",
            "1 lök, skivad",
            "2 vitlöksklyftor, pressade",
            "2 matskedar vegetabilisk olja",
            "1 tesked chilipulver",
            "1 tesked spiskummin",
            "1/2 tesked paprika",
            "Salt och svartpeppar efter smak",
            "Tortillas och tillbehör (gräddfil, salsa, riven ost, guacamole) för servering"
        ],
        instructions: [
            "I en stor stekpanna, hetta upp vegetabilisk olja över medelhög värme.",
            "Lägg de skivade kycklingfiléerna i stekpannan och stek tills de inte längre är rosa. Ta sedan bort dem från stekpannan och ställ åt sidan.",
            "I samma stekpanna, tillsätt mer olja om det behövs och stek de skivade paprikorna och löken tills de börjar mjukna.",
            "Tillsätt pressad vitlök, chilipulver, spiskummin, paprika, salt och svartpeppar i stekpannan. Rör om för att blanda och stek i ytterligare en minut.",
            "Lägg tillbaka den tillagade kycklingen i stekpannan och blanda ihop med paprika- och lökblandningen.",
            "Värm tortillabröden i en torr stekpanna eller i mikrovågsugnen. Servera sedan kycklingfajitablandningen i tortillabröd med valfria tillbehör."
        ],
        imageName: "fajitas"
    ),
    Recipe(
        title: "Kyckling Alfredo",
        ingredients: [
            "225 gram fettuccinepasta",
            "2 kycklingfiléer, benfria och utan skinn",
            "2 matskedar olivolja",
            "2 vitlöksklyftor, pressade",
            "2,5 dl vispgrädde",
            "115 gram osaltat smör",
            "2,5 dl riven Parmesanost",
            "Salt och svartpeppar efter smak",
            "Färsk persilja, hackad, för garnering"
        ],
        instructions: [
            "Koka fettuccinepastan enligt anvisningarna på förpackningen tills den är al dente. Häll av vattnet och ställ åt sidan.",
            "Krydda kycklingfiléerna med salt och svartpeppar. I en stor stekpanna, hetta upp olivoljan över medelhög värme. Lägg kycklingfiléerna i pannan och stek tills de inte längre är rosa i mitten, ca 6-7 minuter per sida. Ta bort kycklingen från pannan och låt den vila några minuter. Skiva sedan kycklingen i tunna strimlor.",
            "I samma stekpanna, tillsätt de pressade vitlöksklyftorna och stek i ca 1 minut tills de doftar gott. Tillsätt vispgrädde och smör, och rör tills smöret smält och blandningen är varm, men inte kokande.",
            "Rör i den riven Parmesanosten och fortsätt att laga, rör om, tills såsen tjocknar och osten är helt smält och blandad.",
            "Tillsätt den kokta fettuccinepastan i stekpannan och blanda väl med den krämiga Alfredosåsen. Lägg till de skivade kycklingarna och blanda försiktigt. Låt allt värmas igenom i några minuter.",
            "Garnera med hackad färsk persilja och servera genast."
        ],
        imageName: "alfredo"
    ),

    Recipe(
        title: "Biffwok",
        ingredients: [
            "450 gram biff av innanlår, tunt skivad",
            "2 matskedar sojasås",
            "1 matsked ostronsås",
            "1 matsked majsstärkelse",
            "2 matskedar vegetabilisk olja",
            "1 röd paprika, skivad",
            "1 grön paprika, skivad",
            "1 liten lök, skivad",
            "2 vitlöksklyftor, pressade",
            "1 tesked färsk ingefära, riven",
            "Kokt ris eller nudlar för servering"
        ],
        instructions: [
            "I en skål, blanda sojasås, ostronsås och majsstärkelse. Lägg den skivade biffen i denna blandning och marinera i 15-20 minuter.",
            "Hetta upp 1 matsked vegetabilisk olja i en wok eller en stor stekpanna över hög värme. Lägg den marinerade biffen och woka i 2-3 minuter tills den fått färg. Ta bort biffen från pannan och ställ åt sidan.",
            "I samma panna, tillsätt den återstående matskeden vegetabilisk olja. Tillsätt vitlök och riven ingefära, och woka i ca 30 sekunder tills det doftar gott.",
            "Tillsätt de skivade paprikorna och löken till pannan. Woka i 2-3 minuter tills grönsakerna är krispiga och mjuka.",
            "Lägg tillbaka den tillagade biffen i pannan och blanda med grönsakerna. Woka i ytterligare 1-2 minuter tills allt är genomvarmt.",
            "Servera biffwoken över kokt ris eller med nudlar och njut."
        ],
        imageName: "stirfry"
    ),

    Recipe(
        title: "Grönsakscurry",
        ingredients: [
            "2 matskedar vegetabilisk olja",
            "1 lök, hackad",
            "2 vitlöksklyftor, pressade",
            "1 matsked riven färsk ingefära",
            "2 matskedar currypulver",
            "1 tesked spiskummin",
            "1 tesked koriander",
            "1/2 tesked gurkmeja",
            "1/2 tesked paprika",
            "1 burk (400g) kikärter, sköljda och avrunna",
            "1 burk (400g) krossade tomater",
            "2,5 dl kokosmjölk",
            "2 dl blandade grönsaker (t.ex. morötter, ärter, paprika)",
            "Salt och peppar efter smak",
            "Färsk koriander, hackad, för garnering",
            "Kokt ris eller naanbröd för servering"
        ],
        instructions: [
            "I en stor stekpanna, hetta upp vegetabilisk olja över medelvärme. Tillsätt den hackade löken och stek i 3-4 minuter tills den blir genomskinlig.",
            "Tillsätt de pressade vitlöksklyftorna och den rivna ingefäran i stekpannan och stek i ytterligare 1-2 minuter tills det doftar gott.",
            "Rör i currypulver, spiskummin, koriander, gurkmeja och paprika. Stek i ca 1 minut medan du rör ständigt.",
            "Tillsätt kikärter, krossade tomater (med saften) och kokosmjölk i stekpannan. Rör om och låt blandningen sjuda i 10 minuter.",
            "Lägg i de blandade grönsakerna och låt dem koka tills de är mjuka, ca 10-15 minuter.",
            "Smaka av med salt och peppar. Servera grönsakscurryn över kokt ris eller med naanbröd. Garnera med hackad färsk koriander."
        ],
        imageName: "curry"
    ),

    // Add more recipes
]
