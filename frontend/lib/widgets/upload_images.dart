import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';

final formKey = GlobalKey<FormState>();
TextEditingController nameController = TextEditingController();
TextEditingController descriptionController = TextEditingController();

// ignore: must_be_immutable
class SelectImage extends StatelessWidget {
  SelectImage({
    super.key,
    this.imageUrl,
    required this.onImageSelected,
  });

  File? image;
  Uint8List? bytes;
  String? imageUrl;
  final Function(Uint8List? image) onImageSelected;
  RxBool changeImage = false.obs;
  RxBool haveImage = false.obs;
  RxString imagePreview = ''.obs;

  Rx<String?> url = null.obs;

  @override
  Widget build(BuildContext context) {
    url = imageUrl.obs;
    if (url.value != null) {
      haveImage.value = true;
      imagePreview.value = url.value!;
    }
    return Obx(
      () => Container(
        width: 400,
        height: 400,
        decoration: BoxDecoration(
          border: haveImage.value ? null : Border.all(color: Colors.blue),
          borderRadius: BorderRadius.circular(10),
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 1100),
          child: haveImage.value
              ? MouseRegion(
                  onEnter: (event) {
                    changeImage.value = true;
                  },
                  onExit: (event) {
                    changeImage.value = false;
                  },
                  child: Stack(
                    children: [
                      Center(
                        child: Image.network(
                          imagePreview.value,
                          width: 400,
                          height: 400,
                          fit: BoxFit.cover,
                        ),
                      ),
                      if (changeImage.value)
                        Positioned(
                          child: Center(
                            child: TextButton(
                              onPressed: () async {
                                bytes = await pickAndCropImage(context);
                              },
                              style: TextButton.styleFrom(
                                backgroundColor: const Color(0xFF91D97E),
                              ),
                              child: const Text(
                                'Click aquí para cambiar la imagen',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                )
              : Center(
                  child: TextButton(
                    onPressed: () async {
                      bytes = await pickAndCropImage(context);
                    },
                    child: const Text(
                      'Click aquí para subir una imagen',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  Future<Uint8List?> pickAndCropImage(BuildContext context) async {
    final picker = ImagePicker();
    double screenWidth = MediaQuery.of(context).size.width;
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile == null) {
        return null;
      }

      final croppedFile = await ImageCropper()
          .cropImage(sourcePath: pickedFile.path, aspectRatioPresets: [
        CropAspectRatioPreset.square,
      ], uiSettings: [
        // ignore: use_build_context_synchronously
        WebUiSettings(
          customClass: 'croppie',
          context: context,
          presentStyle: CropperPresentStyle.dialog,
          translations: const WebTranslations(
              title: 'Recortar imagen',
              rotateLeftTooltip: 'Rotar a la izquierda',
              rotateRightTooltip: 'Rotar a la derecha',
              cancelButton: 'Cancelar',
              cropButton: 'Cortar'),
          boundary: CroppieBoundary(
            width: screenWidth < 740 ? 280 : 420,
            height: screenWidth < 740 ? 280 : 420,
          ),
          viewPort: CroppieViewPort(
            width: screenWidth < 740 ? 260 : 400,
            height: screenWidth < 740 ? 260 : 400,
            type: 'square',
          ),
          enableOrientation: true,
          enableExif: true,
          enableZoom: true,
          showZoomer: true,
        )
      ]);

      if (croppedFile != null) {
        image = File(croppedFile.path);
        imagePreview.value = image!.path;
        haveImage.value = true;
        bytes = await croppedFile.readAsBytes();
        onImageSelected(bytes);
      }
      return null;
    } catch (error) {
      throw Exception('Error al seleccionar/recortar imagen: $error');
    }
  }
}
