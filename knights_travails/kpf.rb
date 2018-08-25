require_relative "knight_node"

class KnightPathFinder
  attr_accessor :root_node, :visited_positions
  DIFFS = [[1,2], [-1,2], [1,-2], [-1,-1]]
  
  def self.valid_move(pos)
    pos_arr = []
    DIFFS.each do |diff|
      pos_arr << [pos.first+diff.first, pos.last+diff.last]
      pos_arr << [pos.first+diff.last, pos.last+diff.first]
    end
    
    pos_arr.select {|pos| (0..7).include?(pos.first) && (0..7).include?(pos.last)}
  end
  
  def initialize(root)
    @root_node = PolyTreeNode.new(root)
    
    @visited_positions = [root_node.value]
    build_move_tree
  end
  
  def build_move_tree
    queue = [@root_node] 
    
    until queue.empty?
      check = queue.shift 
      new_moves = new_move_positions(check.value)
      
      new_moves.each do |move|
        child = PolyTreeNode.new(move)
        check.add_child(child)
        queue << child 
      end 
    end
    
    @root_node.value
  end
  
  def new_move_positions(pos)
    valid_moves = KnightPathFinder.valid_move(pos)
    new_moves = valid_moves.reject {|pos| @visited_positions.include?(pos)}
    @visited_positions += new_moves
    new_moves
  end
  
  def find_path(end_pos)
    destination = @root_node.bfs(end_pos)
    
    trace_path_back(destination)
  end
  
  def trace_path_back(node)
    return [node.value] if node.parent == nil
    
    trace_path_back(node.parent) + [node.value]
  end
  
end