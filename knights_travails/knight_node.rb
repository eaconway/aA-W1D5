class PolyTreeNode
  attr_accessor :value
  
  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end
  
  def parent
    @parent
  end
  
  def children
    @children
  end
  
  def value
    @value
  end
  
  
  def parent=(node)
    if node == nil
      @parent = nil
    elsif @parent != node
      @parent.children.delete(self) unless parent.nil?
      @parent = node
      node.children << self
    end
  end
  
  def add_child(child_node)
    child_node.parent = self unless child_node.parent == self
    @children << child_node unless @children.include?(child_node)
  end
  
  def remove_child(child_node)
    unless @children.include?(child_node) || child_node.parent == self
      raise "Error"
    end
    @children.delete(child_node)
    child_node.parent = nil
  end
  
  def dfs(target_value)
    return self if self.value == target_value
    
    @children.each do |child| 
      response = child.dfs(target_value)
      return response unless response.nil? 
    end 
    nil
  end
  
  def bfs(target_value)
    queue = [self] 
  
    until queue.empty?
      check = queue.shift 
      return check if check.value == target_value 
      queue += check.children
    end 
    nil
  end 
  
end