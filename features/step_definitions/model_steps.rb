# Allows the definition of data for testing in cucumber table format. This step extends
# the basic table support to also include support for referencing other, existing objects
# for setting up associations.
#
#   Given the following product records
#     | name   | price | manufacturer_by_name |
#     | Widget | 24.95 | Widgco               |
#     | Ting   | 39.99 | Thingamabob Inc.     |
#
# Will create 2 instances of the class named Product with the name and price set, as expected.
# Additionally, the column 'manufacturer_by_name' will cause a lookup as follows:
#
#   Manufacturer.find_by_name('Widgco')
#
# If no record is found, the Factory named 'manufacturer' will be called with the name set to 
# the table value (eg. 'Widgco').
#
# Once a record has been located or created, the association on Product named manufacturer will
# be set to that record.
#
# This enhanced feature is enabled by naming columns in the form:
#
#   <something>_by_<something else>
#
# <something> will be used as the name of the association on the records being created by the table.
# The class name specified on that association will be used in the find or build logic.
#
# <something else> will be used to build the finder method and if nothing is found, as a value passed
# into the Factory.
Given /^the following (.+) records?$/ do |factory, table|
  create_from_factory(factory, table.hashes)
end

Given /^this test is pending$/ do
  pending
end

# Given /^a? ?(.+) with (.+) of (.+)$/ do |model_name, attribute_names, attr_values|
#   factory_name = string_to_factory_name(model_name)
#   attribute_names = list_to_array(attribute_names)
#   attribute_values = list_to_array(attr_values)  
#   attribute_values.length.should == attribute_names.length
#   hash = {}
#   attribute_values.each_with_index do |value, i|
#     hash[attribute_names[i].to_sym] = value.gsub(/^\"/, '').gsub(/\"$/, '')
#   end
#   Factory.create(factory_name, hash)
# end

Then /^there should be (\d+) (.+)$/ do |count, model|
  klass = constant_for_name(model)
  klass.count.should == count.to_i
end