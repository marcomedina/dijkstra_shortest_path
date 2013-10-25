require 'test/unit'
require_relative 'dijkstras'

class Graph_Test < Test::Unit::TestCase
  def setup
    @graph = Graph.new
  end

  def test_add_vertex
    @graph.add_vertex('A', {'B' => 1, 'C' => 2})
    assert_equal({"A"=>{"B"=>1, "C"=>2}}, @graph.instance_variable_get(:@vertices), "Failed to add vertex")
  end
end
