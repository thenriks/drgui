class Widget
    attr_reader :name, :tags, :target
    attr_accessor :state

    def initialize()
        @name = nil
        @tags = []
        # 1 = Hover, 2 = Pressed
        @state = 0
    end

    def rect
        return {x: 0, y: 0, w: 0, h: 0}
    end

    def draw()
    end

    def render()
    end
end