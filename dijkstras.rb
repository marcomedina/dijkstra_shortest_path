class Graph
  def initialize
    @vertices = {}
  end

  def add_vertex name, edges
    @vertices[name] = edges
  end

  def shortest_path from, to
    
  end

  def to_s
    @vertices.inspect
  end
end

#Example
graph = Graph.new
graph.add_vertex(1, {2 => 7, 3 => 9, 6 => 14})
graph.add_vertex(2, {3 => 10, 4 => 15})
graph.add_vertex(3, {1 => 9, 2 => 10, 4 => 11, 6 => 2})
graph.add_vertex(4, {2 => 15, 5 => 6})
graph.add_vertex(5, {6 => 9, 4 => 6})
graph.add_vertex(6, {1 => 14, 3 => 2, 5 => 9})
p graph.to_s
