import 'dart:math';

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
  // generates random code based on adjective, noun, and random number between 0 and 9999
  final adjNum = Random().nextInt(adjectives.length);
  final nounNum = Random().nextInt(nouns.length);
  final postfix = Random().nextInt(9999).toString();
  return '${adjectives.elementAt(adjNum.toInt())}-${nouns.elementAt(nounNum.toInt())}-$postfix';
}

String getCampAdj() {
  // returns random adjective from list
  return adjectives.elementAt(Random().nextInt(adjectives.length));
}

String getCampNoun() {
  // returns random noun from list
  return nouns.elementAt(Random().nextInt(nouns.length));
}
