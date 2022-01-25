import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:spendtrkr/app/data/models/transaction_model.dart';
import 'package:get/get.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter_native_contact_picker/flutter_native_contact_picker.dart';
import 'package:spendtrkr/app/data/services/auth.dart';
import 'package:open_location_picker/open_location_picker.dart';

class TransactionUI extends StatelessWidget {
  final _auth = Get.find<AuthController>();

  final String? id;
  final String? ownerId;
  final RxString title;
  final RxDouble amount;
  final Rx<DateTime> date;
  final RxString contact;
  final RxBool isCompleted;
  final Function(TransactionModel) onDelete;
  final RxString photoUrl;
  final Rx<String?> location;

  TransactionUI({
    Key? key,
    TransactionModel? transaction,
    required this.onDelete,
  })  : id = transaction?.id,
        ownerId = transaction?.ownerId,
        title = (transaction?.title ?? '').obs,
        amount = (transaction?.amount ?? 0.0).obs,
        date = (transaction?.date ?? DateTime.now()).obs,
        contact = (transaction?.contact ?? '').obs,
        isCompleted = (transaction?.isCompleted ?? false).obs,
        photoUrl = (transaction?.photoUrl ?? '').obs,
        location = (transaction?.location ?? '').obs,
        super(key: key);

  TransactionModel createModel() {
    return TransactionModel(
      id: id,
      ownerId: ownerId ?? _auth.user!.uid,
      title: title.value,
      amount: amount.value,
      date: date.value,
      contact: contact.value,
      isCompleted: isCompleted.value,
      location: location.value,
    );
  }

  @override
  Widget build(BuildContext context) {
    // create form for editing transaction
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.save),
            onPressed: () => Get.back(result: createModel()),
          ),
          title: Text('transaction.title'.tr),
          shadowColor: Colors.transparent,
          actions: [
            id != null
                ? IconButton(
                    onPressed: () {
                      onDelete(createModel());
                      Get.back();
                    },
                    icon: const Icon(Icons.delete),
                  )
                : const SizedBox.shrink(),
          ],
        ),
        resizeToAvoidBottomInset: false,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue[800],
          onPressed: () => isCompleted.toggle(),
          child: isCompleted.value
              ? const Icon(Icons.check_box, color: Colors.white)
              : const Icon(Icons.check_box_outline_blank, color: Colors.white),
        ),
        body: SafeArea(
          child: Form(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(bottom: 16),
                    color: context.theme.cardColor,
                    child: TextFormField(
                      onChanged: (x) {
                        title.value = x;
                      },
                      initialValue: title.value,
                      style: context.theme.textTheme.headline5!
                          .copyWith(backgroundColor: context.theme.cardColor),
                      decoration: InputDecoration(
                        hintText: 'transaction.title-hint'.tr,
                        border: InputBorder.none,
                        labelText: 'transaction.title-label'.tr,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 16),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      const SizedBox(height: 25),
                      TextFormField(
                        onChanged: (x) {
                          try {
                            amount.value = double.parse(x);
                          } catch (_) {}
                        },
                        initialValue: (amount.value.toInt() == amount.value
                                ? amount.toInt()
                                : amount)
                            .toString(),
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                        ],
                        decoration: InputDecoration(
                          hintText: 'transaction.amount-hint'.tr,
                          border: const OutlineInputBorder(),
                          labelText: 'transaction.amount'.tr,
                          contentPadding: const EdgeInsets.all(24),
                          prefixIcon: const Icon(Icons.attach_money),
                        ),
                      ),
                      const SizedBox(height: 16),
                      DateTimeFormField(
                        initialDate: date.value,
                        onSaved: (x) {
                          if (x != null) {
                            date.value = x;
                          }
                        },
                        decoration: InputDecoration(
                          hintStyle: const TextStyle(color: Colors.black45),
                          errorStyle: const TextStyle(color: Colors.redAccent),
                          border: const OutlineInputBorder(),
                          contentPadding: const EdgeInsets.all(34),
                          prefixIcon: const Icon(Icons.event_note),
                          labelText: 'transaction.pick-time'.tr,
                        ),
                        mode: DateTimeFieldPickerMode.date,
                        autovalidateMode: AutovalidateMode.always,
                        onDateSelected: (DateTime value) {
                          date.value = value;
                        },
                      ),
                      const SizedBox(height: 16),
                      OpenMapPicker(
                        expands: false,
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(24),
                            labelText: location.value != null &&
                                    location.value!.isNotEmpty
                                ? location.value
                                : 'transaction.pick-location'.tr,
                            hintText: 'transaction.pick-location'.tr,
                            border: const OutlineInputBorder()),
                        onChanged: (FormattedLocation? newValue) {
                          if (newValue != null) {
                            location.value = newValue.displayName;
                          }
                        },
                      ),
                      const SizedBox(height: 16),
                      TextButton(
                        onPressed: () async {
                          debugPrint('tap');
                          final FlutterContactPicker _contactPicker =
                              FlutterContactPicker();
                          Contact? _contact =
                              await _contactPicker.selectContact();

                          if (_contact != null) {
                            if (_contact.phoneNumbers != null) {
                              if (_contact.phoneNumbers!.isNotEmpty) {
                                contact.value =
                                    ((_contact.fullName ?? '') + ' ') +
                                        _contact.phoneNumbers!.first;
                              }
                            }
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Icon(Icons.contacts),
                            Text(
                              contact.value.isEmpty
                                  ? 'transaction.select-contact'.tr
                                  : contact.value,
                              style: context.theme.textTheme.headline5!,
                            ),
                            const SizedBox.shrink(),
                          ],
                        ),
                        /* decoration: const InputDecoration(
                        hintText: 'Pick location',
                        border: OutlineInputBorder(),
                        labelText: 'location',
                        contentPadding: EdgeInsets.all(24),
                        prefixIcon: Icon(Icons.pin_drop),
                      ), */
                      ),
                      const SizedBox(height: 16),
                      TextButton(
                        onPressed: () async {
                          final ImagePicker _imagePicker = ImagePicker();
                          XFile? _file = await _imagePicker.pickImage(
                            source: ImageSource.gallery,
                          );
                          if (_file != null) {
                            final bytes = await _file.readAsBytes();
                            final img = await FirebaseStorage.instance
                                .ref('transactions/$ownerId')
                                .child(DateTime.now().hashCode.toString())
                                .putData(bytes);
                            photoUrl.value = await img.ref.getDownloadURL();
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Icon(Icons.camera_alt),
                            Text(
                              'transaction.select-camera'.tr,
                              style: context.theme.textTheme.headline5!,
                            ),
                            const SizedBox.shrink(),
                          ],
                        ),
                        /* decoration: const InputDecoration(
                        hintText: 'Pick location',
                        border: OutlineInputBorder(),
                        labelText: 'location',
                        contentPadding: EdgeInsets.all(24),
                        prefixIcon: Icon(Icons.pin_drop),
                      ), */
                      ),
                      const SizedBox(height: 16),
                      photoUrl.value.isNotEmpty
                          ? Image.network(
                              photoUrl.value,
                              fit: BoxFit.cover,
                            )
                          : const SizedBox.shrink(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
