import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:night_break/auth/signup_page.dart';
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

// returns true if code is unused
Future<bool> verifyInviteCode(String code, PocketBase pb) async {
  // check the invite code database for the user's entered code
  try {
    final record = await pb
        .collection('invite_codes')
        .getFirstListItem('invite_code="$code"', fields: 'invite_code,used');
    // if one is returned, it means the code is valid
    final bool used = record.getBoolValue('used');
    if (used == true) {
      debugPrint('code has already been used!');
      return false;
    } else {
      debugPrint("valid code!");
      return true;
    }
  } catch (e) {
    // if the invite code doesn't exist, return false
    debugPrint('there\'s no invite code by that name!');
    return false;
  }
}

Future<String> getInvitedById(String code, PocketBase pb) async {
  try {
    final record = await pb.collection('invite_codes').getFirstListItem(
          'invite_code="$code"',
        );
    return record.getStringValue('creator');
  } catch (e) {
    debugPrint(e.toString());
    return 'NAH FAM';
  }
}

void useInviteCode(String code, PocketBase pb) async {
  try {
    final record = await pb.collection('invite_codes').getFirstListItem(
          'invite_code="$code"',
        );

    final usedBody = <String, dynamic>{
      "creator": record.getDataValue('creator'),
      "invite_code": record.getStringValue('invite_code'),
      "used": true
    };

    await pb.collection('invite_codes').update(record.id, body: usedBody);
    debugPrint('marked code $code as used');
  } catch (e) {
    debugPrint(e.toString());
  }
}

String getCampAdj() {
  // returns random adjective from list
  return adjectives.elementAt(Random().nextInt(adjectives.length));
}

String getCampNoun() {
  // returns random noun from list
  return nouns.elementAt(Random().nextInt(nouns.length));
}
