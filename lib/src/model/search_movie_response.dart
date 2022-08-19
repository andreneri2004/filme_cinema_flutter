
import 'dart:convert';
import 'package:filme_info/src/model/model.dart';

class SearchMoveResponse {
    SearchMoveResponse({
       required this.page,
       required this.results,
       required this.totalPages,
       required this.totalResults,
    });

    int page;
    List<Movie> results;
    int totalPages;
    int totalResults;

    factory SearchMoveResponse.fromJson(String str) => SearchMoveResponse.fromMap(json.decode(str));
    
    factory SearchMoveResponse.fromMap(Map<String, dynamic> json) => SearchMoveResponse(
        page: json["page"],
        results: List<Movie>.from(json["results"].map((x) => Movie.fromMap(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
    );
}
