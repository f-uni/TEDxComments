import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tedxcomments_app/models/talk.dart';

class DataProvider {
  static Future<List<Talk>> getTalksByTag(String tag, int page) async {
    //TODO: rendere dinamica la risposta
    /*
    var url = Uri.parse(
        'https://oycb8yznqi.execute-api.us-east-1.amazonaws.com/default/TxC_GetTalksByTag');

    final http.Response response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
          <String, Object>{'tag': tag, 'page': page, 'doc_per_page': 6}),
    );
    if (response.statusCode == 200) {
      Iterable list = json.decode(response.body);
      var talks = list.map((model) => Talk.fromJSON(model)).toList();
      return talks;
    } else {
      throw Exception('Failed to load talks');
    }
    */
    String resp =
        "[{\"comments\":{\"info\":[],\"disc\":[],\"extra\":[]},\"_id\":\"110322\",\"slug\":\"daniele_quercia_happy_maps\",\"speakers\":\"Daniele Quercia\",\"title\":\"Happy maps\",\"url\":\"https://www.ted.com/talks/daniele_quercia_happy_maps\",\"description\":\"Mapping apps help us find the fastest route to where we’re going. But what if we’d rather wander? Researcher Daniele Quercia demos “happy maps” that take into account not only the route you want to take, but how you want to feel along the way.\",\"duration\":\"430\",\"publishedAt\":\"2015-01-06T16:02:14Z\",\"tags\":[\"technology\",\"design\",\"cities\",\"happiness\",\"maps\"],\"img_url\":\"https://talkstar-photos.s3.amazonaws.com/uploads/ca9c1323-81f4-40de-a1ba-cd2aefa5a07c/DanieleQuercia_2014S-stageshot.jpg\",\"related_videos\":[\"2520\",\"97264\",\"29076\",\"247474\",\"129872\",\"77604\"],\"views\":\"2908084\"},{\"comments\":{\"info\":[],\"disc\":[],\"extra\":[]},\"_id\":\"112746\",\"slug\":\"alison_killing_there_s_a_better_way_to_die_and_architecture_can_help\",\"speakers\":\"Alison Killing\",\"title\":\"There’s a better way to die, and architecture can help\",\"url\":\"https://www.ted.com/talks/alison_killing_there_s_a_better_way_to_die_and_architecture_can_help\",\"description\":\"In this short, provocative talk, architect Alison Killing looks at buildings where death and dying happen -- cemeteries, hospitals, homes. The way we die is changing, and the way we build for dying ... well, maybe that should too. It's a surprisingly fascinating look at a hidden aspect of our cities, and our lives.\",\"duration\":\"270\",\"publishedAt\":\"2015-03-30T14:56:29Z\",\"tags\":[\"design\",\"architecture\",\"cities\",\"death\",\"TED Fellows\"],\"img_url\":\"https://pe.tedcdn.com/images/ted/e7c1fa344deb60d85bb0d9b41122073570301707_2400x1800.jpg\",\"related_videos\":[\"59870\",\"92540\",\"75992\",\"122625\",\"154631\",\"119054\"],\"views\":\"1361588\"},{\"comments\":{\"info\":[{\"comment_id\":\"7bc42047-e7d3-4ec8-ac82-5b71202a9822\",\"user_id\":\"test\",\"timestamp\":30,\"title\":\"info comment 30\",\"body\":\"nice!\",\"upvote\":0},{\"comment_id\":\"802d60db-3dcc-471d-814a-3688e97899bb\",\"user_id\":\"test\",\"timestamp\":130,\"title\":\"info comment 30\",\"body\":\"nice!\",\"upvote\":0},{\"comment_id\":\"73017e83-a2c9-43e5-8740-33c0527420c5\",\"user_id\":\"test\",\"timestamp\":90,\"title\":\"info comment 30\",\"body\":\"nice!\",\"upvote\":0},{\"comment_id\":\"612ebe18-da5e-4f52-91be-18c304ee9de4\",\"user_id\":\"test\",\"timestamp\":230,\"title\":\"info comment 30\",\"body\":\"nice!\",\"upvote\":0},{\"comment_id\":\"9385eac1-5c26-448d-8f65-489e85fe4eae\",\"user_id\":\"test\",\"timestamp\":31,\"title\":\"info comment 30\",\"body\":\"nice!\",\"upvote\":0},{\"comment_id\":\"3eaf3c0f-cf45-4f32-a040-0d1666037685\",\"user_id\":\"test\",\"timestamp\":15,\"title\":\"info comment 15\",\"body\":\"nice!\",\"upvote\":0},{\"comment_id\":\"dea62f3b-4488-43b8-b720-46d9b7f014be\",\"user_id\":\"test\",\"timestamp\":15,\"title\":\"info comment 15\",\"body\":\"nice!\",\"upvote\":0}],\"disc\":[],\"extra\":[{\"comment_id\":\"550c9b7c-f25b-4f7d-96ca-fdad702b5512\",\"user_id\":\"test\",\"timestamp\":1,\"title\":\"comment 1\",\"body\":\"nice!\",\"upvote\":0},{\"comment_id\":\"2c3bc9a1-6b64-43ff-9149-0636e53a24f6\",\"user_id\":\"test\",\"timestamp\":2,\"title\":\"comment 2\",\"body\":\"nice!\",\"upvote\":0},{\"comment_id\":\"e4d78f61-550a-4ec4-b849-c33d65553591\",\"user_id\":\"test\",\"timestamp\":3,\"title\":\"comment 3\",\"body\":\"nice!\",\"upvote\":0},{\"comment_id\":\"6aace18a-a01e-4cad-b14d-4d5630715177\",\"user_id\":\"test\",\"timestamp\":10,\"title\":\"comment 3\",\"body\":\"nice!\",\"upvote\":0},{\"comment_id\":\"be678c48-1223-472c-bc3b-6a1ceb837b6c\",\"user_id\":\"test\",\"timestamp\":10,\"title\":\"comment 10\",\"body\":\"nice!\",\"upvote\":0},{\"comment_id\":\"82f1e0fd-c8a1-4e5d-a3bf-78635ff61bbf\",\"user_id\":\"test\",\"timestamp\":20,\"title\":\"comment 20\",\"body\":\"nice!\",\"upvote\":0}]},\"_id\":\"103856\",\"slug\":\"margaret_gould_stewart_how_giant_websites_design_for_you_and_a_billion_others_too\",\"speakers\":\"Margaret Gould Stewart\",\"title\":\"How giant websites design for you (and a billion others, too)\",\"url\":\"https://www.ted.com/talks/margaret_gould_stewart_how_giant_websites_design_for_you_and_a_billion_others_too\",\"description\":\"Facebook's like and share buttons are seen 22 billion times a day, making them some of the most-viewed design elements ever created. Margaret Gould Stewart, Facebook's director of product design, outlines three rules for design at such a massive scale—one so big that the tiniest of tweaks can cause global outrage, but also so large that the subtlest of improvements can positively impact the lives of many.\",\"duration\":\"766\",\"publishedAt\":\"2014-08-05T15:19:04Z\",\"tags\":[\"culture\",\"technology\",\"design\",\"business\",\"graphic design\"],\"img_url\":\"https://pe.tedcdn.com/images/ted/dad8156a2735b62bea89c854051e080a8a24c463_2400x1800.jpg\",\"related_videos\":[\"38852\",\"66356\",\"6232\",\"28524\",\"17271\",\"10231\"],\"views\":\"1906785\",\"__v\":13},{\"comments\":{\"info\":[],\"disc\":[],\"extra\":[]},\"_id\":\"133984\",\"slug\":\"wanis_kabbaj_what_a_driverless_world_could_look_like\",\"speakers\":\"Wanis Kabbaj\",\"title\":\"What a driverless world could look like\",\"url\":\"https://www.ted.com/talks/wanis_kabbaj_what_a_driverless_world_could_look_like\",\"description\":\"What if traffic flowed through our streets as smoothly and efficiently as blood flows through our veins? Transportation geek Wanis Kabbaj thinks we can find inspiration in the genius of our biology to design the transit systems of the future. In this forward-thinking talk, preview exciting concepts like modular, detachable buses, flying taxis and networks of suspended magnetic pods that could help make the dream of a dynamic, driverless world into a reality.\",\"duration\":\"681\",\"publishedAt\":\"2016-10-24T15:15:37Z\",\"tags\":[\"technology\",\"design\",\"transportation\",\"cities\",\"collaboration\",\"urban planning\",\"nature\",\"biology\",\"communication\",\"product design\",\"infrastructure\",\"driverless cars\"],\"img_url\":\"https://talkstar-photos.s3.amazonaws.com/uploads/c3431fed-6746-4044-bb1d-2abc4ac26724/WanisKabbaj_2016S-embed.jpg\",\"related_videos\":[\"85722\",\"117078\",\"131568\",\"76320\",\"143321\",\"137330\"],\"views\":\"4282418\"},{\"comments\":{\"info\":[],\"disc\":[],\"extra\":[]},\"_id\":\"122507\",\"slug\":\"raymond_wang_how_germs_travel_on_planes_and_how_we_can_stop_them\",\"speakers\":\"Raymond Wang\",\"title\":\"How germs travel on planes -- and how we can stop them\",\"url\":\"https://www.ted.com/talks/raymond_wang_how_germs_travel_on_planes_and_how_we_can_stop_them\",\"description\":\"Raymond Wang is only 17 years old, but he's already helping to build a healthier future. Using fluid dynamics, he created computational simulations of how air moves on airplanes, and what he found is disturbing -- when a person sneezes on a plane, the airflow actually helps to spread pathogens to other passengers. Wang shares an unforgettable animation of how a sneeze travels inside a plane cabin as well as his prize-winning solution: a small, fin-shaped device that increases fresh airflow in airplanes and redirects pathogen-laden air out of circulation.\",\"duration\":\"378\",\"publishedAt\":\"2015-12-10T16:16:53Z\",\"tags\":[\"science\",\"design\",\"engineering\",\"invention\",\"flight\",\"transportation\",\"innovation\",\"health\",\"physics\",\"illness\",\"bacteria\"],\"img_url\":\"https://talkstar-photos.s3.amazonaws.com/uploads/a821118b-19d7-4892-a7c1-9c28d6bdda7e/RaymondWang_2015Y-embed.jpg\",\"related_videos\":[\"32020\",\"118592\",\"84230\",\"205858\",\"267577\",\"111134\"],\"views\":\"1970327\"},{\"comments\":{\"info\":[],\"disc\":[],\"extra\":[]},\"_id\":\"10793\",\"slug\":\"moshe_safdie_building_uniqueness\",\"speakers\":\"Moshe Safdie\",\"title\":\"Building uniqueness\",\"url\":\"https://www.ted.com/talks/moshe_safdie_building_uniqueness\",\"description\":\"Looking back over his long career, architect Moshe Safdie delves into four of his design projects and explains how he labored to make each one truly unique for its site and its users.\",\"duration\":\"1047\",\"publishedAt\":\"2008-02-18T00:22:00Z\",\"tags\":[\"design\",\"architecture\",\"cities\",\"collaboration\",\"creativity\",\"visualizations\",\"museums\"],\"img_url\":\"https://pe.tedcdn.com/images/ted/30899_480x360.jpg\",\"related_videos\":[\"2480\",\"1548\",\"16797\",\"11379\",\"177197\",\"69940\"],\"views\":\"644337\"},{\"comments\":{\"info\":[],\"disc\":[],\"extra\":[]},\"_id\":\"11869\",\"slug\":\"jakob_trollback_a_new_kind_of_music_video\",\"speakers\":\"Jakob Trollback\",\"title\":\"A new kind of music video\",\"url\":\"https://www.ted.com/talks/jakob_trollback_a_new_kind_of_music_video\",\"description\":\"What would a music video look like if it were directed by the music, purely as an expression of a great song, rather than driven by a filmmaker's concept? Designer Jakob Trollback shares the results of his experiment in the form.\",\"duration\":\"220\",\"publishedAt\":\"2008-04-03T01:14:00Z\",\"tags\":[\"design\",\"entertainment\",\"music\",\"art\",\"film\",\"demo\",\"visualizations\",\"Internet\",\"animation\"],\"img_url\":\"https://pe.tedcdn.com/images/ted/36919_480x360.jpg\",\"related_videos\":[\"7039\",\"761\",\"16687\",\"7732\",\"9463\",\"120180\"],\"views\":\"556846\"},{\"comments\":{\"info\":[],\"disc\":[],\"extra\":[]},\"_id\":\"11079\",\"slug\":\"steve_jurvetson_model_rocketry\",\"speakers\":\"Steve Jurvetson\",\"title\":\"Model rocketry\",\"url\":\"https://www.ted.com/talks/steve_jurvetson_model_rocketry\",\"description\":\"Moneyman Steve Jurvetson takes TEDsters inside his awesome hobby -- launching model rockets –- by sharing some gorgeous photos, his infectious glee and just a whiff of danger.\",\"duration\":\"182\",\"publishedAt\":\"2008-02-27T12:26:00Z\",\"tags\":[\"design\",\"rocket science\",\"entertainment\",\"parenting\",\"photography\",\"space\",\"kids\",\"toys\"],\"img_url\":\"https://pe.tedcdn.com/images/ted/32552_480x360.jpg\",\"related_videos\":[\"162505\",\"115616\",\"140713\",\"178771\",\"232950\",\"141971\"],\"views\":\"475854\"},{\"comments\":{\"info\":[],\"disc\":[],\"extra\":[]},\"_id\":\"136570\",\"slug\":\"dan_bricklin_meet_the_inventor_of_the_electronic_spreadsheet\",\"speakers\":\"Dan Bricklin\",\"title\":\"Meet the inventor of the electronic spreadsheet\",\"url\":\"https://www.ted.com/talks/dan_bricklin_meet_the_inventor_of_the_electronic_spreadsheet\",\"description\":\"Dan Bricklin changed the world forever when he codeveloped VisiCalc, the first electronic spreadsheet and grandfather of programs you probably use every day like Microsoft Excel and Google Sheets. Join the software engineer and computing legend as he explores the tangled web of first jobs, daydreams and homework problems that led to his transformational invention.\",\"duration\":\"710\",\"publishedAt\":\"2017-01-11T15:52:50Z\",\"tags\":[\"technology\",\"design\",\"invention\",\"business\",\"computers\",\"collaboration\",\"innovation\",\"history\",\"product design\",\"work\",\"potential\",\"visualizations\",\"math\",\"productivity\",\"TEDx\",\"data\",\"code\",\"discovery\"],\"img_url\":\"https://talkstar-photos.s3.amazonaws.com/uploads/043e6e74-38fe-46c6-a2f6-eb60ebeb0b08/DanBricklin_2016X-embed.jpg\",\"related_videos\":[\"32006\",\"126306\",\"125456\",\"379\",\"19333\",\"2056\"],\"views\":\"1537617\"},{\"comments\":{\"info\":[],\"disc\":[],\"extra\":[]},\"_id\":\"142923\",\"slug\":\"francoise_mouly_the_stories_behind_the_new_yorker_s_iconic_covers\",\"speakers\":\"Françoise Mouly\",\"title\":\"The stories behind The New Yorker's iconic covers\",\"url\":\"https://www.ted.com/talks/francoise_mouly_the_stories_behind_the_new_yorker_s_iconic_covers\",\"description\":\"Meet Françoise Mouly, The New Yorker's art director. For the past 24 years, she's helped decide what appears on the magazine's famous cover, from the black-on-black depiction of the Twin Towers the week after 9/11 to a recent, Russia-influenced riff on the magazine's mascot, Eustace Tilley. In this visual retrospective, Mouly considers how a simple drawing can cut through the torrent of images that we see every day and elegantly capture the feeling (and the sensibility) of a moment in time.\",\"duration\":\"499\",\"publishedAt\":\"2017-08-03T14:24:04Z\",\"tags\":[\"culture\",\"design\",\"creativity\",\"art\",\"humor\"],\"img_url\":\"https://talkstar-photos.s3.amazonaws.com/uploads/d7c950bf-6baf-4150-8483-552bd990350c/FrancoiseMouly_2017S-embed.jpg\",\"related_videos\":[\"127116\",\"89008\",\"130328\",\"176761\",\"292992\",\"234164\"],\"views\":\"1309522\"}]";
    await Future.delayed(const Duration(milliseconds: 1000));
    Iterable list = json.decode(resp);
    var talks = list.map((model) => Talk.fromJSON(model)).toList();
    return talks;
  }

