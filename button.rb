require "app/widget.rb"

class Button < Widget
    def initialize(args, name, text, x, y, w, h, r=255, g=255, b=255)
        @args = args
        @name = name
        @text = text
        @back = {}
        @label = {}
        @tags = []
        @x = x
        @y = y
        @w = w
        @h = h
        @r = r
        @g = g
        @b = b
    end

    def draw
        @tags = []
        @back = {x: @x, y: @y, w: @w, h: @h, r: @r, g: @g, b: @b}
        @tags << {widget: @name, type: :button, tag: @name, rect: {x: @x, y: @y, w: @w, h: @h}}
        center = @args.geometry.rect_center_point({x: @x, y: @y, w: @w, h: @h})
        @label = {x: center.x, y: center.y, text: @text, size_enum: 8, vertical_alignment_enum: 1, alignment_enum: 1}
    end

    def render
        @target = @name
        @args.render_target(@name).solids << @back
        @args.render_target(@name).labels << @label
    end
end