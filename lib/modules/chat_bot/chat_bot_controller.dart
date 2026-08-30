import 'dart:io';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:project_2/modules/chat_bot/chat_message.dart';
import 'package:project_2/modules/chat_bot/services/chat_helper_service.dart';
import 'package:project_2/modules/chat_bot/services/chat_session_service.dart';
import 'package:project_2/modules/chat_bot/services/chat_ui_service.dart';
import 'chat_bot_screen.dart';
import 'services/chat_storage_service.dart';
import 'services/chat_message_service.dart';
import 'services/chat_selection_service.dart';
import 'services/chat_action_service.dart';
import 'services/chat_upload_service.dart';
part 'chat_controller_storage.dart';
part 'chat_controller_messages.dart';
part 'chat_controller_selection.dart';
part 'chat_controller_actions.dart';
part 'chat_controller_upload.dart';
part 'chat_controller_misc.dart';

class ChatController extends GetxController {
  RxBool showMessage = true.obs;

  RxList<ChatMessage> messages = <ChatMessage>[].obs;

  RxString selectedFileName = ''.obs;

  File? selectedFile;

  RxnInt sessionId = RxnInt();

  RxnInt actionId = RxnInt();

  RxString uploadToken = ''.obs;

  RxList<String> allowedExtensions = <String>[].obs;

  RxBool isTyping = false.obs;

  bool hasInteracted = false;

  bool shouldScrollToBottom = true;

  final GetStorage box = GetStorage();

  late final ChatStorageService storage;

  final ChatMessageService messageService = ChatMessageService();

  final ChatSelectionService selectionService = ChatSelectionService();

  final ChatActionService actionService = ChatActionService();

  final ChatUploadService uploadService = ChatUploadService();

  final ChatSessionService sessionService = ChatSessionService();

  final ChatUiService uiService = ChatUiService();

  final ChatHelperService helperService = ChatHelperService();

  String? get userId {
    final id = box.read('user_id');
    return id?.toString();
  }

  @override
  void onInit() {
    super.onInit();

    storage = ChatStorageService();

    loadSavedChat();
  }
}