  static Future<List<Talk>> getRelatedTalksById(String id) async {
    //TODO: rendere dinamica la risposta
    /*
    var url = Uri.parse(
        'https://f2ni1mahx9.execute-api.us-east-1.amazonaws.com/default/TxC_GetWatchNextById');

    final http.Response response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
          <String, Object>{'video_id': id}),
    );
    if (response.statusCode == 200) {
      Iterable list = json.decode(response.body)["result"]["related_videos"];
      var talks = list.map((model) => Talk.fromJSON(model)).toList();
      return talks;
    } else {
      throw Exception('Failed to load talks');
    }*/
    String resp =
        "{\"result\":{\"comments\":{\"info\":[{\"comment_id\":\"7bc42047-e7d3-4ec8-ac82-5b71202a9822\",\"user_id\":\"test\",\"timestamp\":130,\"title\":\"info comment 30\",\"body\":\"nice!\",\"upvote\":0},{\"comment_id\":\"802d60db-3dcc-471d-814a-3688e97899bb\",\"user_id\":\"test\",\"timestamp\":30,\"title\":\"info comment 30\",\"body\":\"nice!\",\"upvote\":0},{\"comment_id\":\"73017e83-a2c9-43e5-8740-33c0527420c5\",\"user_id\":\"test\",\"timestamp\":90,\"title\":\"info comment 30\",\"body\":\"nice!\",\"upvote\":0},{\"comment_id\":\"612ebe18-da5e-4f52-91be-18c304ee9de4\",\"user_id\":\"test\",\"timestamp\":230,\"title\":\"info comment 30\",\"body\":\"nice!\",\"upvote\":0},{\"comment_id\":\"9385eac1-5c26-448d-8f65-489e85fe4eae\",\"user_id\":\"test\",\"timestamp\":31,\"title\":\"info comment 30\",\"body\":\"nice!\",\"upvote\":0},{\"comment_id\":\"3eaf3c0f-cf45-4f32-a040-0d1666037685\",\"user_id\":\"test\",\"timestamp\":15,\"title\":\"info comment 15\",\"body\":\"nice!\",\"upvote\":0},{\"comment_id\":\"dea62f3b-4488-43b8-b720-46d9b7f014be\",\"user_id\":\"test\",\"timestamp\":15,\"title\":\"info comment 15\",\"body\":\"nice!\",\"upvote\":0}],\"disc\":[],\"extra\":[{\"comment_id\":\"550c9b7c-f25b-4f7d-96ca-fdad702b5512\",\"user_id\":\"test\",\"timestamp\":1,\"title\":\"comment 1\",\"body\":\"nice!\",\"upvote\":0},{\"comment_id\":\"2c3bc9a1-6b64-43ff-9149-0636e53a24f6\",\"user_id\":\"test\",\"timestamp\":2,\"title\":\"comment 2\",\"body\":\"nice!\",\"upvote\":0},{\"comment_id\":\"e4d78f61-550a-4ec4-b849-c33d65553591\",\"user_id\":\"test\",\"timestamp\":3,\"title\":\"comment 3\",\"body\":\"nice!\",\"upvote\":0},{\"comment_id\":\"6aace18a-a01e-4cad-b14d-4d5630715177\",\"user_id\":\"test\",\"timestamp\":10,\"title\":\"comment 3\",\"body\":\"nice!\",\"upvote\":0},{\"comment_id\":\"be678c48-1223-472c-bc3b-6a1ceb837b6c\",\"user_id\":\"test\",\"timestamp\":10,\"title\":\"comment 10\",\"body\":\"nice!\",\"upvote\":0},{\"comment_id\":\"82f1e0fd-c8a1-4e5d-a3bf-78635ff61bbf\",\"user_id\":\"test\",\"timestamp\":20,\"title\":\"comment 20\",\"body\":\"nice!\",\"upvote\":0}]},\"_id\":\"103856\",\"slug\":\"margaret_gould_stewart_how_giant_websites_design_for_you_and_a_billion_others_too\",\"speakers\":\"Margaret Gould Stewart\",\"title\":\"How giant websites design for you (and a billion others, too)\",\"url\":\"https://www.ted.com/talks/margaret_gould_stewart_how_giant_websites_design_for_you_and_a_billion_others_too\",\"description\":\"Facebook's like and share buttons are seen 22 billion times a day, making them some of the most-viewed design elements ever created. Margaret Gould Stewart, Facebook's director of product design, outlines three rules for design at such a massive scale—one so big that the tiniest of tweaks can cause global outrage, but also so large that the subtlest of improvements can positively impact the lives of many.\",\"duration\":\"766\",\"publishedAt\":\"2014-08-05T15:19:04Z\",\"tags\":[\"culture\",\"technology\",\"design\",\"business\",\"graphic design\"],\"img_url\":\"https://pe.tedcdn.com/images/ted/dad8156a2735b62bea89c854051e080a8a24c463_2400x1800.jpg\",\"related_videos\":[{\"_id\":\"10231\",\"speakers\":\"Paola Antonelli\",\"title\":\"Treat design as art\",\"url\":\"https://www.ted.com/talks/paola_antonelli_treat_design_as_art\",\"duration\":\"1077\",\"img_url\":\"https://pe.tedcdn.com/images/ted/24481_480x360.jpg\",\"views\":\"723611\"},{\"_id\":\"17271\",\"speakers\":\"Paola Antonelli\",\"title\":\"Design and the Elastic Mind\",\"url\":\"https://www.ted.com/talks/paola_antonelli_design_and_the_elastic_mind\",\"duration\":\"1038\",\"img_url\":\"https://pe.tedcdn.com/images/ted/56215_480x360.jpg\",\"views\":\"412290\"},{\"_id\":\"28524\",\"speakers\":\"Tim Brown\",\"title\":\"Designers -- think big!\",\"url\":\"https://www.ted.com/talks/tim_brown_designers_think_big\",\"duration\":\"993\",\"img_url\":\"https://pe.tedcdn.com/images/ted/118805_800x600.jpg\",\"views\":\"2418363\"},{\"_id\":\"38852\",\"speakers\":\"Margaret Gould Stewart\",\"title\":\"How YouTube thinks about copyright\",\"url\":\"https://www.ted.com/talks/margaret_gould_stewart_how_youtube_thinks_about_copyright\",\"duration\":\"328\",\"img_url\":\"https://pe.tedcdn.com/images/ted/177724_800x600.jpg\",\"views\":\"1012631\"},{\"_id\":\"6232\",\"speakers\":\"David Kelley\",\"title\":\"Human-centered design\",\"url\":\"https://www.ted.com/talks/david_kelley_human_centered_design\",\"duration\":\"1007\",\"img_url\":\"https://talkstar-photos.s3.amazonaws.com/uploads/29081e2c-1069-4130-ab68-7d357fd6268f/DavidKelley_2002-stageshot.jpg\",\"views\":\"1216971\"},{\"_id\":\"66356\",\"speakers\":\"Kevin Allocca\",\"title\":\"Why videos go viral\",\"url\":\"https://www.ted.com/talks/kevin_allocca_why_videos_go_viral\",\"duration\":\"423\",\"img_url\":\"https://talkstar-photos.s3.amazonaws.com/uploads/81f3c20b-ccaa-484d-b19b-4d7ca8130a91/KevinAllocca_2011Y-embed.jpg\",\"views\":\"3441581\"}],\"views\":\"1906785\",\"__v\":13}}";
    await Future.delayed(const Duration(milliseconds: 1000));
    Iterable list = json.decode(resp)["result"]["related_videos"];
    var talks = list.map((model) => Talk.fromJSON(model)).toList();
    return talks;
  }


