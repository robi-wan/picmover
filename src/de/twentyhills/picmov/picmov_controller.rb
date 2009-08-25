require 'picmov'

class PicmovController < ApplicationController
  set_model 'PicmovModel'
  set_view 'PicmovView'
  set_close_action :exit

  def init_view
    # todo FileNameModifier des PicMover verwenden!
    time_mapper = TimeMapper.new
    now = Time.now
    file = "#{now.strftime(time_mapper.file_pattern)}_DSC2134.jpg"
    transfer[:rename_example]="DSC2134.jpg => #{File.join(now.strftime(time_mapper.folder_pattern), file)}"
    signal(:init)
  end

  def update_my_model
    update_model(view_state.model, :source_folder, :target_folder)
  end

  def source_folder_button_action_performed(event)
    #todo update complete model
    update_my_model()
    show_folder_chooser(:source_folder, event)
#    update_model(view_state.model, :source_folder)
#    folder_chooser = com.jidesoft.swing.FolderChooser.new()
#    unless model.source_folder.empty? then
#      current_folder = folder_chooser.getFileSystemView().createFileObject(model.source_folder)
#    end
#    folder_chooser.setCurrentDirectory(current_folder)
#    folder_chooser.setFileHidingEnabled(true)
#    result = folder_chooser.showOpenDialog(event.get_source().getTopLevelAncestor())
#    if result == com.jidesoft.swing.FolderChooser::APPROVE_OPTION then
#      selected_file = folder_chooser.getSelectedFile()
#      if selected_file != nil then
#        folder = selected_file.to_s()
#      else
#        folder = "";
#      end
#      model.source_folder=folder
#      update_view
#      # das Mapping funktioniert nur mittels der update-* - Aufrufe
#      # Der Signalhandler ist an dieser Stelle unnötig
#      #      transfer[:source_folder] = folder
#      #      signal(:select_source_folder)
#    end
  end

  def target_folder_button_action_performed(event)
    #todo update complete model
    update_my_model()
    show_folder_chooser(:target_folder, event)
#    update_model(view_state.model, :target_folder)
#    folder_chooser = com.jidesoft.swing.FolderChooser.new()
#    unless model.target_folder.empty? then
#      current_folder = folder_chooser.getFileSystemView().createFileObject(model.target_folder)
#    end
#    folder_chooser.setCurrentDirectory(current_folder)
#    folder_chooser.setFileHidingEnabled(true)
#    result = folder_chooser.showOpenDialog(event.get_source().getTopLevelAncestor())
#    if result == com.jidesoft.swing.FolderChooser::APPROVE_OPTION then
#      selected_file = folder_chooser.getSelectedFile()
#      if selected_file != nil then
#        folder = selected_file.to_s()
#      else
#        folder = "";
#      end
#      model.target_folder=folder
#      # das Mapping funktioniert nur mittels der update-* - Aufrufe
#      update_view
#    end
  end

  def show_folder_chooser(target, event)
    my_folder_chooser = folder_chooser()
    unless model.send(target).empty? then
      current_folder = my_folder_chooser.getFileSystemView().createFileObject(model.send(target))
    end
    my_folder_chooser.setCurrentDirectory(current_folder)
    my_folder_chooser.setFileHidingEnabled(true)
    result = my_folder_chooser.showOpenDialog(event.get_source().getTopLevelAncestor())
    if result == com.jidesoft.swing.FolderChooser::APPROVE_OPTION then
      selected_file = my_folder_chooser.getSelectedFile()
      if selected_file != nil then
        folder = selected_file.to_s()
      else
        folder = "";
      end
      # durch attr_accessor :source wird eine Methode source und source= angelegt
      model.send("#{target}=", folder)
      # das Mapping funktioniert nur mittels der update-* - Aufrufe
      update_view
    end
  end

  def stop_button_action_performed
    # todo stop copying
    java.lang.System.exit(0)
  end

  def start_button_action_performed(event)
    # todo extends javax.swing.SwingWorker with a ruby class and let it execute moving...
    signal(:start_moving)
    repaint_while do
      model.move_pictures() do |file, percent|
        #if "progress".eql?(evt.property_name) then
          transfer[:progress]= percent*100
          transfer[:file]=file.source
          signal(:progress)
        #end
      end
      signal(:end_moving)
    end
  end

#  def start_button_action_performed(event)
#    signal(:start_moving)
#  class MySwingWorker < javax.swing.SwingWorker
#    #attr_accessor :button
#    def doInBackground
#      (1..10).each do |n|
#        puts "thread #{self.hashCode} working"
#        transfer[:progress]= n#.new_value
#        signal(:progress)
#        sleep(1)
#      end
#      #self.button.text = "Completed"
#      signal(:end_moving)
#    end
#  end
#
#  sw = MySwingWorker.new
#  #sw.button = start
#  sw.execute
#
#  end

  def folder_chooser
    #@folder_chooser ||=com.jidesoft.swing.FolderChooser.new()
    com.jidesoft.swing.FolderChooser.new()
  end
end
