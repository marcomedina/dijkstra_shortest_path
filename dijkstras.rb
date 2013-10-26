class Graph
  def initialize
    @vertices = {}
    @INFINITY = 1 << 64
    @path = []
  end

  def add_vertex name, edges
    @vertices[name] = edges
  end

  def dijkstra from
    @distances = {}
    @previous = {}
    unvisited = @vertices.keys

    @vertices.each do |vertex, value|
      @distances[vertex] = @INFINITY
      @previous[vertex] = nil
    end
    @distances[from] = 0


    while unvisited.size > 0
      current_node = nil
      unvisited.each do |min|
        if (!current_node) or (@distances[min] && @distances[min] < @distances[current_node])
          current_node = min
        end
      end

      if @distances[current_node] == @INFINITY
        break
      end

      unvisited.delete current_node

      @vertices[current_node].each do |nei, value|
        alt = @distances[current_node] + @vertices[current_node][nei]
        if alt < @distances[nei]
          @distances[nei] = alt
          @previous[nei] = current_node
        end
      end
    end
  end

  def to_s
    @vertices.inspect
  end

  def shortest_path from, to
    dijkstra from
    get_path to
    @path
  end

  private
  def get_path to
    if !@previous[to].nil?
      get_path @previous[to]
    end
    @path << to
  end
end

#Example
graph = Graph.new
graph.add_vertex('A', {'B' => 7, 'C' => 8})
graph.add_vertex('B', {'A' => 7, 'F' => 2})
graph.add_vertex('C', {'A' => 8, 'F' => 6, 'G' => 4})
graph.add_vertex('D', {'F' => 8})
graph.add_vertex('E', {'H' => 1})
graph.add_vertex('F', {'B' => 2, 'C' => 6, 'D' => 8, 'G' => 9, 'H' => 3})
graph.add_vertex('G', {'C' => 4, 'F' => 9})
graph.add_vertex('H', {'E' => 1, 'F' => 3})

puts graph.shortest_path 'A', 'H'
