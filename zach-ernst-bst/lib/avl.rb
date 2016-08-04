class AVLTreeNode
  attr_accessor :link, :value

  def initialize(value)
    @value = value
    @link = [nil, nil]
    @balance = 0
  end
end

class AVLTree
  def initialize
    @root = nil
  end

  def insert(value)
    @root = AVLTree.insert!(@root, value)
  end

  def self.insert!(node, value)
    return AVLTreeNode.new(value) unless @root
    dir = value < node.value ? 0 : 1
    node.link[dir] = AVLTree.insert!(node.link[dir], value)

    node
  end

  def self.single_rotation!(root, dir)
    other_dir = dir == 0 ? 1 : 0
    save = root.link[other_dir]

    root.link[other_dir] = save.link[dir]
    save.link[dir] = root

    save
  end

  def self.double_rotation!(root, dir)
    other_dir = dir == 0 ? 1 : 0
    save = root.link[other_dir].link[dir]

    root.link[other_dir].link[dir] = save.link[other_dir]
    save.link[other_dir] = root.link[other_dir]
    root.link[other_dir] = save

    save = root.link[other_dir]
    root.link[other_dir] = save.link[dir]
    save.link[dir] = root

    save
  end
end
