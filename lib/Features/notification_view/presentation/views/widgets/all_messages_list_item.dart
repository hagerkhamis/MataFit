import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/utils/constants.dart';
import '../../../data/models/my_messages_model/datum.dart';

class AllMessagesListItem extends StatelessWidget {
  const AllMessagesListItem({
    super.key,
    required this.messagesList,
    required this.itemIndex,
  });
  final AllMessagesList messagesList;
  final int itemIndex;
  @override
  Widget build(BuildContext context) {
    // var box = Hive.box<EmployeeEntity>(kEmployeeDataBox);

    return Column(
      children: [
        FadeInLeft(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 2.0),
            child: Card(
              shadowColor: Colors.black,
              shape: messagesList![itemIndex].seen == "0"
                  ? RoundedRectangleBorder(
                      side: const BorderSide(
                        color:
                            Color.fromARGB(255, 146, 146, 146), //<-- SEE HERE
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    )
                  : null,
              color: messagesList![itemIndex].seen == "0"
                  ? const Color.fromARGB(255, 245, 241, 241)
                  : Colors.white,
              child: ListTile(
                subtitle: Text(
                  messagesList![itemIndex].message.toString(),
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 10),
                ),
                title: Text(
                  messagesList![itemIndex].subject.toString(),
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 12),
                ),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      messagesList![itemIndex].msgDate!,
                      style: const TextStyle(fontSize: 12),
                    ),
                    Text(
                      messagesList![itemIndex].msgTime!,
                      style: const TextStyle(fontSize: 10),
                    ),
                  ],
                ),
                leading: CircleAvatar(
                  radius: 25,
                  // maxRadius: 25,
                  //minRadius: 25,
                  onBackgroundImageError: (exception, stackTrace) {},
                  backgroundColor: kPrimaryColor.withOpacity(.4),
                  backgroundImage: CachedNetworkImageProvider(
                    (messagesList![itemIndex].fromEmpImg!),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
