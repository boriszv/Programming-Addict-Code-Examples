import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FilterResult {
  final double minRating;
  final double maxRating;
  final String sortBy;
  final bool desc;

  FilterResult({
    this.minRating,
    this.maxRating,
    this.sortBy,
    this.desc,
  });
}

class Filter extends StatefulWidget {

  final double minRating;
  final double maxRating;
  final String sortBy;
  final bool desc;

  Filter({this.minRating, this.maxRating, this.sortBy, this.desc});

  @override
  _FilterState createState() => _FilterState();
}

class _FilterState extends State<Filter> {

  final minRatingController = TextEditingController();
  final maxRatingController = TextEditingController();

  String sortBy;
  bool desc = false;

  @override
  void initState() {
    super.initState();
    if (widget.minRating != null) {
      minRatingController.text = widget.minRating.toInt().toString();
    }
    if (widget.minRating != null) {
      maxRatingController.text = widget.maxRating.toInt().toString();
    }
    setState(() {
      sortBy = widget.sortBy;
      desc = widget.desc;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _TitleAndActions(
                apply: () {
                  Navigator.of(context).pop(FilterResult(
                    sortBy: sortBy,
                    desc: desc,
                    maxRating: double.tryParse(maxRatingController.text.trim()),
                    minRating: double.tryParse(minRatingController.text.trim()),
                  ));
                },
              ),
              const SizedBox(height: 10),

              Row(
                children: [
                  _RatingTextField(
                    controller: minRatingController,
                    label: 'Min rating'
                  ),
                  const SizedBox(width: 15),
                  _RatingTextField(
                    controller: maxRatingController,
                    label: 'Max rating'
                  ),
                ],
              ),

              if (minRatingController.text.isEmpty && maxRatingController.text.isEmpty) ...[
                const SizedBox(height: 20),

                Text('Sort', style: Theme.of(context).textTheme.subtitle1.apply(fontWeightDelta: 2)),

                _Sort(
                  desc: desc,
                  sortBy: sortBy,
                  onChange: (String sortBy, bool desc) {
                    setState(() {
                      this.sortBy = sortBy;
                      this.desc = desc;
                    });
                  },
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _TitleAndActions extends StatelessWidget {

  final void Function() apply;

  _TitleAndActions({
    this.apply,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Filter', style: Theme.of(context).textTheme.headline6),

        Row(children: [
          TextButton(onPressed: () {
            if (apply != null) {
              apply();
            }
          }, child: Text('Apply')),

          TextButton(onPressed: () {
            Navigator.of(context).pop();
          }, child: Text('Cancel')),
        ]),
      ],
    );
  }
}

class _RatingTextField extends StatelessWidget {

  final String label;
  final TextEditingController controller;

  _RatingTextField({
    this.label,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontWeight: FontWeight.w500),),
        const SizedBox(height: 4),
        SizedBox(
          width: 75,
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              isDense: true,
              contentPadding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
            ),
            keyboardType: TextInputType.number,
          ),
        ),
      ],
    );
  }
}

class _Sort extends StatelessWidget {

  final void Function(String, bool) onChange;
  final String sortBy;
  final bool desc;

  _Sort({this.onChange, this.sortBy, this.desc});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _SortChip(
          label: 'Name (A-Z)',
          isSelected: sortBy == 'name' && desc == false,
          onTap: () {
            if (onChange != null) {
              onChange('name', false);
            }
          }
        ),
        const SizedBox(width: 10),
        _SortChip(
          label: 'Name (Z-A)',
          isSelected: sortBy == 'name' && desc == true,
          onTap: () {
          if (onChange != null) {
            onChange('name', true);
          }
        }),
        const SizedBox(width: 10),
        _SortChip(
          label: 'Rating',
          isSelected: sortBy == 'averageRating' && desc == false,
          onTap: () {
            if (onChange != null) {
              onChange('averageRating', false);
            }
          }
        ),
      ],
    );
  }
}

class _SortChip extends StatelessWidget {

  final String label;
  final void Function() onTap;
  final EdgeInsetsGeometry padding;
  final bool isSelected;
 
  const _SortChip({
    this.label,
    this.padding,
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final backgroundColor = isSelected ? Theme.of(context).primaryColor : null;
    final textColor = isSelected ? Colors.white : Colors.black;

    return GestureDetector(
      child: Chip(
        label: Text(label, style: TextStyle(color: textColor)),
        padding: const EdgeInsets.only(left: 10, right: 10),
        backgroundColor: backgroundColor,
      ),
      onTap: onTap,
    );
  }
}
