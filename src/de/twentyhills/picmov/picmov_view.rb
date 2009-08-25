class PicmovView < ApplicationView
  set_java_class 'de.twentyhills.picmov.MainGUI'

  map :view => "source_folder_textfield.text", :model => :source_folder
  map :view => "target_folder_textfield.text", :model => :target_folder

  def load
    move_to_center()
  end

  define_signal :name => :init, :handler => :init
  def init(model, transfer)
    example_label_bottom.text=transfer[:rename_example]
    bottom.visible= false
  end

  define_signal :name => :start_moving, :handler => :begin_move
  def begin_move(model, transfer)
    bottom.visible=true
    progress_label.text="Beginne verschieben..."
  end

  define_signal :name => :progress, :handler => :progress
  def progress(model, transfer)
    progress_bar.value=transfer[:progress]
    progress_label.text="Verschiebe Datei #{transfer[:file]}"
  end

  :end_moving
  define_signal :name => :end_moving, :handler => :end_move
  def end_move(model, transfer)
    progress_label.text="Verschieben beendet."
  end

end
