part of utils;

const Color _guidePrimary = Color(0xFF6200EE);
const Color _guidePrimaryVariant = Color(0xFF3700B3);
const Color _guideSecondary = Color(0xFF03DAC6);
const Color _guideSecondaryVariant = Color(0xFF018786);
const Color _guideError = Color(0xFFB00020);
const Color _guideErrorDark = Color(0xFFCF6679);
const Color _blueBlues = Color(0xFF174378);

// Make a custom ColorSwatch to name map from the above custom colors.
final colorsNameMap = {
  ColorTools.createPrimarySwatch(_guidePrimary): 'Guide Purple',
  ColorTools.createPrimarySwatch(_guidePrimaryVariant): 'Guide Purple Variant',
  ColorTools.createAccentSwatch(_guideSecondary): 'Guide Teal',
  ColorTools.createAccentSwatch(_guideSecondaryVariant): 'Guide Teal Variant',
  ColorTools.createPrimarySwatch(_guideError): 'Guide Error',
  ColorTools.createPrimarySwatch(_guideErrorDark): 'Guide Error Dark',
  ColorTools.createPrimarySwatch(_blueBlues): 'Blue blues',
};
