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
  'wicked',
  'mystical',
  'sunny',
  'bostonian',
  'agios',
  'hermit',
  'special',
  'welcoming',
  'supportive',
  'loving',
  'inclusive',
  'transformative',
  'blessed',
];

const List<String> nouns = [
  'morning',
  'mbc',
  'staff',
  'community',
  'night',
  'break',
  'time',
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
  'george',
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
];

String generateInviteCode() {
  final adjNum = Random().nextInt(adjectives.length);
  final nounNum = Random().nextInt(nouns.length);
  return '${adjectives.elementAt(adjNum.toInt())}-${nouns.elementAt(nounNum.toInt())}-${adjNum.toString()}-${nounNum.toString()}';
}

int getAdjLength() {
  return adjectives.length;
}

int getNounLength() {
  return nouns.length;
}