  static Future<dynamic> getCommentsById(String id) async {
    //TODO: rendere dinamica la risposta
    /*
    var url = Uri.parse(
        'https://f2ni1mahx9.execute-api.us-east-1.amazonaws.com/default/TxC_GetWatchNextById');

    final http.Response response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
          <String, Object>{'video_id': id}),
    );
    if (response.statusCode == 200) {
      dynamic list = json.decode(response.body)["result"]["comments"];
      return list;
    } else {
      throw Exception('Failed to load comments');
    }*/
    String resp =
        "{\"result\":{\"comments\":{\"info\":[{\"comment_id\":\"7bc42047-e7d3-4ec8-ac82-5b71202a9822\",\"user_id\":\"test\",\"timestamp\":130,\"title\":\"info comment 30!!!new\",\"body\":\"nice!\",\"upvote\":0},{\"comment_id\":\"802d60db-3dcc-471d-814a-3688e97899bb\",\"user_id\":\"test\",\"timestamp\":30,\"title\":\"info comment 30\",\"body\":\"nice!\",\"upvote\":0},{\"comment_id\":\"73017e83-a2c9-43e5-8740-33c0527420c5\",\"user_id\":\"test\",\"timestamp\":90,\"title\":\"info comment 30\",\"body\":\"nice!\",\"upvote\":0},{\"comment_id\":\"612ebe18-da5e-4f52-91be-18c304ee9de4\",\"user_id\":\"test\",\"timestamp\":230,\"title\":\"info comment 30\",\"body\":\"nice!\",\"upvote\":0},{\"comment_id\":\"9385eac1-5c26-448d-8f65-489e85fe4eae\",\"user_id\":\"test\",\"timestamp\":31,\"title\":\"info comment 30\",\"body\":\"nice!\",\"upvote\":0},{\"comment_id\":\"3eaf3c0f-cf45-4f32-a040-0d1666037685\",\"user_id\":\"test\",\"timestamp\":15,\"title\":\"info comment 15\",\"body\":\"nice!\",\"upvote\":0},{\"comment_id\":\"dea62f3b-4488-43b8-b720-46d9b7f014be\",\"user_id\":\"test\",\"timestamp\":15,\"title\":\"info comment 15\",\"body\":\"nice!\",\"upvote\":0}],\"disc\":[],\"extra\":[{\"comment_id\":\"550c9b7c-f25b-4f7d-96ca-fdad702b5512\",\"user_id\":\"test\",\"timestamp\":1,\"title\":\"comment 1\",\"body\":\"nice!\",\"upvote\":0},{\"comment_id\":\"2c3bc9a1-6b64-43ff-9149-0636e53a24f6\",\"user_id\":\"test\",\"timestamp\":2,\"title\":\"comment 2\",\"body\":\"nice!\",\"upvote\":0},{\"comment_id\":\"e4d78f61-550a-4ec4-b849-c33d65553591\",\"user_id\":\"test\",\"timestamp\":3,\"title\":\"comment 3\",\"body\":\"nice!\",\"upvote\":0},{\"comment_id\":\"6aace18a-a01e-4cad-b14d-4d5630715177\",\"user_id\":\"test\",\"timestamp\":10,\"title\":\"comment 3\",\"body\":\"nice!\",\"upvote\":0},{\"comment_id\":\"be678c48-1223-472c-bc3b-6a1ceb837b6c\",\"user_id\":\"test\",\"timestamp\":10,\"title\":\"comment 10\",\"body\":\"nice!\",\"upvote\":0},{\"comment_id\":\"82f1e0fd-c8a1-4e5d-a3bf-78635ff61bbf\",\"user_id\":\"test\",\"timestamp\":20,\"title\":\"comment 20\",\"body\":\"nice!\",\"upvote\":0}]},\"_id\":\"103856\",\"slug\":\"margaret_gould_stewart_how_giant_websites_design_for_you_and_a_billion_others_too\",\"speakers\":\"Margaret Gould Stewart\",\"title\":\"How giant websites design for you (and a billion others, too)\",\"url\":\"https://www.ted.com/talks/margaret_gould_stewart_how_giant_websites_design_for_you_and_a_billion_others_too\",\"description\":\"Facebook's like and share buttons are seen 22 billion times a day, making them some of the most-viewed design elements ever created. Margaret Gould Stewart, Facebook's director of product design, outlines three rules for design at such a massive scale—one so big that the tiniest of tweaks can cause global outrage, but also so large that the subtlest of improvements can positively impact the lives of many.\",\"duration\":\"766\",\"publishedAt\":\"2014-08-05T15:19:04Z\",\"tags\":[\"culture\",\"technology\",\"design\",\"business\",\"graphic design\"],\"img_url\":\"https://pe.tedcdn.com/images/ted/dad8156a2735b62bea89c854051e080a8a24c463_2400x1800.jpg\",\"related_videos\":[{\"_id\":\"10231\",\"speakers\":\"Paola Antonelli\",\"title\":\"Treat design as art\",\"url\":\"https://www.ted.com/talks/paola_antonelli_treat_design_as_art\",\"duration\":\"1077\",\"img_url\":\"https://pe.tedcdn.com/images/ted/24481_480x360.jpg\",\"views\":\"723611\"},{\"_id\":\"17271\",\"speakers\":\"Paola Antonelli\",\"title\":\"Design and the Elastic Mind\",\"url\":\"https://www.ted.com/talks/paola_antonelli_design_and_the_elastic_mind\",\"duration\":\"1038\",\"img_url\":\"https://pe.tedcdn.com/images/ted/56215_480x360.jpg\",\"views\":\"412290\"},{\"_id\":\"28524\",\"speakers\":\"Tim Brown\",\"title\":\"Designers -- think big!\",\"url\":\"https://www.ted.com/talks/tim_brown_designers_think_big\",\"duration\":\"993\",\"img_url\":\"https://pe.tedcdn.com/images/ted/118805_800x600.jpg\",\"views\":\"2418363\"},{\"_id\":\"38852\",\"speakers\":\"Margaret Gould Stewart\",\"title\":\"How YouTube thinks about copyright\",\"url\":\"https://www.ted.com/talks/margaret_gould_stewart_how_youtube_thinks_about_copyright\",\"duration\":\"328\",\"img_url\":\"https://pe.tedcdn.com/images/ted/177724_800x600.jpg\",\"views\":\"1012631\"},{\"_id\":\"6232\",\"speakers\":\"David Kelley\",\"title\":\"Human-centered design\",\"url\":\"https://www.ted.com/talks/david_kelley_human_centered_design\",\"duration\":\"1007\",\"img_url\":\"https://talkstar-photos.s3.amazonaws.com/uploads/29081e2c-1069-4130-ab68-7d357fd6268f/DavidKelley_2002-stageshot.jpg\",\"views\":\"1216971\"},{\"_id\":\"66356\",\"speakers\":\"Kevin Allocca\",\"title\":\"Why videos go viral\",\"url\":\"https://www.ted.com/talks/kevin_allocca_why_videos_go_viral\",\"duration\":\"423\",\"img_url\":\"https://talkstar-photos.s3.amazonaws.com/uploads/81f3c20b-ccaa-484d-b19b-4d7ca8130a91/KevinAllocca_2011Y-embed.jpg\",\"views\":\"3441581\"}],\"views\":\"1906785\",\"__v\":13}}";
    await Future.delayed(const Duration(milliseconds: 1000));
    dynamic result = json.decode(resp)["result"]["comments"];
    return result;
  }

