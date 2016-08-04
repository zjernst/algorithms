require 'byebug'
require_relative 'graph'

# O(|V|**2 + |E|).
def dijkstra1(source)
  shortest_paths = {}
  possible_paths = {source => {cost: 0, parent: nil}}

  until possible_paths.empty?
    shortest = get_shortest(possible_paths)
    shortest_paths[shortest] = possible_paths[shortest]
    possible_paths.delete(shortest)
    update_paths(shortest, shortest_paths, possible_paths)
  end

  shortest_paths
end

def get_shortest(paths)
  paths.min_by{ |vertex, data| data[:cost]}[0]
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
