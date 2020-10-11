import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:focial/api/urls.dart';
import 'package:focial/screens/stories/new_story.dart';
import 'package:focial/screens/stories/view_story.dart';
import 'package:focial/services/finder.dart';
import 'package:focial/services/story.dart';
import 'package:focial/services/user.dart';
import 'package:focial/utils/assets.dart';
import 'package:focial/utils/navigation.dart';
import 'package:focial/utils/theme.dart';
import 'package:focial/widgets/services/user_data.dart';
import 'package:stacked/stacked.dart';

class FocialStories extends StatelessWidget {
  void handleCurrentUserStory(BuildContext context, StoryService provider) {
    final currentUser = find<UserData>().currentUser;
    if (provider.storyFeed[currentUser.id] != null) {
      if (provider.storyFeed[currentUser.id].stories.isNotEmpty) {
        debugPrint("show him his stories");
        Navigator.of(context).push(AppNavigation.route(ViewStoriesScreen(story: provider.storyFeed[currentUser.id].stories.toList()[0])));
      }
    } else {
      debugPrint("create new story");
      Navigator.of(context).push(AppNavigation.route(NewStory()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StoryService>.reactive(
      viewModelBuilder: () => find<StoryService>(),
      disposeViewModel: false,
      onModelReady: (m) => {},
      builder: (context, provider, child) {
        final stories = [
          GestureDetector(
            onTap: () => handleCurrentUserStory(context, provider),
            child: const CurrentUserStoryButton(),
          ),
        ];
        return SizedBox(
          height: storySize,
          width: double.infinity,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            children: stories,
          ),
        );
      },
    );
  }
}

const storySize = 60.0;
const avatarPadding = 6.0;
const whiteBackgroundPadding = 4.0;
const stroke = 3.0;

class ViewStoryButton extends StatelessWidget {
  final bool loading, seen, currentUser;
  final double avatarPadding;
  final double whiteBackgroundPadding;
  final String avatar;

  const ViewStoryButton(
      {Key key,
      this.loading = false,
      this.seen = false,
      this.currentUser = false,
      this.avatar = Assets.defaultProfilePicture,
      this.avatarPadding = 5.0,
      this.whiteBackgroundPadding = 3.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 6.0),
      child: Stack(
        children: [
          if (loading)
            const SizedBox(
              height: storySize,
              width: storySize,
              child: Padding(
                padding: EdgeInsets.all(1.7),
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(AppTheme.orange),
                  strokeWidth: stroke,
                ),
              ),
            )
          else
            Material(
              type: MaterialType.circle,
              color: seen ? Colors.black12 : AppTheme.orange,
              child: const SizedBox(
                height: storySize,
                width: storySize,
              ),
            ),
          Positioned(
            top: whiteBackgroundPadding,
            bottom: whiteBackgroundPadding,
            right: whiteBackgroundPadding,
            left: whiteBackgroundPadding,
            child: const Material(
              type: MaterialType.circle,
              color: Colors.white,
              child: SizedBox(
                height: storySize,
                width: storySize,
              ),
            ),
          ),
          Positioned(
            top: avatarPadding,
            bottom: avatarPadding,
            right: avatarPadding,
            left: avatarPadding,
            child: CircleAvatar(
              radius: storySize,
              backgroundColor: Colors.white10,
              backgroundImage: CachedNetworkImageProvider(
                avatar == null
                    ? Assets.defaultProfilePicture
                    : avatar.contains("http")
                        ? avatar
                        : Urls.assetsBase + avatar,
              ),
            ),
          ),
          if (currentUser)
            const Positioned(
              bottom: 0.0,
              right: 0.0,
              child: Material(
                type: MaterialType.circle,
                color: AppTheme.primaryColor,
                child: Padding(
                  padding: EdgeInsets.all(2.0),
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 16.0,
                  ),
                ),
              ),
            )
          else
            const SizedBox()
        ],
      ),
    );
  }
}

class CurrentUserStoryButton extends StatelessWidget {
  final bool loading;

  const CurrentUserStoryButton({this.loading = false});

  @override
  Widget build(BuildContext context) {
    return UserDataWidget(
      builder: (context, model, child) => ViewStoryButton(
        loading: loading,
        currentUser: true,
        avatar: model.currentUser.photoUrl,
      ),
    );
  }
}
