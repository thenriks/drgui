require "app/widget.rb"

class Button < Widget
    attr_reader :x, :y, :w, :h

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

    def rect
        return {x: @x, y: @y, w: @w, h: @h}
    end

    def draw
        @tags = []
        if @state == 0
            @back = {x: @x, y: @y, w: @w, h: @h, r: @r, g: @g, b: @b}
        elsif @state == 1
            @back = {x: @x, y: @y, w: @w, h: @h, r: @r-30, g: @g-30, b: @b-30}
        elsif @state == 2
            @back = {x: @x, y: @y, w: @w, h: @h, r: @r-60, g: @g-60, b: @b-60}
        end
        @tags << {widget: @name, type: :button, tag: @name, rect: {x: @x, y: @y, w: @w, h: @h}}
        center = @args.geometry.rect_center_point({x: @x, y: @y, w: @w, h: @h})
        @label = {x: center.x, y: center.y, text: @text, size_enum: 8, vertical_alignment_enum: 1, alignment_enum: 1}
    end

    def render
        @target = @name
        #@args.render_target(@name).solids << @back
        #@args.render_target(@name).labels << @label
        @args.outputs[@name].transient!
        @args.outputs[@name].solids << @back
        @args.outputs[@name].labels << @label
    end
end