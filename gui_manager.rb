class GuiManager
    attr_reader :tags

    def initialize(args)
        @args = args
        @widgets = []
        # tags of all clickable elements
        @tags = []
    end

    def add_widget(w)
        @widgets << w
        update_gui
    end

    def render
        for w in @widgets do
            w.render
        end
    end

    def update_gui()
        @tags = []
        for w in @widgets do
            w.draw
            w.render

            if w.tags != nil
                for t in w.tags do
                    @tags << t
                end
            end
        end

        print("\ntags: #{tags}\n")
    end

    def draw_gui
        for w in @widgets do
            if w.target != nil
                @args.outputs.sprites << {x: 0, y: 0, w: 1280, h: 720, 
				        			path: w.target, source_x: 0, source_y: 0, source_w: 1280, source_h: 720}
            end
        end
    end

    def update_tags
    end
end