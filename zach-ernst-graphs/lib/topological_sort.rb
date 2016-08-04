require_relative 'graph'

# Implementing topological sort using both Khan's and Tarian's algorithms

def topological_sort(vertices)
  in_edge_store = {}
  queue = []

  vertices.each do |vertex|
    in_edge_store[vertex] = vertex.in_edges.count
    queue << vertex if vertex.in_edges.empty?
  end

  ordered_vertices = []
  until queue.empty?
    current_vertex = queue.shift
    ordered_vertices << current_vertex
    current_vertex.out_edges.each do |edge|
      next_vertex = edge.to_vertex
      in_edge_store[next_vertex] -= 1
      queue << next_vertex if in_edge_store[next_vertex] == 0
    end
  end

  ordered_vertices
end

def topological_tarjan(vertices)
  ordered_vertices = []
  explored = Set.new

  vertices.each do |vertex|
    dfs(vertex, explored, ordered_vertices) unless explored.include?(vertex)
  end

  ordered_vertices
end

def dfs(vertex, explored, ordered_vertices)
  explored.add(vertex)
  vertex.out_edges.each do |edge|
    next_vertex = edge.to_vertex
    dfs(vertex, explored, ordered_vertices)
  end

  ordered_vertices.unshift(vertex)
end
