import 'package:flutter/cupertino.dart';
import 'package:ouds_flutter_demo/ui/components/tag/tag_customization.dart';

///
/// The InputTagCodeGenerator class is responsible for dynamically generating Flutter
/// code for the customization of a tag input component. It leverages the tag's
/// customization state (such as label text) and
/// generates the corresponding code in string format, which can be used for
/// rendering or previewing the tag with the selected properties.
///
class InputTagCodeGenerator {
  // Static method to generate the code based on tag customization state
  static String updateCode(BuildContext context) {
    // Fetch the current tag customization state from context
    final TagCustomizationState? customizationState = TagCustomization.of(context);

    // Get the text value for the tag from customization state
    String label = customizationState?.labelText ?? "Label";

    return  """OudsInputTag(\nlabel: "$label",\nonPressed: ${customizationState?.hasEnabled == true ? "() {}" : 'null'},\n);""";
    }

}
