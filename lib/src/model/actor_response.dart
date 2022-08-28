
import 'dart:convert';

class AtorResponse {
    AtorResponse({
       required this.biography,
       required this.id,
       required this.name,
      this.profilePath,
    });

    String biography;
    int id;
    String name;
    String? profilePath;

    get fullprofilePathImg {
    return (profilePath != null)
        ? 'https://image.tmdb.org/t/p/w500${profilePath}'
        : 'http://casadascapotas.com/images/sem_foto.png';
  }


    factory AtorResponse.fromJson(String str) => AtorResponse.fromMap(json.decode(str));

    factory AtorResponse.fromMap(Map<String, dynamic> json) => AtorResponse(
       
        biography: json["biography"],
        id: json["id"],
        name: json["name"],
        profilePath: json["profile_path"],
    );

    @override
    String toString(){
      return "AtorResponse(id: $id, name: $name, biography: $biography, profilePath: $profilePath )" ;
    }
}
