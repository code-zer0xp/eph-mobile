import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../utils/constants/app_colors.dart';
import '../../utils/styles/app_text_styles.dart';

/// Enhanced listing card widget with v2 features
/// Supports preview mode (compact) and expanded mode (detailed)
class ListingCardV2 extends StatefulWidget {
  final String name;
  final String location;
  final String city;
  final String province;
  final String imageUrl;
  final String? priceRange;
  final String? highlight;
  final double? rating;
  final int? reviews;
  final List<String> hashtags;
  final bool isBookmarked;
  final bool showExpandedDetails;
  final VoidCallback? onTap;
  final VoidCallback? onBookmark;
  final VoidCallback? onShare;
  final VoidCallback? onAddToItinerary;
  final VoidCallback? onAddToBucketList;
  final VoidCallback? onViewDetails;

  const ListingCardV2({
    super.key,
    required this.name,
    required this.location,
    this.city = '',
    this.province = '',
    required this.imageUrl,
    this.priceRange,
    this.highlight,
    this.rating,
    this.reviews,
    this.hashtags = const [],
    this.isBookmarked = false,
    this.showExpandedDetails = false,
    this.onTap,
    this.onBookmark,
    this.onShare,
    this.onAddToItinerary,
    this.onAddToBucketList,
    this.onViewDetails,
  });

  @override
  State<ListingCardV2> createState() => _ListingCardV2State();
}

class _ListingCardV2State extends State<ListingCardV2> {
  bool _isHovered = false;
  bool _isBookmarked = false;

