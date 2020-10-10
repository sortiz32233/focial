import 'package:focial/models/story_view.dart';
import 'package:json_annotation/json_annotation.dart';

part 'story.g.dart';

enum StoryType { text }

// AuthorData authorData;

@JsonSerializable(nullable: false)
class Story {
  String storyId;
  String text;
  int gradient;
  int textStyle;
  String colorHex;
  List<StoryView> views;

  Story({
    this.text,
    this.gradient = 0,
    this.textStyle = 0,
    this.colorHex,
    this.views,
  });

  factory Story.fromJson(Map<String, dynamic> json) => _$StoryFromJson(json);

  Map<String, dynamic> toJson() => _$StoryToJson(this);

  static List<Story> listFromJSON(dynamic jsonList) {
    final List<Story> stories = [];
    for (final c in jsonList) {
      stories.add(Story.fromJson(c as Map<String, dynamic>));
    }
    return stories;
  }

  @override
  String toString() {
    return 'Story{content: $text, gradient: $gradient, textStyle: $textStyle, whiteText: $colorHex}';
  }
}
