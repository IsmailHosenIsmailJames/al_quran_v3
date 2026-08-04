import "package:flutter/material.dart";
import "../../domain/entities/tajweed_rule_entity.dart";
import "tajweed_tagged_text.dart";

class TajweedRuleCard extends StatelessWidget {
  final TajweedRuleEntity rule;
  final bool isInitiallyExpanded;

  const TajweedRuleCard({
    super.key,
    required this.rule,
    this.isInitiallyExpanded = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isLight = theme.brightness == Brightness.light;
    final ruleColor = isLight ? rule.lightColor : rule.darkColor;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      clipBehavior: Clip.antiAlias,
      child: ExpansionTile(
        initiallyExpanded: isInitiallyExpanded,
        tilePadding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 8.0,
        ),
        childrenPadding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
        leading: Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: ruleColor.withAlpha((0.15 * 255).round()),
            shape: BoxShape.circle,
            border: Border.all(color: ruleColor, width: 2.0),
          ),
          child: Center(
            child: Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                color: ruleColor,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                rule.name,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: ruleColor.withAlpha((0.1 * 255).round()),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                rule.arabicName,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontFamily: "QPC_Hafs",
                  fontWeight: FontWeight.bold,
                  color: ruleColor,
                ),
              ),
            ),
          ],
        ),
        children: [
          const Divider(height: 24),
          // Description
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              rule.description,
              style: theme.textTheme.bodyMedium?.copyWith(height: 1.5),
            ),
          ),
          const SizedBox(height: 12),

          // How to pronounce section
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerHighest.withAlpha(
                (0.5 * 255).round(),
              ),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: theme.colorScheme.outline.withAlpha((0.2 * 255).round()),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.record_voice_over_rounded,
                  size: 20,
                  color: ruleColor,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "How to Pronounce:",
                        style: theme.textTheme.labelMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: ruleColor,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        rule.howToPronounce,
                        style: theme.textTheme.bodySmall?.copyWith(height: 1.4),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Examples Header
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Quranic Examples:",
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.primary,
              ),
            ),
          ),
          const SizedBox(height: 8),

          // Examples List
          Column(
            children: rule.examples.map((example) {
              return Container(
                margin: const EdgeInsets.only(bottom: 10.0),
                padding: const EdgeInsets.all(12.0),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(
                    color: ruleColor.withAlpha((0.3 * 255).round()),
                    width: 1.0,
                  ),
                ),
                child: Column(
                  children: [
                    // Rendered Quranic Arabic text with exact letter-level Tajweed colors
                    TajweedTaggedText(
                      taggedText: example.arabicText,
                      style: const TextStyle(fontSize: 26, height: 1.8),
                    ),
                    if (example.surahAyahRef != null) ...[
                      const SizedBox(height: 6),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          example.surahAyahRef!,
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: theme.colorScheme.outline,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
