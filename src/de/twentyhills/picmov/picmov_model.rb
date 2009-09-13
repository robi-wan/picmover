require 'picmov'
class PicmovModel
  attr_accessor :source_folder
  attr_accessor :target_folder

  def initialize
    @source_folder=""
    @target_folder=""
  end

  def move_pictures(&progress)
    mover = PicMov::PictureMover.new(@source_folder, @target_folder)
              #save_setting()
    mover.move &progress

#    Thread.start() do
#      begin
#        #              mover = PictureMover.new(@source_folder.text, @target_folder.text)
#        #              save_setting()
#        #              mover.move do |file, percent|
#        #                progress.fraction = percent
#        #                message.text = "Verschiebe Datei #{file.source}"
#        (1..100).each do |n|
#          progress.call(n)
#        end
#
#        #              message.text ="Verschieben beendet."
#      rescue Exception => e
#        #              Shoes.error(e)
#        #              Shoes.show_log
#        #              @progress_area.hide
#      end



      #    mover_task = PicmovTask.new(self)
      #    mover_task.add_property_change_listener{|event| progress.call(event) }
      #    mover_task.execute()
    #end

  end
end

require 'java'
class PicmovTask < Java::javax.swing.SwingWorker

  def initialize(model)
    #this explicit call is necessare as SwingWorker just declares a default constructor but we want
    #get some arguments...
    super()
    puts "hello swing"
    @model=model
    @source=@model.source_folder
    @target=@model.target_folder
  end

  def do_in_background()
    (1..100).each do |n|
      set_progress(n)
      raise Exception.new("from background")
    end
  end

  #  def do_in_background()
  #    puts "hello swingworker"
  #              mover = PictureMover.new(@source, @target)
  #              #save_setting()
  #              mover.move do |file, percent|
  #                set_progress(percent)
  #                puts percent
  #                #message.text = "Verschiebe Datei #{file.source}"
  #              end
  #              #message.text ="Verschieben beendet."
  #
  #  end

end
