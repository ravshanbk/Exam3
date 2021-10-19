

class Phrase{
  Phrase({this.joke,});
  String? joke; 
  factory Phrase.fromJson(Map json) => Phrase(joke:json["joke"],);
  Map toJson()=> {"joke":joke,};
}