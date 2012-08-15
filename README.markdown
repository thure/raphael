# Raphaël

Cross-browser vector graphics the easy way. Visit the library website for more information: [http://raphaeljs.com](http://raphaeljs.com/)

This fork is intended to add group functionality via the SVG `<g>` element and the VML `<v:group>` element.

The intended goal is only to be able to transform groups of elements the same way they can be transformed in their native MLs.

## Added functionality

####`Paper.group(Set)`:

**Set**: a `Raphael.Set` of `Element`s that you want to group.

**Returns**: `Raphael.Element` which has the group element at `.node` (like any other `Element`).

The `Set` and its constituent `Element`s all have a property `.group` which points to the resultant group-`Element`. The group-`Element`, likewise, has a `.set` property which points to the `Set` of its constituency.

## Words of caution

+ Although grouping works cross-browser, transforms don't work in VML mode because for whatever reason you can't add `skew` children to `group` elements. Also filters don't work (opacity is not preserved).
+ The alternative is to do recursive matrix math on all `skew` elements in possibly nested groups. We're finding time to do that, but haven't done that yet.