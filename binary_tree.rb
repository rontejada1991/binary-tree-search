class BST
  attr_accessor :root

  class Node
    attr_accessor :value, :left, :right

    def initialize(value)
      @value = value
      @left = nil
      @right = nil
    end

    def contents
      left_node = @left.nil? ? nil : @left.value
      right_node = @right.nil? ? nil : @right.value
      return "Value: #{@value}, Left Child: #{left_node}, Right Child: #{right_node}"
    end
  end

  def build_tree(array)
    array.each do |element|
      insert(element)
    end
  end

  def insert(value)
    new_node = Node.new(value)

    if @root.nil?
      @root = new_node
    else
      focus_node = @root
      parent_node = nil

      while (true) do
        parent_node = focus_node

        if (new_node.value < focus_node.value)
          focus_node = focus_node.left
          if focus_node.nil?
            parent_node.left = new_node
            return
          end
        else
          focus_node = focus_node.right
          if focus_node.nil?
            parent_node.right = new_node
            return
          end
        end
      end
    end
  end

  def depth_first_search(value, current_node=@root, stack=[@root], visited=[@root])

    # Check if the current node is our value
    if current_node.value == value
      return current_node.contents
    end

    # Check for unvisited left node
    if current_node.left != nil && !visited.include?(current_node.left)
      visited << current_node.left
      stack << current_node.left
      current_node = visited.last
    # Check for unvisited right node
    elsif current_node.right != nil && !visited.include?(current_node.right)
      visited << current_node.right
      stack << current_node.right
      current_node = visited.last
    # Traversing backwards now that we are at a leaf node
    else
      stack.pop
      current_node = stack.last
    end

    if stack.empty?
      return nil
    else
      depth_first_search(value, current_node, stack, visited)
    end
  end

  def breadth_first_search(value, current_node=@root, queue=[], visited=[@root])

    # Check if the current node is our value
    if current_node.value == value
      return current_node.contents
    end

    # Check on the left
    if current_node.left != nil
      visited << current_node.left
      queue << current_node.left
    end

    # Check on the right
    if current_node.right != nil
      visited << current_node.right
      queue << current_node.right
    end

    # The current node is next in line, unless there are no more nodes to visit
    if queue.empty?
      return nil
    else
      current_node = queue.shift
      breadth_first_search(value, current_node, queue, visited)
    end
  end
end

my_array = [2, 10, 24, 33, 48, 52, 63, 79].shuffle
puts "#{my_array}"
my_bst = BST.new
my_bst.build_tree(my_array)
puts "BFS 33: #{my_bst.breadth_first_search(33)}"
puts "BFS 63: #{my_bst.breadth_first_search(63)}"
puts "BFS 23(NA): #{my_bst.breadth_first_search(23)}"
puts "DFS 24: #{my_bst.depth_first_search(24)}"
puts "DFS 52: #{my_bst.depth_first_search(52)}"
puts "DFS 8 (NA): #{my_bst.depth_first_search(8)}"
