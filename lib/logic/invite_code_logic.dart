import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:pocketbase/pocketbase.dart';

const List<String> adjectives = [
  'byzantine',
  'athonite',
  'tooky',
  'christian',
  'holy',
  'silly',
  'goofy',
  'snap',
  'crackle',
  'pop',
  'krispy',
  'jovial',
  'prayerful',
  'devout',
  'peaceful',
  'spiritual',
  'happy',
  'wonderful',
  'mystical',
  'sunny',
  'bostonian',
  'agios',
  'special',
  'welcoming',
  'supportive',
  'loving',
  'inclusive',
  'transformative',
  'blessed',
  'forgiving',
  'hydrated',
  'inspirational',
  'quirky',
  'beloved'
];

const List<String> nouns = [
  'morning',
  'mbc',
  'staff',
  'community',
  'night',
  'break',
  'service',
  'prayer',
  'daylight',
  'orthros',
  'vespers',
  'paraklesis',
  'compline',
  'liturgy',
  'lifeguard',
  'clergy',
  'sermon',
  'session',
  'bishop',
  'saint',
  'frappe',
  'pentozali',
  'halftime',
  'vigil',
  'panagia',
  'chanting',
  'olympics',
  'campfire',
  'porch',
  'bible',
  'mountain',
  'bouzouki',
  'deacon',
  'staff',
  'seminarian',
  'cabin',
  'icon',
  'monastery',
  'masterpiece',
  'camper',
  'hospitality',
  'devo',
  'soundingboard',
];

String generateInviteCode() {
  // generates random code
  final adjNum =
      Random().nextInt(adjectives.length); // random index of adjectives list
  final nounNum = Random().nextInt(nouns.length); // random index of nouns list
  final postfix = Random().nextInt(9999).toString(); // random number 0-9999
  return '${adjectives.elementAt(adjNum.toInt())}-${nouns.elementAt(nounNum.toInt())}-$postfix';
}

void allocateInviteCodes(String userId, PocketBase pb) async {
  for (int i = 0; i < 4; i++) {
    // generate 4 invite codes and upload them to the server
    final inviteCode = <String, dynamic>{
      "creator": userId,
      "code": "test",
      "used": false
    };
    // upload invite code
    try {
      final record =
          await pb.collection('invite_codes').create(body: inviteCode);
      debugPrint("Successfully generated and uploaded invite code?");
      debugPrint(record.toString());
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}

Future<bool> verifyInviteCode(String code, PocketBase pb) async {
  // returns true if code is valid
  final record = await pb.collection('invite_codes').getFirstListItem(
        'invite_code=$code',
        expand: 'used',
      );
  debugPrint(record.toString());
  return false;
}

String getCampAdj() {
  // returns random adjective from list
  return adjectives.elementAt(Random().nextInt(adjectives.length));
}

String getCampNoun() {
  // returns random noun from list
  return nouns.elementAt(Random().nextInt(nouns.length));
}