  @override
  void initState() {
    super.initState();
    _isBookmarked = widget.isBookmarked;
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap ?? () => _showDetailBottomSheet(context),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(_isHovered ? 0.15 : 0.08),
                blurRadius: _isHovered ? 16 : 10,
                offset: Offset(0, _isHovered ? 6 : 3),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image section with overlays
                _buildImageSection(),
                // Content section
                _buildContentSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImageSection() {
    return Stack(
      children: [
        // Main image
        AspectRatio(
          aspectRatio: 16 / 10,
          child: Image.network(
            widget.imageUrl,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(
              color: AppColors.lightGrey,
              child: const Center(
                child: FaIcon(FontAwesomeIcons.image,
                    color: Colors.grey, size: 32),
              ),
            ),
          ),
        ),
        // Gradient overlay
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.4),
                ],
                stops: const [0.5, 1.0],
              ),
            ),
          ),
        ),
        // Bookmark button
        Positioned(
          top: 8,
          right: 8,
          child: Tooltip(
            message: _isBookmarked ? 'Remove from saved' : 'Save',
            child: GestureDetector(
              onTap: () {
                setState(() => _isBookmarked = !_isBookmarked);
                widget.onBookmark?.call();
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: FaIcon(
                  _isBookmarked
                      ? FontAwesomeIcons.solidBookmark
                      : FontAwesomeIcons.bookmark,
                  size: 14,
                  color: _isBookmarked ? AppColors.primary : AppColors.grey,
                ),
              ),
            ),
          ),
        ),
        // Price badge
        if (widget.priceRange != null)
          Positioned(
            top: 8,
            left: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                widget.priceRange!,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        // Location overlay at bottom
        Positioned(
          bottom: 8,
          left: 8,
          right: 8,
          child: Row(
            children: [
              const FaIcon(FontAwesomeIcons.locationDot,
                  color: Colors.white, size: 10),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  widget.location.isNotEmpty
                      ? widget.location
                      : '${widget.city}, ${widget.province}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    shadows: [
                      Shadow(blurRadius: 4, color: Colors.black45),
                    ],
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildContentSection() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Name
          Text(
            widget.name,
            style: AppTextStyles.bodyText1.copyWith(
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          // Highlight if available
          if (widget.highlight != null) ...[
            const SizedBox(height: 4),
            Text(
              widget.highlight!,
              style: AppTextStyles.caption.copyWith(
                color: AppColors.textSecondary,
                fontStyle: FontStyle.italic,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
          // Rating row
          if (widget.rating != null) ...[
            const SizedBox(height: 6),
            Row(
              children: [
                const FaIcon(FontAwesomeIcons.solidStar,
                    color: Colors.amber, size: 12),
                const SizedBox(width: 4),
                Text(
                  widget.rating!.toStringAsFixed(1),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
                if (widget.reviews != null) ...[
                  const SizedBox(width: 4),
                  Text(
                    '(${widget.reviews} reviews)',
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ],
            ),
          ],
          // Hashtags (shown on hover or expanded)
          if ((_isHovered || widget.showExpandedDetails) &&
              widget.hashtags.isNotEmpty) ...[
            const SizedBox(height: 8),
            Wrap(
              spacing: 4,
              runSpacing: 4,
              children: widget.hashtags.take(3).map((tag) {
                return Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '#$tag',
                    style: TextStyle(
                      fontSize: 10,
                      color: AppColors.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
          // Action buttons (shown on hover or expanded)
          if (_isHovered || widget.showExpandedDetails) ...[
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: _buildActionButton(
                    icon: FontAwesomeIcons.route,
                    label: 'Itinerary',
                    onTap: widget.onAddToItinerary,
                    tooltip: 'Add to Itinerary',
                  ),
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: _buildActionButton(
                    icon: FontAwesomeIcons.listCheck,
                    label: 'Bucket List',
                    onTap: widget.onAddToBucketList,
                    tooltip: 'Add to Bucket List',
                  ),
                ),
                const SizedBox(width: 6),
                _buildIconButton(
                  icon: FontAwesomeIcons.shareNodes,
                  onTap: widget.onShare,
                  tooltip: 'Share',
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    VoidCallback? onTap,
    String? tooltip,
  }) {
    return Tooltip(
      message: tooltip ?? label,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FaIcon(icon, size: 10, color: AppColors.primary),
              const SizedBox(width: 4),
              Text(
                label,
                style: TextStyle(
                  fontSize: 9,
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIconButton({
    required IconData icon,
    VoidCallback? onTap,
    String? tooltip,
  }) {
    return Tooltip(
      message: tooltip ?? '',
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.lightGrey.withOpacity(0.5),
            borderRadius: BorderRadius.circular(8),
          ),
          child: FaIcon(icon, size: 12, color: AppColors.textSecondary),
        ),
      ),
    );
  }

  void _showDetailBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.85,
        maxChildSize: 0.95,
        minChildSize: 0.5,
        builder: (context, scrollController) => Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            children: [
              // Handle bar
              Container(
                margin: const EdgeInsets.only(top: 12, bottom: 8),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.lightGrey,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              // Content
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Hero image
                      Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            child: AspectRatio(
                              aspectRatio: 16 / 9,
                              child: Image.network(
                                widget.imageUrl,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    Container(
                                  color: AppColors.lightGrey,
                                  child: const Center(
                                    child: FaIcon(FontAwesomeIcons.image,
                                        color: Colors.grey, size: 48),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // Price badge
                          if (widget.priceRange != null)
                            Positioned(
                              bottom: 16,
                              left: 16,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                child: Text(
                                  widget.priceRange!,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          // Bookmark
                          Positioned(
                            top: 16,
                            right: 16,
                            child: GestureDetector(
                              onTap: () {
                                setState(() => _isBookmarked = !_isBookmarked);
                                widget.onBookmark?.call();
                                Navigator.pop(context);
                              },
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 8,
                                    ),
                                  ],
                                ),
                                child: FaIcon(
                                  _isBookmarked
                                      ? FontAwesomeIcons.solidBookmark
                                      : FontAwesomeIcons.bookmark,
                                  size: 18,
                                  color: _isBookmarked
                                      ? AppColors.primary
                                      : AppColors.grey,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      // Details
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Name
                            Text(
                              widget.name,
                              style: AppTextStyles.headline3.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            // Location
                            Row(
                              children: [
                                FaIcon(FontAwesomeIcons.locationDot,
                                    size: 14, color: AppColors.textSecondary),
                                const SizedBox(width: 6),
                                Expanded(
                                  child: Text(
                                    widget.location.isNotEmpty
                                        ? widget.location
                                        : '${widget.city}, ${widget.province}',
                                    style: AppTextStyles.bodyText2.copyWith(
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            // Highlight
                            if (widget.highlight != null) ...[
                              const SizedBox(height: 12),
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: AppColors.primary.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  children: [
                                    FaIcon(FontAwesomeIcons.lightbulb,
                                        size: 16, color: AppColors.primary),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Text(
                                        widget.highlight!,
                                        style: TextStyle(
                                          color: AppColors.primary,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                            // Rating
                            if (widget.rating != null) ...[
                              const SizedBox(height: 16),
                              Row(
                                children: [
                                  ...List.generate(5, (index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(right: 2),
                                      child: FaIcon(
                                        index < widget.rating!.floor()
                                            ? FontAwesomeIcons.solidStar
                                            : FontAwesomeIcons.star,
                                        size: 16,
                                        color: Colors.amber,
                                      ),
                                    );
                                  }),
                                  const SizedBox(width: 8),
                                  Text(
                                    widget.rating!.toStringAsFixed(1),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  if (widget.reviews != null) ...[
                                    const SizedBox(width: 8),
                                    Text(
                                      '(${widget.reviews} reviews)',
                                      style: AppTextStyles.bodyText2.copyWith(
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ],
                            // Hashtags
                            if (widget.hashtags.isNotEmpty) ...[
                              const SizedBox(height: 16),
                              Text(
                                'Tags',
                                style: AppTextStyles.bodyText1.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: widget.hashtags.map((tag) {
                                  return Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 6),
                                    decoration: BoxDecoration(
                                      color: AppColors.primary.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Text(
                                      '#$tag',
                                      style: TextStyle(
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ],
                            const SizedBox(height: 24),
                            // Action buttons
                            Row(
                              children: [
                                Expanded(
                                  child: _buildDetailActionButton(
                                    icon: FontAwesomeIcons.route,
                                    label: 'Add to Itinerary',
                                    onTap: () {
                                      widget.onAddToItinerary?.call();
                                      Navigator.pop(context);
                                      _showAddedSnackBar(context, 'Itinerary');
                                    },
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: _buildDetailActionButton(
                                    icon: FontAwesomeIcons.listCheck,
                                    label: 'Add to Bucket List',
                                    onTap: () {
                                      widget.onAddToBucketList?.call();
                                      Navigator.pop(context);
                                      _showAddedSnackBar(
                                          context, 'Bucket List');
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                Expanded(
                                  child: _buildDetailActionButton(
                                    icon: FontAwesomeIcons.eye,
                                    label: 'View Details',
                                    isPrimary: true,
                                    onTap: () {
                                      widget.onViewDetails?.call();
                                    },
                                  ),
                                ),
                                const SizedBox(width: 12),
                                _buildDetailIconButton(
                                  icon: FontAwesomeIcons.shareNodes,
                                  onTap: () {
                                    widget.onShare?.call();
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailActionButton({
    required IconData icon,
    required String label,
    bool isPrimary = false,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: isPrimary
              ? AppColors.primary
              : AppColors.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FaIcon(icon,
                size: 14, color: isPrimary ? Colors.white : AppColors.primary),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                label,
                style: TextStyle(
                  color: isPrimary ? Colors.white : AppColors.primary,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailIconButton({
    required IconData icon,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.lightGrey.withOpacity(0.5),
          borderRadius: BorderRadius.circular(12),
        ),
        child: FaIcon(icon, size: 18, color: AppColors.textSecondary),
      ),
    );
  }

  void _showAddedSnackBar(BuildContext context, String listName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const FaIcon(FontAwesomeIcons.circleCheck,
                color: Colors.white, size: 16),
            const SizedBox(width: 10),
            Text('Added to $listName'),
          ],
        ),
        backgroundColor: AppColors.success,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
