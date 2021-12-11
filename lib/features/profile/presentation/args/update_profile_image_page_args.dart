import 'dart:io';

import 'package:ajb1/features/profile/domin/entities/profile_entity.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class UpdateProfileImagePageArgs {
  final XFile? image;
  final ProfileEntity? profile;

  UpdateProfileImagePageArgs({this.image, this.profile});
}
