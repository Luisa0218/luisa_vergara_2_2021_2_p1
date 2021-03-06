class Elephant {
  String sId = '';
  int index = 0;
  String name = '';
  String affiliation = '';
  String species = '';
  String sex = '';
  String fictional = '';
  String dob = '';
  String dod = '';
  String wikilink = '';
  String image = '';
  String note = '';

  Elephant(
      {required this.sId,
      required this.index,
      required this.name,
      required this.affiliation,
      required this.species,
      required this.sex,
      required this.fictional,
      required this.dob,
      required this.dod,
      required this.wikilink,
      required this.image,
      required this.note});

  Elephant.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    index = json['index'];
    name = json['name'];
    affiliation = json['affiliation'];
    species = json['species'];
    sex = json['sex'];
    fictional = json['fictional'];
    dob = json['dob'];
    dod = json['dod'];
    wikilink = json['wikilink'];
    image = json['image'];
    note = json['note'];
  }

  Map<String, dynamic> toJson() {
    // ignore: prefer_collection_literals, unnecessary_new
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = sId;
    data['index'] = index;
    data['name'] = name;
    data['affiliation'] = affiliation;
    data['species'] = species;
    data['sex'] = sex;
    data['fictional'] = fictional;
    data['dob'] = dob;
    data['dod'] = dod;
    data['wikilink'] = wikilink;
    data['image'] = image;
    // ignore: unnecessary_this
    data['note'] = this.note;
    return data;
  }
}
