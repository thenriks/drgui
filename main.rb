require 'app/gui_manager.rb'
require 'app/text_box.rb'
require 'app/button.rb'

def new_game args
	print("new_game")
	args.state.start_new = true

	args.state.gui ||= GuiManager.new(args)

	args.state.btnUp ||= Button.new(args, :buttonU, "U", 461, 636, 64, 64, 180, 180, 180)
	args.state.gui.add_widget(args.state.btnUp)
	args.state.btnDown = Button.new(args, :buttonD, "D", 461, 500, 64, 64, 180, 180, 180)
	args.state.gui.add_widget(args.state.btnDown)

	args.state.main_text ||= TextBox.new(args, :main_text)
	args.state.main_text.set_position(15, 700)
	args.state.gui.add_widget(args.state.main_text)

	args.state.main_text.add_wrapped("Lorem [tag1]ipsum dolor sit amet, consectetur adipiscing elitteger dolor [tag2]velit, [tag3]ultricies vitae libero vel, aliquam [tag4]imperdiet enim.")
	args.state.main_text.add_wrapped("quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.")
	args.state.main_text.add_wrapped("Duis aute irure dolor in reprehenderit in voluptate velit esse
										cillum dolore eu [tag5]fugiat nulla pariatur.")

	args.state.gui.update_gui
end

def tick args
 	if !args.state.start_new
       new_game(args)
    end

	# for b in args.state.main_text.tags do
	# 	args.outputs.borders << b[:rect]
	# end

	atags = args.state.gui.handle_events
	
	if atags.any?
		for t in atags do
			#print ("\nWidget: #{t[:widget]} Type: #{t[:type]} Tag: #{t[:tag]}\n")
			#print("\n #{t} \n")

			if t[:type] == :button
				if t[:tag] == :buttonU
					args.state.main_text.scroll_up
				elsif t[:tag] == :buttonD
					args.state.main_text.scroll_down
				end
			elsif t[:type] == :link
				args.gtk.notify! "Widget: #{t[:widget]} Type: #{t[:type]} Tag: #{t[:tag]}"
			end
		end
	end

	args.state.gui.draw_gui

	if args.inputs.keyboard.key_down.up
		args.state.main_text.scroll_up
		args.state.gui.update_gui()
	elsif args.inputs.keyboard.key_down.down
		args.state.main_text.scroll_down
		args.state.gui.update_gui()
	elsif args.inputs.keyboard.key_down.i
		w = args.state.gui.get_widget(:main_text)
		w.add_wrapped("qwerty asdfg zxcvb")
		args.state.gui.update_gui()
		#print("\n #{w} \n")
	elsif args.inputs.keyboard.key_down.t
		print("\n #{atags} \n")
	elsif args.inputs.keyboard.key_down.w
		for w in args.state.gui.widgets do
			print("\n #{w.name}")
		end
	end
		
end
