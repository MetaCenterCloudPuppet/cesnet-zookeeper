module Puppet::Parser::Functions
    newfunction(:array_search, :type => :rvalue, :doc => "Search the array and returns the index.") do |arguments|

    raise(Puppet::ParseError, "array_search(): Wrong number of arguments") if arguments.size != 2

    raise(Puppet::ParseError, "array_search(): Not an array") if !arguments[0].is_a?(Array)

    array = arguments[0]
    value = arguments[1]

    i = array.find_index(value)
    i ? i + 1 : 0
  end
end
