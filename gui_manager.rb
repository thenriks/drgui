class GuiManager
    attr_reader :tags, :widgets

    def initialize(args)
        @args = args
        @widgets = []
        # tags of all clickable elements
        @tags = []
        @mouse_down = false
        @state_changed = false
    end

    def add_widget(w)
        @widgets << w
        update_gui
    end

    def get_widget(s)
        for w in @widgets do
            if w.name == s
                return w
            end
        end

        return nil
    end

    # check hover and click events. Return clicked tags
    def handle_events
        events = []
        
        update_gui

        for w in @widgets do
            if @args.inputs.mouse.down
                @mouse_down = true
                @state_changed = true
            elsif @args.inputs.mouse.up
                @mouse_down = false
            end

            if @args.inputs.mouse.inside_rect?(w.rect)
                if !@mouse_down && w.state == 2
                    for t in w.tags do
                        if @args.inputs.mouse.inside_rect?(t.rect)
                            events << t
                        end
                    end
                    w.state = 1
                elsif !@mouse_down
                    w.state = 1
                    @state_changed = true
                elsif @mouse_down && @state_changed
                    w.state = 2

                    @state_changed = false
                end
            else
                w.state = 0
            end
        end

#        update_gui

        return events
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

        #print("\ntags: #{tags}\n")
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