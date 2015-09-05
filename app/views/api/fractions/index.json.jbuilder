# TODO this might get too big; limit depth? use subtrees? limit to active fractions?
# TODO scope on a particular fraction, return subtree to a given depth
# could even skip levels:
#   scope on a fraction at depth 0, return children 3 levels deep
#   scope on a child of that fraction, return children 3 levels deep, but skip first 2 levels
#
# problem will probably only occur at the root level; most fractions will be independent
#
# index also needs name search function
json.roots @fractions do |fraction|
  json.partial! 'api/fractions/fraction_with_children', fraction: fraction
end
