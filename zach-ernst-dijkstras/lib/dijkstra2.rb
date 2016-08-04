require_relative 'graph'
require_relative 'priority_map'

# O(|V| + |E|*log(|V|)).
def dijkstra2(source)
  shortest_paths = {}
  possible_paths = PriorityMap.new {|el1, el2| el1[:cost] <=> el2[:cost]}
  possible_paths[source] = { cost: 0, parent: nil }

  until possible_paths.empty?
    vertex, data = possible_paths.extract
    shortest_paths[vertex] = data
    update_paths(vertex, shortest_paths, possible_paths)
  end

  shortest_paths
end

def update_paths(vertex, shortest_paths, possible_paths)
  current_cost = shortest_paths[vertex][:cost]
  vertex.out_edges.each do |edge|
    next_vertex = edge.to_vertex
    next if shortest_paths[next_vertex]
    next_vertex_cost = current_cost + edge.cost

    if possible_paths[next_vertex] && possible_paths[next_vertex][:cost] <= next_vertex_cost
      next
    else
      possible_paths[next_vertex] = {
        cost: next_vertex_cost,
        parent: vertex
      }
    end
  end
end