  static Future<void> insertComment(
      String id, String title, String body, int time, String user) async {
    var url = Uri.parse(
        'https://o6cfl57kmi.execute-api.us-east-1.amazonaws.com/default/TxC_InsertComment');
    
    final http.Response response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, Object>{
        'video_id': id,
        'user_id': user,
        'timestamp': time,
        'title': title,
        'body': body,
        'type': "extra"
      }),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to insert comment');
    }
  }

  static List<String> tags = [
    "activism",
    "addiction",
    "aging",
    "agriculture",
    "algorithm",
    "aliens",
    "ancient world",
    "animals",
    "animation",
    "anthropology",
    "archaeology",
    "architecture",
    "art",
    "asteroid",
    "astrobiology",
    "astronomy",
    "atheism",
    "augmented reality",
    "bacteria",
    "beauty",
    "bees",
    "behavioral economics",
    "biodiversity",
    "bioethics",
    "biology",
    "biomimicry",
    "bionics",
    "biosphere",
    "biotech",
    "birds",
    "blindness",
    "blockchain",
    "body language",
    "books",
    "botany",
    "brain",
    "bullying",
    "business",
    "cancer",
    "capitalism",
    "chemistry",
    "china",
    "cities",
    "climate change",
    "code",
    "cognitive science",
    "collaboration",
    "collective",
    "comedy",
    "communication",
    "community",
    "compassion",
    "computers",
    "conducting",
    "consciousness",
    "conservation",
    "consumerism",
    "coral reefs",
    "coronavirus",
    "corruption",
    "creativity",
    "crime",
    "crowdsourcing",
    "cryptocurrency",
    "culture",
    "curiosity",
    "cyber security",
    "dance",
    "dark matter",
    "data",
    "death",
    "decision-making",
    "deextinction",
    "demo",
    "democracy",
    "depression",
    "design",
    "dinosaurs",
    "disability",
    "discovery",
    "disease",
    "diversity",
    "driverless cars",
    "drones",
    "drugs",
    "ebola",
    "ecology",
    "economics",
    "education",
    "electricity",
    "emotions",
    "empathy",
    "encryption",
    "energy",
    "engineering",
    "entertainment",
    "entrepreneur",
    "environment",
    "equality",
    "ethics",
    "evolution",
    "exercise",
    "exploration",
    "family",
    "farming",
    "fashion",
    "fear",
    "feminism",
    "film",
    "finance",
    "fish",
    "flight",
    "food",
    "forensics",
    "fossil fuels",
    "friendship",
    "fungi",
    "future",
    "gaming",
    "gardening",
    "gender",
    "genetics",
    "geology",
    "glaciers",
    "global issues",
    "goals",
    "government",
    "grammar",
    "graphic design",
    "happiness",
    "health",
    "health care",
    "hearing",
    "heart",
    "history",
    "homelessness",
    "human body",
    "human rights",
    "humanity",
    "humor",
    "identity",
    "illness",
    "illusion",
    "immigration",
    "inclusion",
    "india",
    "indigenous peoples",
    "industrial design",
    "infrastructure",
    "innovation",
    "insects",
    "international development",
    "international relations",
    "interview",
    "invention",
    "investing",
    "journalism",
    "justice system",
    "kids",
    "language",
    "law",
    "leadership",
    "library",
    "literature",
    "love",
    "machine learning",
    "magic",
    "manufacturing",
    "maps",
    "marine biology",
    "marketing",
    "math",
    "media",
    "medical imaging",
    "medical research",
    "medicine",
    "meditation",
    "memory",
    "mental health",
    "metaverse",
    "microbes",
    "microbiology",
    "military",
    "mindfulness",
    "money",
    "motivation",
    "museums",
    "music",
    "nanotechnology",
    "natural disaster",
    "natural resources",
    "nature",
    "neurology",
    "neuroscience",
    "nuclear energy",
    "ocean",
    "online privacy",
    "pain",
    "painting",
    "paleontology",
    "pandemic",
    "parenting",
    "performance",
    "personal growth",
    "personality",
    "philanthropy",
    "philosophy",
    "photography",
    "physics",
    "plants",
    "plastic",
    "poetry",
    "policy",
    "politics",
    "pollution",
    "potential",
    "poverty",
    "pregnancy",
    "primates",
    "prison",
    "product design",
    "productivity",
    "prosthetics",
    "protest",
    "psychology",
    "public health",
    "public space",
    "public speaking",
    "quantum",
    "race",
    "refugees",
    "relationships",
    "religion",
    "renewable energy",
    "resources",
    "rivers",
    "robots",
    "rocket science",
    "science",
    "science fiction",
    "self",
    "sex",
    "sexual violence",
    "shopping",
    "sight",
    "sleep",
    "smell",
    "social change",
    "social media",
    "society",
    "sociology",
    "software",
    "solar energy",
    "solar system",
    "sound",
    "space",
    "spoken word",
    "sports",
    "statistics",
    "storytelling",
    "street art",
    "success",
    "suicide",
    "surveillance",
    "sustainability",
    "synthetic biology",
    "teaching",
    "tech",
    "technology",
    "telescopes",
    "television",
    "terrorism",
    "theater",
    "time",
    "toys",
    "transportation",
    "travel",
    "trees",
    "trust",
    "typography",
    "universe",
    "urban planning",
    "veganism",
    "violence",
    "virtual reality",
    "virus",
    "visualizations",
    "vulnerability",
    "war",
    "water",
    "weather",
    "wildlife",
    "wind energy",
    "women",
    "women in business",
    "work",
    "work-life balance",
    "worklife",
    "writing",
    "youth"
  ];
}
